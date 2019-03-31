module ApplicationCable
	class Connection < ActionCable::Connection::Base
		identified_by :current_user

		def decoded_token(token)
			JWT.decode(token, "crap")
		end

		def token
			jwt_token = request.params['token']
		end

		def current_user
			decoded_hash = self.decoded_token(self.token)
			if !decoded_hash.empty?
				user_id = decoded_hash[0]["data"]
				user = User.find(user_id)
				if user.present?
					user
				else
					reject_unauthorized_connection
				end
			end
		end
	end
end
