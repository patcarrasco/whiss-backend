class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "messages_channel_#{params[:chat_id]}"
  end

  def unsubscribed
  	stop_all_streams
  end

  def speak(data)
  	new_message = Message.new(data["data"])
  	if (new_message.save)
	  	ActionCable.server.broadcast "messages_channel_#{new_message.chat_id}", serialize(new_message)
  	else
  		puts "Bad!!!!!!!!!!!!!!!!!!!!!!!!"
  	end
  end

  def serialize(data)
		MessageSerializer.new(data).serialized_json
	end
end