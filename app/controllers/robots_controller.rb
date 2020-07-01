class RobotsController < ApplicationController
  def create
    @robot = Robot.create(robot_params)
    json_response(@robot, :created)
  end

  private

  def robot_params
    params.require(:robot).permit(:robot_type, :name, :serial_number, armors_attributes: [:id, :armor_type], weapons_attributes: [:id, :weapon_type])
  end
end
