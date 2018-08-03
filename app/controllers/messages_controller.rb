class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @message = current_user.messages.new
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  def chat_room
      case1 = ChatRoom.where(user1_id: current_user.id, user2_id: params[:id])
      case2 = ChatRoom.where(user2_id: current_user.id, user1_id: params[:id])

      if case1.exists?
        @chatroom = case1.take
        @messages = Message.where(chat_room_id: @chatroom.id)
        @message = current_user.messages.new
      elsif case2.exists?
        @chatroom = case2.take
        @messages = Message.where(chat_room_id: @chatroom.id)
        @message = current_user.messages.new
      else
        tmp_id = params[:id]
        current_user.id.to_i > params[:id].to_i ? @chatroom = ChatRoom.create(user1_id: params[:id], user2_id: current_user.id) : @chatroom = ChatRoom.create(user1_id: current_user.id, user2_id: tmp_id)
        @messages = Message.where(chat_room_id: @chatroom.id)
        @message = current_user.messages.new
      end
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.user = current_user
    @alarm = Alarm.create(content: @message.content,
                          user_id: current_user.id,
                          chat_room_id: @message.chat_room_id)
    respond_to do |format|
      if @message.save
        ActionCable.server.broadcast 'chatting_channel', content: @message.content, message_user: @message.user
        ActionCable.server.broadcast 'notification_channel', content: @alarm.content, alarm_user: @alarm.user
        format.js { head :ok }
      else

        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:content, :user_id, :chat_room_id)
    end
end
