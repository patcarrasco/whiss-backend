class Api::V1::FriendshipsController < ApplicationController
	include Response
	def index
		friends = User.all
		json_response serialize(friends)
	end
	def friends
		decodedToken = JWT.decode(params["_json"], "crap")
    user = User.find(decodedToken[0]["data"])
		if (!!user)
			friends = user.friends
			json_response serialize(friends)
		end
	end

	private
	
	def serialize(data)
		UserBlueprint.render(data)
	end
end
