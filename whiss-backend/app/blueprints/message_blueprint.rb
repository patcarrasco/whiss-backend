class MessageBlueprint < Blueprinter::Base
	identifier :id
  fields :user_id, :chat_id, :content
  association :user, blueprint: UserBlueprint
end
