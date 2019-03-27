class WisprBlueprint < Blueprinter::Base
	identifier :id
  fields :user_id, :content
  association :user, blueprint: UserBlueprint
end
