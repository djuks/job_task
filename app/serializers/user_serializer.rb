class UserSerializer
  include FastJsonapi::ObjectSerializer

  has_many :orders
  attributes :email
end
