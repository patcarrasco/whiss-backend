class Api::V1::UserChatsController < ApplicationController
	include Response

	def create
		user_chat = UserChat.new(user_chat_params)
		if user_chat.save
			# json_response(serialize(chat))
			ActionCable.server.broadcast "chats_channel_#{user_chat.user_id}", serialize(user_chat)
			head :ok
		else
			json_response {"create failed"}
		end
	end

	def destroy
		if UserChat.exists?(params[:id])
			user_chat = UserChat.find(params[:id])
			user_chat.destroy
			json_response {"destroyed"}
		else
			json_response {"destroy failed"}
		end
	end

	private

	def user_chat_params
		params.permit(:user_id, :chat_id)
	end

	def serialize(data)
		UserChatSerializer.new(data).serialized_json
	end
end
