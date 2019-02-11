class ChatsChannel < ApplicationCable::Channel
  def subscribed
  	stream_from "chat_#{params[:user_id]}"
  end

  def unsubscribed
  end

  def receive(data)
		new_chat = Chat.new(title: data["title"])
		user_id = data["initial_content"]["user_id"]
		content = data["initial_content"]["content"]

		if (new_chat.save)
  		new_message = Message.create({
  			user_id: user_id,
  			chat_id: new_chat.id,
  			content: content
  		})

			data["friends"].each do |id|
				user_chat = UserChat.create(user_id: id, chat_id: new_chat.id)
				ActionCable.server.broadcast("chat_#{user_chat.user.id}", serialize(user_chat.chat))
			end
			
			ActionCable.server.broadcast("message_#{new_chat.id}", serialize_message(new_message))
  	end
  end

	def serialize(data)
		ChatSerializer.new(data).serialized_json
	end

  def serialize_message(data)
		MessageSerializer.new(data).serialized_json
	end
end
