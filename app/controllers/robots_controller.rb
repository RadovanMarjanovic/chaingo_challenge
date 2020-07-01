class RobotsController < ApplicationController
  before_action :set_robot, only: [:update, :destroy]

  def create
    @robot = Robot.create(robot_params)
    json_response(@robot, :created)
  end

  def index
    sql_query = "\
        robots.robot_type ILIKE :query \
        OR robots.name ILIKE :query \
        OR robots.serial_number ILIKE :query \
        OR weapons.weapon_type ILIKE :query \
        OR weapons.serial_number ILIKE :query \
        OR armors.armor_type ILIKE :query \
        OR armors.serial_number ILIKE :query \
        "
    @robots = Robot.left_joins(:weapons).left_joins(:armors).where(sql_query, query: "%#{params[:query]}%")
    render json: @robots, status: :ok
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
