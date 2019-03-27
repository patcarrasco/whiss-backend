class ChatsChannel < ApplicationCable::Channel
	def subscribed
		if current_user
			stream_from "user_#{current_user.id}"
			self.send_chats(current_user.id)
		else
			render json: {type: "ERROR", payload: "No User Token"}
		end
	end

	def unsubscribed
		stop_all_streams
	end

	def receive(action)
		if current_user
			# action = {type: data["type"], payload: data["payload"]}
			self.reducer(action)
		end
	end

	def reducer(action)
		case action["type"]
		when "NEW_CHAT"
			self.create(action["payload"])
		when "GET_CHATS"
			self.send_chats(current_user.id)
		when "DELETE_CHAT"
			self.delete(action["payload"])
		else
			nil
		end
	end

	def create(chat)

		puts "Create Chat", chat
		# new_chat = Chat.new()
		# if chat["title"]
		# 	new_chat.title = chat["title"]
		# else
		# 	new_chat.title = "Chat with #{current_user.name}..."
		# end

		# if new_chat.save
		# 	chat["members"].each do |id|
		# 		self.join_and_send_chat(id, new_chat)
		# 	end
		# 	self.join_and_send_chat(current_user.id, new_chat)
		# else
		# 	ActionCable.server.broadcast("user_#{current_user.id}", {type: "ERROR", payload:"Not a valid chat"})
		# end
	end

	def delete(chat_id)

		puts "DELETE #{chat_id}"
		# chat = Chat.find(chat_id)
		# if chat.users.include?(current_user)
		# 	chat.users.each do |user|
		# 		ActionCable.server.broadcast("user_#{id}", {type: "DELETE_CHAT", payload: chat.id})
		# 	end
		# 	chat.destroy
		# else
		# 	ActionCable.server.broadcast("user_#{id}", {type: "ERROR", payload:"Not an authorized user"})
		# end
	end

	def send_chats(id)
		user = User.find(id)
		if user
			ActionCable.server.broadcast("user_#{user.id}", {type: "SET_CHATS", payload: serialize(user.chats)})
		else
			ActionCable.server.broadcast("user_#{id}", {type: "ERROR", payload:"Not a valid user"})
		end
	end

	def serialize(data)
		ChatBlueprint.render_as_hash(data)
	end

	# private

	def join_and_send_chat(user_id, chat)
		UserChat.create(user_id: user_id, chat_id: chat.id)
		ActionCable.server.broadcast("user_#{user_id}", {type: "ADD_CHAT", payload: serialize(chat)})
	end

end
