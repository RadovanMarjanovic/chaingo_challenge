class Robot < ApplicationRecord
  has_many :armors, dependent: :destroy
  has_many :weapons, dependent: :destroy

  validates :robot_type, presence: true, inclusion: { in: %w(hackerobot protectobot tacticrobot) }
  validates :name, presence: true, uniqueness: true
  validates :serial_number, uniqueness: true

  accepts_nested_attributes_for :weapons, :armors, allow_destroy: true
end
