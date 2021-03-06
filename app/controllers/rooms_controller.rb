class RoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    @room = Room.create
    @user_room1 = UserRoom.create(room_id: @room.id, user_id: current_user.id)
    @user_room2 = UserRoom.create(params.require(:user_room).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to @room
  end

  def show
    @room = Room.find(params[:id])

    if UserRoom.where(user_id: current_user.id, room_id: @room.id).present?
      @chats = @room.chats
      @chat = Chat.new
    else
      redirect_to users_path
    end
  end
end
