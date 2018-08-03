class CreateAlarms < ActiveRecord::Migration[5.2]
  def change
    create_table :alarms do |t|
      t.string :title
      t.text :content
      t.references :user
      t.references :chat_room

      t.timestamps
    end
  end
end
