class ChatsChannel < ApplicationCable::Channel
  def subscribed
  	stream_from "chats_channel_#{params[:user_id]}"
  end

  def unsubscribed
 		stop_all_streams
  end
end