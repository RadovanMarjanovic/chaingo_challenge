require 'rails_helper'

RSpec.describe Robot, type: :model do
  before do
    @robot = FactoryBot.create(:robot)
  end

  subject { @robot }

  it { should respond_to(:name) }
  it { should respond_to(:uuid) }
  it { should respond_to(:serial_number) }
  it { should respond_to(:robot_type) }
end
