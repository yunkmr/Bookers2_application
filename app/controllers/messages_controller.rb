class MessagesController < ApplicationController

  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id)
    user_room = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    if user_room.nil?
      room = Room.new
      room.save
      UserRoom.create(user_id: current_user.id, room_id: room.id)
      UserRoom.create(user_id: @user.id, room_id: room.id)
    else
      room = user_room.room
    end

    @messages = room.messages
    @message = Message.new(room_id: room.id)
  end

  def create
    @message = current_user.messages.new(params_message)
    @message.save
    redirect_to request.referer
  end

  private

  def params_message
    params.require(:message).permit(:message, :room_id)
  end

end
