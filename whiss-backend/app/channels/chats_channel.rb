class ChatsChannel < ApplicationCable::Channel
  def subscribed
    user = JWT.decode(params["token"], "crap").first
    if user.id == session[:user_id]
      stream_from "chat_#{user.id}"
		  ActionCable.server.broadcast("chat_#{user.id}", serialize(user.chats))
    end
	end

  def unsubscribed
  end

  def receive(data)
  	self.new_chat(data)
  end

  def create_chat(data, members)
  	new_chat = Chat.new(title: data.title)
		if (new_chat.save)
			data.members.each do |id|
				user_chat = UserChat.create(user_id: id, chat_id: new_chat.id)
				ActionCable.server.broadcast("chat_#{id}", serialize(new_chat))
			end
  	end
  end

	def serialize(data)
		ChatSerializer.new(data).serialized_json
	end
end
