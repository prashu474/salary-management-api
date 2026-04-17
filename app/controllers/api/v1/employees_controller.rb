class Api::V1::EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :update, :destroy]

  # GET /api/v1/employees
  def index
    @employees = Employee.includes(:job_title, :department, :work_location, :manager)

    # Filtering
    @employees = @employees.where(status: params[:status]) if params[:status].present?
    @employees = @employees.by_department(params[:department_id]) if params[:department_id].present?
    @employees = @employees.by_job_title(params[:job_title_id]) if params[:job_title_id].present?
    @employees = @employees.joins(:work_location).where(work_locations: { country_code: params[:country_code] }) if params[:country_code].present?
    @employees = @employees.search(params[:search]) if params[:search].present?

    # Sorting
    sort_by = params[:sort_by] || 'last_name'
    sort_order = params[:sort_order] || 'asc'
    @employees = @employees.order("#{sort_by} #{sort_order}")

    # Pagination
    page = (params[:page] || 1).to_i
    per_page = [(params[:per_page] || 50).to_i, 100].min # Max 100 per page
    @employees = @employees.offset((page - 1) * per_page).limit(per_page)

    # Get total count for pagination metadata
    total = Employee.count
    total_pages = (total.to_f / per_page).ceil

    render json: {
      data: @employees.as_json(
        include: {
          job_title: { only: [:id, :title, :level, :category] },
          department: { only: [:id, :name, :code] },
          work_location: { only: [:id, :country_code, :country_name, :city, :office_name] },
          manager: { only: [:id, :first_name, :last_name, :email], methods: [:full_name] }
        },
        methods: [:full_name, :tenure_months]
      ),
      meta: {
        total: total,
        page: page,
        per_page: per_page,
        total_pages: total_pages
      }
    }
  end

  # GET /api/v1/employees/:id
  def show
    render json: {
      data: @employee.as_json(
        include: {
          job_title: { only: [:id, :title, :level, :category] },
          department: { only: [:id, :name, :code] },
          work_location: { only: [:id, :country_code, :country_name, :city, :office_name, :timezone] },
          manager: { only: [:id, :first_name, :last_name, :email], methods: [:full_name] },
          direct_reports: { only: [:id, :first_name, :last_name, :email, :job_title_id], methods: [:full_name] },
          salary_histories: { only: [:id, :previous_salary, :new_salary, :currency, :effective_date, :change_reason, :notes] }
        },
        methods: [:full_name, :tenure_months]
      )
    }
  end

  # POST /api/v1/employees
  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      # Create initial salary history
      SalaryHistory.create!(
        employee: @employee,
        previous_salary: 0,
        new_salary: @employee.salary,
        currency: @employee.currency,
        effective_date: @employee.salary_effective_date,
        change_reason: 'initial',
        notes: 'Initial salary for new employee'
      )

      render json: {
        data: @employee.as_json(
          include: {
            job_title: { only: [:id, :title] },
            department: { only: [:id, :name] },
            work_location: { only: [:id, :country_name, :city] }
          },
          methods: [:full_name]
        )
      }, status: :created
    else
      render json: {
        errors: @employee.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/employees/:id
  def update
    if @employee.update(employee_params)
      render json: {
        data: @employee.as_json(
          include: {
            job_title: { only: [:id, :title] },
            department: { only: [:id, :name] },
            work_location: { only: [:id, :country_name, :city] }
          },
          methods: [:full_name]
        )
      }
    else
      render json: {
        errors: @employee.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/employees/:id
  def destroy
    # Soft delete by setting status to terminated
    if @employee.update(status: 'terminated', termination_date: Date.today)
      render json: { message: 'Employee terminated successfully' }, status: :ok
    else
      render json: {
        errors: @employee.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Employee not found' }, status: :not_found
  end

  def employee_params
    params.require(:employee).permit(
      :employee_id, :first_name, :last_name, :email, :phone,
      :date_of_birth, :hire_date, :termination_date, :status,
      :job_title_id, :department_id, :employment_type,
      :work_location_id, :manager_id, :salary, :currency,
      :salary_effective_date
    )
  end
end
