class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: :show

  def index
    @restaurants = Restaurant.near(params[:city] || 'São Paulo')
    # This variable restaurants will receive what the near method (from gem geocoder) returns
    # The near method searches for adresses in a defined area based on the city param (from Model Restaurant)
    # If it doesn't get a city to "use", it will use São Paulo by default
    filter_by_category if params[:category]
    # If the user chooses a category, this method will accept an extra param (category), and show only the kind of restaurants related to it
    render json: @restaurants
  end

  def show
    render json: @restaurant, product_categories: true
  end

  def search
    @restaurants = Restaurant.search(name_or_description_cont: params[:q]).result
    # This will search for q (the word user wrote) in the name or description of the restaurant
    @restaurants = @restaurants.near(params[:city]) if params[:city]
    # This permits the user passes the city as an additional param
    render json: @restaurants
  end

  private
    def filter_by_category
      @restaurants = @restaurants.select do |r|
        r.category.title == params[:category]
      # This verifies if the restaurant's category title is equal to the category that was chosen by the user
      # and then fills the variable with corresponding data
    end

    def set_restaurant
      @restaurant = Restaurant.find_by(id: params[:id])
      # Sets the restaurant that will be rendered in the show action
    end
end
