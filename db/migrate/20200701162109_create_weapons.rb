class CreateWeapons < ActiveRecord::Migration[6.0]
  def change
    create_table :weapons do |t|
      t.uuid :uuid
      t.string :weapon_type
      t.string :serial_number
      t.references :robot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
