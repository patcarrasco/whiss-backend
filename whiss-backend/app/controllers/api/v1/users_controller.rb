class Api::V1::UsersController < ApplicationController
	include Response
	before_action :verify_user, only: [:update, :destroy]

	def index
		users = User.all.where.not(id: current_user.id)
		json_response(serialize(users))
	end

	def show
		if User.exists?(params[:id])
			user = User.find(params[:id])
			json_response(serialize(user))
		else
			json_response "message": "invalid user"
		end
	end

	def create
		user = User.new(user_params)
		if user.save
			json_response(serialize(user))
		else
			json_response "message": "create failed"
		end
	end

	def update
		user = User.find(params[:id])
		if user.update(user_params)
			json_response(serialize(user))
		else
			json_response "message": "update failed"
		end
	end

	def destroy
		if User.exists?(params[:id])
			user = User.find(params[:id])
			user.destroy
			json_response "message": "destroyed"
		else
			json_response "message": "destroy failed"
		end
	end

	def login
		user = User.find_by(username: params[:username])
		if (!!user)
			if (user.authenticate(params[:password]))
				payload = {data: user.id}
				token = JWT.encode(payload, "crap")
				render json: {token: token, user: serialize(user)}
			else
				render json: {message: "password incorrect"}
			end
		else
			render json: {message: "invalid user"}
		end
	end

	def sign_up
		user = User.new(user_params)
		if (user.save)
			if (user.authenticate(params[:password]))
				payload = {data: user.id}
				token = JWT.encode(payload, "crap")
				render json: {token: token, user: user}
			end
		else
			json_response "message": "sign up failed"
		end
	end

	def current_user
		request.authorization.split(" ")[1]
		decodedToken = JWT.decode(request.authorization.split(" ")[1], "crap")
		user = User.find(decodedToken[0]["data"])
		user
	end


	private

	def verify_user
		unless session[:user_id] == params[:id]
			json_response "message": "not authorized"
		end
	end

	def user_params
		params.permit(:name, :username, :password)
	end

	def serialize(data)
		UserBlueprint.render_as_hash(data)
	end
end
