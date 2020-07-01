FactoryBot.define do
  factory :robot do
    name {Faker::Name.unique.name }
    robot_type { "tacticrobot" }
  end
end
