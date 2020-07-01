class RobotsController < ApplicationController
  before_action :set_robot, only: [:update, :destroy]

  def create
    @robot = Robot.create(robot_params)
    json_response(@robot, :created)
  end

  def update
    @robot.update(robot_params)
    json_response(@robot,:ok)
  end

  def destroy
    @robot.destroy
    head :no_content
  end

  private

  def robot_params
    params.require(:robot).permit(:robot_type, :name, :serial_number, armors_attributes: [:id, :armor_type], weapons_attributes: [:id, :weapon_type])
  end

  def set_robot
    @robot = Robot.find(params[:id])
  end
end
