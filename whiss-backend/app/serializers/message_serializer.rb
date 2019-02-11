class MessageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :user_id, :chat_id, :content, :user
  belongs_to :user
end
