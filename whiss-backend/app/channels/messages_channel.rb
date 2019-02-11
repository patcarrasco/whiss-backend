class MessagesChannel < ApplicationCable::Channel
  def subscribed
    chat = Chat.find(params[:chat_id])
    stream_from "message_#{chat.id}"
    ActionCable.server.broadcast "message_#{chat.id}", {type: "messages", data: serialize(chat.messages)}
  end

  def unsubscribed
  end

  def receive(data)
    self.create_message(data)
  end

  def create_message(data, recipients)
    puts "received message on backend #{data}"

    new_message = Message.new(message_params)

    if (new_message.save)
      
      recipients.each do |user|
        # Send notification to each recipient
        ActionCable.server.broadcast "chat_#{user.id}", {type: "notification", data: {message: "New message in #{new_message.chat.title}", chat_id: new_message.chat.id}}
      end

      # Send the message
      ActionCable.server.broadcast "message_#{new_message.chat.id}", {type: "message",data: serialize(new_message)}
    end
  end

  def serialize(data)
    MessageSerializer.new(data).serialized_json
  end

  private

  def message_params
    data.permit(:user_id, :chat_id, :content)
  end
end