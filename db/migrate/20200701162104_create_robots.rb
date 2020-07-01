class CreateRobots < ActiveRecord::Migration[6.0]
  def change
    create_table :robots do |t|
      t.uuid :uuid
      t.string :robot_type
      t.string :name
      t.string :serial_number

      t.timestamps
    end
  end
end
