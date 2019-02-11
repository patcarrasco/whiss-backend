class MessagesChannel < ApplicationCable::Channel
  def subscribed
    chat = Chat.find(params[:chat_id])
    stream_from "message_#{chat.id}"
    ActionCable.server.broadcast "message_#{chat.id}", serialize(chat.messages)
  end

  def unsubscribed
  end

  def receive(data)
    message = data["message"]
    recipients = data["recipients"]
    puts data
    self.create_message(message, recipients)
  end

  def create_message(message, recipients)

    new_message = Message.new(message)

    if (new_message.save)
      puts "received message on backend #{recipients}"
      recipients.each do |user|
        # Send notification to each recipient
        ActionCable.server.broadcast("chat_#{user['id']}", "New message in #{new_message.chat.title}")
      end

      # Send the message
      ActionCable.server.broadcast "message_#{new_message.chat.id}", serialize(new_message)
    end
  end

  def serialize(data)
    MessageSerializer.new(data).serialized_json
  end
  def serialize_notification(data)
    NotificationSerializer.new(data).serialized_json
  end

  private
end