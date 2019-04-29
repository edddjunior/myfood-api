class ProductCategorySerializer < ActiveModel::Serializer
  attributes :id, :title
  # The fields we want to be rendered when the object is rendered

  has_many :products
  # The products will be rendered always when the product_categories is rendered
end
