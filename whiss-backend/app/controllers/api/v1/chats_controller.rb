class Api::V1::ChatsController < ApplicationController
	include Response

	def index
		chats = Chat.all
		json_response(serialize(chats))
	end

	def user_chats
		user = User.find(params[:user_id])
		chats = user.chats
		json_response(serialize(chats))
	end

	def show
		if Chat.exists?(params[:id])
			chat = Chat.find(params[:id])
			json_response(serialize(chat))
		else
			json_response {"invalid chat"}
		end
	end

	def create
		chat = Chat.new(chat_params)
		if chat.save
			json_response(serialize(chat))
		else
			json_response {"create failed"}
		end
	end

	def update
		chat = Chat.find(params[:id])
		if chat.update(chat_params)
			json_response(serialize(chat))
		else
			json_response {"update failed"}
		end
	end

	def destroy
		if Chat.exists?(params[:id])
			chat = Chat.find(params[:id])
			chat.destroy
			json_response {"destroyed"}
		else
			json_response {"destroy failed"}
		end
	end

	private

	def chat_params
		params.permit(:sender_id, :receiver_id)
	end

	def serialize(data)
		ChatSerializer.new(data).serialized_json
	end
end
