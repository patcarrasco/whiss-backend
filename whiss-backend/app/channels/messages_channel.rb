class MessagesChannel < ApplicationCable::Channel
  def subscribed
    chat = Chat.find(params[:chat_id])
    stream_from "message_#{chat.id}"
    ActionCable.server.broadcast "message_#{chat.id}", serialize(chat.messages)
  end

  def unsubscribed
  end

  def receive(data)
    # Create New Message
    puts "received message on backend #{data}"
  end

  def serialize(data)
    MessageSerializer.new(data).serialized_json
  end
end