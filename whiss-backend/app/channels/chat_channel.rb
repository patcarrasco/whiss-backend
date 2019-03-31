class ChatChannel < ApplicationCable::Channel
	def subscribed
		if current_user
			stream_from "user_#{current_user.id}"
			send_current_chats
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
			reducer(action)
		end
	end


	def reducer(action)
		case action["type"]
		when "NEW_CHAT"
			self.create(action["payload"])
		when "UPDATE_CHAT"
			self.update(action["payload"])
		when "DELETE_CHAT"
			self.delete(action["payload"])
		else
			nil
		end
	end


	def create(chat)
		# chat = {title: "Jooe", members: [2,3,45,765,3]}
		puts "Create Chat", chat
		new_chat = Chat.new()
		if chat["title"]
			new_chat.title = chat["title"]
		else
			new_chat.title = "Chat with #{current_user.name}..."
		end

		if new_chat.save
			chat["members"].each do |id|
				self.join_and_send_chat(id, new_chat)
			end
		else
			ActionCable.server.broadcast("user_#{current_user.id}", {type: "ERROR", payload:"Not a valid chat"})
		end
	end

	def update(updated_chat)
		# chat = {id: 3, title: "Hey", members: [2,3,45,765,3]}
		puts "Update Chat", chat
		chat = Chat.find(updated_chat["id"])
		if chat.save
			chat["members"].each do |id|
				self.send_updated_chat(id, updated_chat)
			end
		else
			ActionCable.server.broadcast("user_#{current_user.id}", {type: "ERROR", payload: "Not a valid chat"})
		end
	end

	def delete(chat)
		puts "DELETE #{chat["id"]}"
		chat = Chat.find(chat_id)
		if chat.users.include?(current_user)
			chat.users.each do |user|
				ActionCable.server.broadcast("user_#{id}", {type: "DELETE_CHAT", payload: chat.id})
			end
			chat.destroy
		else
			ActionCable.server.broadcast("user_#{id}", {type: "ERROR", payload:"Not an authorized user"})
		end
	end

	def send_current_chats
			send_chat(current_user.id, {type: "SET_CHATS", payload: serialize(current_user.chats.order(created_at: :desc))})
	end

	def send_chat(user_id, action) 
		ActionCable.server.broadcast("user_#{user_id}", action)		
	end

	def join_and_send_chat(user_id, chat)
		UserChat.create(user_id: user_id, chat_id: chat.id)
		send_chat(user_id, {type: "ADD_CHAT", payload: serialize(chat)})
	end

	def send_updated_chat(user_id, chat)
		send_chat(user_id, {type: "UPDATE_CHAT", payload: serialize(chat)})
	end

	def serialize(data)
		ChatBlueprint.render_as_hash(data)
	end
end
