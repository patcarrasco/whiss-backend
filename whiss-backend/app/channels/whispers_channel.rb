class WhispersChannel < ApplicationCable::Channel
  def subscribed
    stream_from "whispers_#{params[:chat_id]}"
  end

  def unsubscribed
  end

  def serialize(data)
		# WisprSerializer.new(data).serialized_json
	end
end
