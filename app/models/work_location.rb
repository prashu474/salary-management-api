class WorkLocation < ApplicationRecord
  # Associations
  has_many :employees, dependent: :restrict_with_error

  # Validations
  validates :country_code, presence: true, length: { is: 2 }
  validates :country_name, presence: true, length: { maximum: 100 }
  validates :city, presence: true, length: { maximum: 100 }
  validates :office_name, length: { maximum: 100 }, allow_nil: true
  validates :timezone, presence: true, length: { maximum: 50 }

  # Unique combination validation
  validates :office_name, uniqueness: { scope: [:country_code, :city] }

  # Scope for querying
  scope :by_country, ->(country_code) { where(country_code: country_code) }
end
