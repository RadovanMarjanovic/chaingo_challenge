require 'rails_helper'

RSpec.describe "Robots", type: :request do
  describe "#create" do
    it "expects to create a new robot without weapons and armors" do
      expect {
        post '/robots', params: {robot: {robot_type: "hackerobot", name: "hackerobot1"}}}.to change { Robot.count }.by(1)
    end

    it "expects to create a new robot with armor" do
      expect {
        post '/robots', params: {robot: {robot_type: "hackerobot", name: "hackerobot2",
        armors_attributes: [{
          armor_type: "shield"
        }],
      }}}.to change { Armor.count }.by(1)
    end

    it "expects to create a new robot with weapon" do
      expect {
        post '/robots', params: {robot: {robot_type: "hackerobot", name: "hackerobot3",
        weapons_attributes: [{
          weapon_type: "laser"
        }]
      }}}.to change { Weapon.count }.by(1)
    end

    it "expects to return error if wrong param passed" do
        post '/robots', params: {robot: {robot_type: "nohackerobot", name: "hackerobot4"}}
        expect(JSON.parse(response.body)["errors"][0]).to eq "Robot type is not included in the list"
    end

    it "expects to return error if name already taken" do
      post '/robots', params: {robot: {robot_type: "hackerobot", name: "hackerobot5"}}
      #FactoryBot.create(:robot, robot_type: "hackerobot", name: "hackerobot5")
      post '/robots', params: {robot: {robot_type: "tacticrobot", name: "hackerobot5"}}
      expect(JSON.parse(response.body)["errors"][0]).to eq "Name has already been taken"
    end
  end

  describe "#index" do
    it "return an array of robots with type hackerobot" do
      2.times { FactoryBot.create(:robot, robot_type: "hackerobot") }
      post '/robots', params: {robot: {robot_type: "tacticrobot", name: "hakerobot7"}}
      get '/robots?query=hackerobot'
      expect(JSON.parse(response.body).length).to eq(2)
    end

    it "return an array of all robots if no search param is given" do
      4.times { FactoryBot.create(:robot) }
      get '/robots'
      expect(JSON.parse(response.body).length).to eq(4)
    end
  end

  describe "#update" do
    it "updates robot name" do
      robot = FactoryBot.create(:robot, name: "hackerobot1")
      patch "/robots/#{robot.id}", params: {robot: {robot_type: "hackerobot", name: "Updated name"}}
      expect(robot.reload.name).to eq "Updated name"
    end
  end

  describe "#destroy" do
    it "destroys a robot" do
      robot = FactoryBot.create(:robot)
      expect{delete "/robots/#{robot.id}"}.to change { Robot.count }.by(-1)
    end

    it "destroys armor when destroying the robot it belongs to" do
      robot = FactoryBot.create(:robot)
      armor = FactoryBot.create(:armor, robot: robot)
      expect{delete "/robots/#{robot.id}"}.to change { Armor.count }.by(-1)
    end
  end
end
