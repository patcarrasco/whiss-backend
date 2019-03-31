class WisprChannel < ApplicationCable::Channel
	def subscribed
		if current_user
			stream_from "user_#{current_user.id}_wisprs"
			ActionCable.server.broadcast("user_#{current_user.id}_wisprs", {type: "SHOW_MESSAGE", payload: "Message from Wispr"})
			# ActionCable.server.broadcast("user_#{current_user.id}_wisprs", {type: "SET_WISPRS", payload: serialize(current_user.chats)})
		else
			render json: {type: "ERROR", payload: "No User Token"}
		end
	end

	def unsubscribed
	end

	def receive(data)
	end

	def serialize(data)
		WisprBlueprint.render_as_hash(data)
	end
end
