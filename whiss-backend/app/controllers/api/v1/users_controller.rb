class Api::V1::UsersController < ApplicationController
	include Response
	before_action :verify_user, only: [:update, :destroy]

	def index
		users = User.all
		json_response(serialize(users))
	end

	def show
		if User.exists?(params[:id])
			user = User.find(params[:id])
			json_response(serialize(user))
		else
			json_response {"message" => "invalid user"}
		end
	end

	def create
		user = User.new(user_params)
		if user.save
			json_response(serialize(user))
		else
			json_response {"message" => "create failed"}
		end
	end

	def update
		user = User.find(params[:id])
		if user.update(user_params)
			json_response(serialize(user))
		else
			json_response {"message" => "update failed"}
		end
	end

	def destroy
		if User.exists?(params[:id])
			user = User.find(params[:id])
			user.destroy
			json_response {"message" => "destroyed"}
		else
			json_response {"message" => "destroy failed"}
		end
	end

	def login
		if User.exists?(params[:user_id])
			user = User.find(params[:user_id])
			if (user.authenticate(params[:password]))
				session[:user_id] = user.id
				token = JWT.encode(user, "crap")
				json_response {"token" => token}
			end
		else
			session[:user_id] = nil
			json_response {"message" => "login failed"}
		end
	end

	def logout
		session[:user_id] = nil
		reset_session
		json_response {"message" => "logged out"}
	end

	private

	def verify_user
		unless session[:user_id] == params[:id]
			json_response {"message" => "not authorized"}
		end
	end

	def user_params
		params.permit(:name, :username, :password)
	end

	def serialize(data)
		UserSerializer.new(data).serialized_json
	end
end
