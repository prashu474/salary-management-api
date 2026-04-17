class Employee < ApplicationRecord
  # Associations
  belongs_to :job_title
  belongs_to :department
  belongs_to :work_location
  belongs_to :manager, class_name: 'Employee', optional: true
  has_many :direct_reports, class_name: 'Employee', foreign_key: 'manager_id', dependent: :nullify
  has_many :salary_histories, dependent: :destroy

  # Validations
  validates :employee_id, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :first_name, presence: true, length: { maximum: 100 }
  validates :last_name, presence: true, length: { maximum: 100 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, length: { maximum: 20 }, allow_nil: true
  validates :hire_date, presence: true
  validates :status, presence: true, inclusion: { in: %w[active on_leave terminated] }
  validates :employment_type, presence: true, inclusion: { in: %w[full_time part_time contract intern] }
  validates :salary, presence: true, numericality: { greater_than: 0 }
  validates :currency, presence: true, length: { is: 3 }
  validates :salary_effective_date, presence: true

  # Custom validations
  validate :termination_date_after_hire_date
  validate :cannot_be_own_manager

  # Callbacks
  after_update :create_salary_history, if: :saved_change_to_salary?

  # Scopes
  scope :active, -> { where(status: 'active') }
  scope :by_country, ->(country_code) { joins(:work_location).where(work_locations: { country_code: country_code }) }
  scope :by_department, ->(department_id) { where(department_id: department_id) }
  scope :by_job_title, ->(job_title_id) { where(job_title_id: job_title_id) }
  scope :search, ->(query) do
    where('first_name LIKE ? OR last_name LIKE ? OR email LIKE ? OR employee_id LIKE ?',
          "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")
  end

  # Instance methods
  def full_name
    "#{first_name} #{last_name}"
  end

  def tenure_months
    end_date = termination_date || Date.today
    ((end_date.year * 12 + end_date.month) - (hire_date.year * 12 + hire_date.month))
  end

  private

  def termination_date_after_hire_date
    if termination_date.present? && hire_date.present? && termination_date < hire_date
      errors.add(:termination_date, "must be after hire date")
    end
  end

  def cannot_be_own_manager
    if manager_id == id
      errors.add(:manager_id, "cannot be the employee themselves")
    end
  end

  def create_salary_history
    SalaryHistory.create!(
      employee: self,
      previous_salary: salary_before_last_save,
      new_salary: salary,
      currency: currency,
      effective_date: salary_effective_date,
      change_reason: 'update',
      notes: "Salary updated from #{salary_before_last_save} to #{salary}"
    )
  end
end
