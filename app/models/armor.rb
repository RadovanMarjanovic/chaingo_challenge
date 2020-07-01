class Armor < ApplicationRecord
  include SerialsUuidConcern

  belongs_to :robot

  validates :armor_type, presence: true, inclusion: { in: %w(shield magnetic\ field invisible field) }
  validates :serial_number, uniqueness: true
end
