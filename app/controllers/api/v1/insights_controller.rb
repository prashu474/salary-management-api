class Api::V1::InsightsController < ApplicationController
  # GET /api/v1/insights/salary_by_country
  def salary_by_country
    status = params[:status] || 'active'

    insights = WorkLocation.joins(:employees)
                          .where(employees: { status: status })
                          .group('work_locations.country_code', 'work_locations.country_name')
                          .select(
                            'work_locations.country_code',
                            'work_locations.country_name',
                            'COUNT(employees.id) as employee_count',
                            'MIN(employees.salary) as min_salary',
                            'MAX(employees.salary) as max_salary',
                            'AVG(employees.salary) as avg_salary',
                            'employees.currency'
                          )
                          .group('employees.currency')
                          .order('employee_count DESC')

    render json: {
      data: insights.map do |insight|
        {
          country_code: insight.country_code,
          country_name: insight.country_name,
          employee_count: insight.employee_count,
          min_salary: insight.min_salary.to_f.round(2),
          max_salary: insight.max_salary.to_f.round(2),
          avg_salary: insight.avg_salary.to_f.round(2),
          currency: insight.currency
        }
      end
    }
  end

  # GET /api/v1/insights/salary_by_job_title
  def salary_by_job_title
    country_code = params[:country_code]
    status = params[:status] || 'active'

    query = Employee.joins(:job_title, :work_location)
                   .where(status: status)

    query = query.where(work_locations: { country_code: country_code }) if country_code.present?

    insights = query.group('job_titles.id', 'job_titles.title', 'job_titles.level', 'job_titles.category', 'work_locations.country_code', 'employees.currency')
                   .select(
                     'job_titles.id as job_title_id',
                     'job_titles.title',
                     'job_titles.level',
                     'job_titles.category',
                     'work_locations.country_code',
                     'COUNT(employees.id) as employee_count',
                     'MIN(employees.salary) as min_salary',
                     'MAX(employees.salary) as max_salary',
                     'AVG(employees.salary) as avg_salary',
                     'employees.currency'
                   )
                   .having('COUNT(employees.id) > 0')
                   .order('job_titles.category, job_titles.level, job_titles.title')

    render json: {
      data: insights.map do |insight|
        {
          job_title_id: insight.job_title_id,
          title: insight.title,
          level: insight.level,
          category: insight.category,
          country_code: insight.country_code,
          employee_count: insight.employee_count,
          min_salary: insight.min_salary.to_f.round(2),
          max_salary: insight.max_salary.to_f.round(2),
          avg_salary: insight.avg_salary.to_f.round(2),
          currency: insight.currency
        }
      end
    }
  end

  # GET /api/v1/insights/dashboard
  def dashboard
    status = params[:status] || 'active'

    # Overall statistics
    total_employees = Employee.where(status: status).count
    avg_salary = Employee.where(status: status).average(:salary).to_f.round(2)
    avg_tenure = Employee.where(status: status).average('TIMESTAMPDIFF(MONTH, hire_date, CURDATE())').to_f.round(1)

    # Department breakdown
    departments = Department.joins(:employees)
                           .where(employees: { status: status })
                           .group('departments.id', 'departments.name', 'departments.code')
                           .select(
                             'departments.id',
                             'departments.name',
                             'departments.code',
                             'COUNT(employees.id) as employee_count',
                             'AVG(employees.salary) as avg_salary'
                           )
                           .order('employee_count DESC')

    # Recent hires (last 30 days)
    recent_hires = Employee.where(status: status)
                          .where('hire_date >= ?', 30.days.ago)
                          .count

    # Salary distribution
    salary_ranges = [
      { range: '0-50k', min: 0, max: 50_000 },
      { range: '50-75k', min: 50_000, max: 75_000 },
      { range: '75-100k', min: 75_000, max: 100_000 },
      { range: '100-150k', min: 100_000, max: 150_000 },
      { range: '150-200k', min: 150_000, max: 200_000 },
      { range: '200k+', min: 200_000, max: Float::INFINITY }
    ]

    salary_distribution = salary_ranges.map do |range|
      count = Employee.where(status: status)
                     .where('salary >= ? AND salary < ?', range[:min], range[:max])
                     .count
      { range: range[:range], count: count }
    end

    render json: {
      data: {
        overview: {
          total_employees: total_employees,
          avg_salary: avg_salary,
          avg_tenure_months: avg_tenure,
          recent_hires: recent_hires
        },
        departments: departments.map do |dept|
          {
            id: dept.id,
            name: dept.name,
            code: dept.code,
            employee_count: dept.employee_count,
            avg_salary: dept.avg_salary.to_f.round(2)
          }
        end,
        salary_distribution: salary_distribution
      }
    }
  end
end
