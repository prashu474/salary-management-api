class JobTitle < ApplicationRecord
  # Associations
  has_many :employees, dependent: :restrict_with_error

  # Validations
  validates :title, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :level, presence: true
  validates :category, presence: true, length: { maximum: 50 }

  # Enums for level
  LEVELS = %w[IC1 IC2 IC3 IC4 IC5 IC6 M1 M2 M3 M4 Executive].freeze

  validates :level, inclusion: { in: LEVELS }
end
