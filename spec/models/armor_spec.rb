require 'rails_helper'

RSpec.describe Armor, type: :model do
  before do
    @armor = FactoryBot.create(:armor)
  end

  subject { @armor }

  it { should respond_to(:uuid) }
  it { should respond_to(:serial_number) }
  it { should respond_to(:robot_id) }
end
