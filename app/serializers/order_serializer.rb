class OrderSerializer
  include FastJsonapi::ObjectSerializer

  belongs_to :user
  attributes :name
end
