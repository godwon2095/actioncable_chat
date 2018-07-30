class Message < ApplicationRecord
  belongs_to :user
  # belongs_to :chat_room
  # after_save :set_chat_room
  #
  # def set_chat_room
  #   chat_room_id =
  # end
end
