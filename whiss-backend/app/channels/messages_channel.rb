class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "message_#{params[:chat_id]}"
  end

  def unsubscribed
  end

  def receive(data)
    puts "received message on backend #{data}"
  end

  def serialize(data)
		MessageSerializer.new(data).serialized_json
	end
end