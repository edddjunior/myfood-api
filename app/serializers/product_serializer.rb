class ProductSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  # We added this line to use the helper method "rails_blob_url"

  attributes :id, :name, :description, :price, :image_url
  # The fields we want to be rendered when the object is rendered

  def image_url
    rails_blob_url(object.image)
    # This helper gets the URL from the file we pass to it
  end
end
