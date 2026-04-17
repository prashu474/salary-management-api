class SalaryHistory < ApplicationRecord
  # Associations
  belongs_to :employee

  # Validations
  validates :previous_salary, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :new_salary, presence: true, numericality: { greater_than: 0 }
  validates :currency, presence: true, length: { is: 3 }
  validates :effective_date, presence: true
  validates :change_reason, presence: true,
                            inclusion: { in: %w[annual_review promotion market_adjustment correction other initial] }

  # Scopes
  scope :for_employee, ->(employee_id) { where(employee_id: employee_id).order(effective_date: :desc) }
  scope :recent, -> { order(effective_date: :desc).limit(10) }

  # Instance methods
  def salary_change_amount
    new_salary - previous_salary
  end

  def salary_change_percentage
    return 0 if previous_salary.zero?
    ((new_salary - previous_salary) / previous_salary * 100).round(2)
  end
end
