class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :messages
  # has_many :chat_rooms
  has_many :user1_relation, foreign_key: "user2_id", class_name: "ChatRoom"
	has_many :user1s, through: :user1_relation, source: :user1
	has_many :user2_relation, foreign_key: "user1_id", class_name: "CharRoom"
	has_many :user2s, through: :user2_relation, source: :user2
end
