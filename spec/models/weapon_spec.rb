require 'rails_helper'

RSpec.describe Weapon, type: :model do
  before do
    @weapon = FactoryBot.create(:weapon)
  end

  subject { @weapon }

  it { should respond_to(:uuid) }
  it { should respond_to(:serial_number) }
  it { should respond_to(:robot_id) }
end
