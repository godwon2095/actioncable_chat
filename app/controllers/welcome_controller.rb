class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      @users = User.where.not(id: current_user.id)
      case1 = ChatRoom.where(user1_id: current_user.id)
      case2 = ChatRoom.where(user2_id: current_user.id)

      if case1.exists?
        @chatroom = case1.take
        @tmp = Alarm.where.not(user_id: current_user.id)
        @alarms = @tmp.where(chat_room_id: @chatroom)
      else
        @chatroom = case2.take
        @tmp = Alarm.where.not(user_id: current_user.id)
        @alarms = @tmp.where(chat_room_id: @chatroom)
      end
    end
  end
end
