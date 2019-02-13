class MessagesChannel < ApplicationCable::Channel
  def subscribed
    chat = Chat.find(params[:chat_id])
    stream_from "message_#{chat.id}"
    ActionCable.server.broadcast "message_#{chat.id}", serialize(chat.messages)
  end

  def unsubscribed
  end

  def receive(data)
    # message = data["message"]
    # recipients = data["recipients"]
    # puts decodedToken, data
    # self.create_message(message, recipients)
    decodedToken = JWT.decode(data["token"], "crap")[0]["data"]
    user = User.find(decodedToken)
    create_message({content: data["content"], user_id: user.id, chat_id: data["chat_id"]})
  end

  def create_message(message)
    new_message = Message.new(message)

    if (new_message.save)
      puts "received message on backend"
      new_message.chat.users.each do |user|
        # Send notification to each recipient
        ActionCable.server.broadcast("chat_#{user.id}", notification: "New message in #{new_message.chat.title}")
      end
      ActionCable.server.broadcast "message_#{new_message.chat.id}", serialize(new_message)
    end
  end

  def serialize(data)
    MessageBlueprint.render(data)
  end
end