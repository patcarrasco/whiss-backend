class Api::V1::UsersController < ApplicationController
	include Response

	def index
		users = User.all
		json_response(serialize(users))
	end

	def show
		if User.exists?(params[:id])
			user = User.find(params[:id])
			json_response(serialize(user))
		else
			json_response {"invalid user"}
		end
	end

	def create
		user = User.new(user_params)
		if user.save
			json_response(serialize(user))
		else
			json_response {"create failed"}
		end
	end

	def update
		user = User.find(params[:id])
		if user.update(user_params)
			json_response(serialize(user))
		else
			json_response {"update failed"}
		end
	end

	def destroy
		if User.exists?(params[:id])
			user = User.find(params[:id])
			user.destroy
			json_response {"destroyed"}
		else
			json_response {"destroy failed"}
		end
	end

	private

	def user_params
		params.permit(:name, :username, :password)
	end

	def serialize(data)
		UserSerializer.new(data).serialized_json
	end
end
