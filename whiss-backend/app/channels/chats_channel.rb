class ChatsChannel < ApplicationCable::Channel
  def subscribed
    decodedToken = JWT.decode(params["token"], "crap")
    user = User.find(decodedToken[0]["data"])
    if user
      stream_from "chat_#{user.id}"
		  ActionCable.server.broadcast("chat_#{user.id}", {type: "chats", data: serialize(user.chats))}
    end
	end

  def unsubscribed
  end

  def receive(data)
    message = data.message
    members = data.members
  	self.create_chat(message, members)
  end

  def create_chat(data, members)
  	new_chat = Chat.new(title: data.title)
		if (new_chat.save)
			data.members.each do |id|
				user_chat = UserChat.create(user_id: id, chat_id: new_chat.id)
				ActionCable.server.broadcast("chat_#{id}", {type: "chat", data: serialize(new_chat))}
			end
  	end
  end

	def serialize(data)
		ChatSerializer.new(data).serialized_json
	end
end
