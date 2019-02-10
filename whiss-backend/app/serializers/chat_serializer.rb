class ChatSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :sender_id, :receiver_id
end
