class Api::V1::MessagesController < ApplicationController
	include Response

	def index
		messages = Message.all
		json_response(serialize(messages))
	end

	def chat_messages
		chat = Chat.find(params[:chat_id])
		messages = chat.messages
		json_response(serialize(messages))
	end

	def show
		if Message.exists?(params[:id])
			message = Message.find(params[:id])
			json_response(serialize(message))
		else
			json_response {"invalid message"}
		end
	end

	def create
		message = Message.new(message_params)

		if message.save
			# json_response(serialize(message))
			ActionCable.server.broadcast "messages_channel_#{message.chat_id}", serialize(message)
      head :ok
		else
			json_response {"create failed"};
		end
	end

	def update
		message = Message.find(params[:id])
		if message.update(message_params)
			json_response(serialize(message))
		else
			json_response {"update failed"}
		end
	end

	def destroy
		if Message.exists?(params[:id])
			message = Message.find(params[:id])
			message.destroy
			json_response {"destroyed"}
		else
			json_response {"destroy failed"}
		end
	end

	private

	def message_params
		params.permit(:user_id, :chat_id, :content)
	end

	def serialize(data)
		MessageSerializer.new(data).serialized_json
	end

end
