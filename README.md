# README

Creating new project:
  I created a repository on github and created the new project by running these commands
  rails new chaingo_challenge --api -d=postgresql
  git add .
  git commit -m "First commit"
  git remote add origin git@github.com:RadovanMarjanovic/chaingo_challenge.git
  git push origin master

Create and set DB in psql
  I created a user chaingo_challenge and 2 DB
    - chaingo_challenge_development
    - chaingo_challenge_test
  ...and granted all privilages on the DB to the above mentioned user.

  Also I have configured the test and development DB in the database.yml file.

Enable the PostgreSQL extension for UUID:
  Since the insturctions require the uuid I have enabled the extention for UUID, by creating a migration as follows:
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
  end

  Additionally I kept the ID numbers, because I have used them to create serial numbers, by creating a function that composes a serial number from the first letter of the class.name, 0s and id number.

Create Models:
  I created 3 models (Robot, Weapon, Armor). Weapon and Armor are including a robot_id foreign key.
    - rails g model Robot uuid:uuid robot_type name serial_number
    - rails g model Weapon uuid:uuid weapon_type serial_number robot:references
    - rails g model Armor uuid:uuid armor_type serial_number robot:references

  I added the validations for each model, and added a line of code to the Robot model, to accept nested attributes, this way, we can create, update and delete weapons and armors through robots to which they belong to.
    - accepts_nested_attributes_for :weapons, :armors

Create routes:
  I created routes only for the 4 actions requested in the instructions as follows
    - resources :robots, only: [ :create, :update, :index, :destroy ]

Set up rspec, factory bot, database cleaner, faker
  - Rspec - for testing
  - database cleaner - to clean the DB before each test
  - factory bot and faker, to help create fake robots, armors and weapons for the purpose of testing.

Generate Robot controller and request rspec for Robots

  - I made a helper function json_response which responds with JSON. I defined this method in the concerns folder
  - in order for the controller to know about it, I indluded it into the application controller.
  - When I test the api call, the uuid and serial number are null. That's why I created a module SerialsUuidConcern, including after_create :add_serial_number and after_create :add_uuid, which add the respected missing values.
  - I included SerialsUuidConcern into each model and it will generate the serial numbers and uuid and update after every create.

Tests and Robot controller
  - I created tests for each action (#create, #index, #update, #delete)

Model tests
  - I created a test for each model to check if it responds to all attributes

Manual tests
  - I tested the API through POSTMAN, by making the calls as mentioned below in the short API documentation




API documentation:

Robot #create
METHOD: POST
URL: {SERVER_URL}/robots
{
  "robot": {
    "robot_type": "hackerobot",
    "name": "hackerobot1",
    "armors_attributes": [{
      "armor_type": "shield"
    }],
    "weapons_attributes": [{
      "weapon_type": "laser"
    }]
  }
}

Robot #index
METHOD: GET
URL: {SERVER_URL}/robots?query=hack
(to search through all attributes and check if they include "hack")

Robot #update
METHOD: PATCH
URL: {SERVER_URL}/robots/{ROBOT_ID}
{
  "id": "1",
  "robot": {
      "robot_type": "hackerobot",
      "name": "updated_name1",
      "weapons_attributes": [{
        "id": "1",
        "weapon_type": "acid"
      }]
  }
}


Robot #delete
METHOD: DELETE
URL: {SERVER_URL}/robots/{ROBOT_ID}


























#
