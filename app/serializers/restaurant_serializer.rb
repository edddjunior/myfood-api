class RestaurantSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  # We added this line to use the helper method "rails_blob_url"

  attributes :id, :name, :description, :review, :status, :delivery_tax, :state,
  :city, :street, :neighborhood, :number, :complement, :reference, :zip_code, :image_url, :category_title

  # The fields we want to be rendered when the object is rendered

  has_many :product_categories, if -> { @instance_options[:product_categories] }
  # The product_categories will be rendered just if we want them. If we don't, they'll not

  def image_url
    rails_blob_url(object.image)
    # This helper gets the URL from the file we pass to it
  end

  def review
    object.reviews&.average(:value)
    # Here we take all the reviews (value) associated to the restaurant (object) and get an average
    # "&" ensures we'll just make the average if there are any values associated to the restaurant. If there aren't, it returns nil
  end

  def category_title
    "cozinha #{object.category&.title}"
    # Returns the title of the category 
  end
end
