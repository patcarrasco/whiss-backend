class NotificationBlueprint < Blueprinter::Base
  view :id do
    field :id
  end
  view :normal do
    field :message
  end
end
