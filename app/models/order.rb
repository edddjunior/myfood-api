class Order < ApplicationRecord
  before_validation :set_price

  has_many :order_products
  accepts_nested_attributes_for :order_products, allow_destroy: true
  # When we create an order, we'll accept the attributes from order_products too

  belongs_to :restaurant

  validates :name, presence: true
  validates :phone_number, presence: true
  validates :total_value, presence: true

  enum status: { waiting: 0, delivered: 1 }

  private
    def set_price
      @final_price = 0
      order_products.each do |order_product|
        product = Product.find order_product.product_id
        @final_price += order_product.quantity * product.price
      end
      self.total_value = @final_price
    end
end
