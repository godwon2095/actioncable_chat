class CreateChatRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_rooms do |t|
      t.integer :user1_id
	    t.integer :user2_id

      t.timestamps
    end
    add_index :chat_rooms, :user1_id
    add_index :chat_rooms, :user2_id
    add_index :chat_rooms, [:user1_id, :user2_id], unique: true
  end
end
