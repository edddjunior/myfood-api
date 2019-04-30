class Restaurant < ApplicationRecord
  belongs_to :category

  has_many :product_categories
  has_many :orders
  has_many :reviews

  has_one_attached :image

  validates_associated :category
  validates :name, presence: true
  validates :status, presence: true
  validates :delivery_tax, presence: true
  validates :city, presence: true
  validates :street, presence: true

  enum status: { closed: 0, open: 1 }

  geocoded_by :adress
  after_validation :geocode
  # The gem will consult some services to get latitude and longitude values based on the adress
  def adress
    [street, number, city, state].compact.join(', ')
    # Puts all adress information together
  end
end
