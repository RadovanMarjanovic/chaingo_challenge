class Weapon < ApplicationRecord
  belongs_to :robot

  validates :weapon_type, presence: true, inclusion: { in: %w(laser code acid map) }
  validates :serial_number, uniqueness: true
end
