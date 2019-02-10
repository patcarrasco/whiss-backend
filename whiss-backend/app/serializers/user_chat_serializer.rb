class ChatSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :user_id, :chat_id
end
