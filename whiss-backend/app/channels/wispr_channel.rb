class WisprChannel < ApplicationCable::Channel
	def subscribed
		if current_user
			stream_from "user_#{current_user.id}_wisprs"
			ActionCable.server.broadcast("user_#{current_user.id}_wisprs", {type: "SET_WISPRS", payload: self.serialize(Wispr.all)})
		else
			render json: {type: "ERROR", payload: "No User Token"}
		end
	end

	def unsubscribed
		stop_all_streams
	end

	def receive(action)
		self.reducer(action)
	end

	def reducer(action)
		case action["type"]
		when "NEW_WISPR"
			self.create(action["payload"]) 
		else
			puts "Default Match"
		end
	end

	def create(wispr)
		new_wispr = Wispr.new(wispr)
		new_wispr.user = current_user
		if new_wispr.save
			self.send_wispr(new_wispr)
		else
			puts new_wispr.errors.full_messages
		end
	end

	def send_wispr(wispr)
		User.all.each do |user|
			ActionCable.server.broadcast("user_#{user.id}_wisprs", {type: "ADD_WISPR", payload: wispr})
		end
	end

	def serialize(data)
		WisprBlueprint.render_as_hash(data)
	end
end
