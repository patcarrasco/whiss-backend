class WhispersChannel < ApplicationCable::Channel
  def subscribed
    stream_from "whispers_#{params[:chat_id]}"
  end

  def unsubscribed
  end

  def transmit(data)
    # {
    #   content: "",
    #   user_id: 1,
    #   friends: [id1, id2, id3]
    # }

    puts "#{data}"
    # new_wispr = Wispr.new(data["data"])
  	# if (new_wispr.save)
	  # 	ActionCable.server.broadcast "whispers_#{new_wispr.chat_id}", serialize(new_wispr)
  	# end
  end

  def serialize(data)
		# WisprSerializer.new(data).serialized_json
	end
end
