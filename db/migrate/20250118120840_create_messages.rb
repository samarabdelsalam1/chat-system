class CreateMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :messages do |t|
      t.references :chat, foreign_key: true, null: false
      t.integer :number, null: false
      t.text :body, null: false
      t.timestamps
    end
    add_index :messages, %i[number chat_id], unique: true
  end
end
