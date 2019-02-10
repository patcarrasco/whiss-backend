class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :username
end
