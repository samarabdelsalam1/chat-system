class CreateApplications < ActiveRecord::Migration[7.2]
  def change
    create_table :applications do |t|
      t.string :token, null: false
      t.string :name, null: false
      t.integer :chats_count, null: false, default: 0
      t.timestamps
    end
    add_index :applications, :token, unique: true
  end
end
