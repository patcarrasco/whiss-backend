class ChatSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :title
end
