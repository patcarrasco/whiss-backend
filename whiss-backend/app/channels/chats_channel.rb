class ChatsChannel < ApplicationCable::Channel
  def subscribed
    decodedToken = JWT.decode(params["token"], "crap")
    user = User.find(decodedToken[0]["data"])
    if user
      stream_from "chat_#{user.id}"
		  ActionCable.server.broadcast("chat_#{user.id}", serialize(user.chats))
    end
	end

  def unsubscribed
  end

  def receive(data)
    members = data.members
    title = data.title
  	self.create_chat(title, members)
  end

  def create_chat(title, members)
  	new_chat = Chat.new(title:title)
		if (new_chat.save)
			data.members.each do |id|
				user_chat = UserChat.create(user_id: id, chat_id: new_chat.id)
				ActionCable.server.broadcast("chat_#{id}", serialize(new_chat))
			end
  	end
  end

	def serialize(data)
		ChatBlueprint.render(data)
	end
end
