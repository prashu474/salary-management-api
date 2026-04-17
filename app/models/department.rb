class Department < ApplicationRecord
  # Associations
  belongs_to :parent_department, class_name: 'Department', optional: true
  has_many :sub_departments, class_name: 'Department', foreign_key: 'parent_department_id', dependent: :nullify
  has_many :employees, dependent: :restrict_with_error

  # Validations
  validates :name, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :code, presence: true, uniqueness: true, length: { maximum: 20 }

  # Prevent circular references
  validate :cannot_be_its_own_parent

  private

  def cannot_be_its_own_parent
    if parent_department_id == id
      errors.add(:parent_department_id, "cannot be the same as the department")
    end
  end
end
