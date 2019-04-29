class OrderSerializer < ActiveModel::Serializer
  attributes :id, :restaurant_id, :total_value, :status
  # The fields we want to be rendered when the object is rendered
end
