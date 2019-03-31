class MessageChannel < ApplicationCable::Channel
	def subscribed
		chat = Chat.find(params[:chat_id])
		stream_from "chat_#{chat.id}"
		self.send_messages(chat.id)
	end

	def unsubscribed
		stop_all_streams
	end

	def receive(action)
		self.reducer(action)
	end

	def reducer(action)
		case action["type"]
		when "NEW_MESSAGE"
			self.create(action["payload"]) 
		else
			puts "Default Match"
		end
	end

	def create(message)
		new_message = Message.new(message)
		new_message.user = current_user
		if new_message.save
			ActionCable.server.broadcast("chat_#{message["chat_id"]}", {type: "ADD_MESSAGE", payload: serialize(new_message)})
		else
			puts new_message.errors.full_messages
		end
	end

	def send_messages(id)
		chat = Chat.find(id)
		if chat
			ActionCable.server.broadcast("chat_#{chat.id}", {type: "SET_MESSAGES", payload: serialize(chat.messages.order(created_at: :asc))})
		else
			ActionCable.server.broadcast("chat_#{id}", {type: "ERROR", payload:"Not a valid chat"})
		end
	end

	def serialize(data)
		MessageBlueprint.render_as_hash(data)
	end
end
