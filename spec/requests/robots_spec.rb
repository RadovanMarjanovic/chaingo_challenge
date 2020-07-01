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
      #FactoryBot.create(:robot, robot_type: "hackerobot", name: "hackerobot4")
      post '/robots', params: {robot: {robot_type: "tacticrobot", name: "hackerobot5"}}
      puts response.body
      expect(JSON.parse(response.body)["errors"][0]).to eq "Name has already been taken"
    end
  end
end
