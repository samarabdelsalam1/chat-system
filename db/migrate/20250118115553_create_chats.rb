class CreateChats < ActiveRecord::Migration[7.2]
  def change
    create_table :chats do |t|
      t.references :application, foreign_key: true, null: false
      t.integer :number, null: false
      t.integer :messages_count, default: 0
      t.timestamps
    end
    add_index :chats, %i[number application_id], unique: true
  end
end
