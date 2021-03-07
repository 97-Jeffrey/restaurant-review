class RestaurantsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user_edit, only:[:edit, :update]
  before_action :correct_user_delete, only:[:destroy]

  def index
    @restaurants = Restaurant.all
    @notice = "Please sign up or sign in to add, update or delete a restaurant"
  end
  def show
    @restaurant = Restaurant.find(params[:id])
    @notice = "Please sign up or sign in to add a review"
  end

  def new
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.save
    redirect_to @restaurant, {notice:"A new restaurant added"}
  end

  def update
    @restaurant = Restaurant.find(params[:id])
   
    if @restaurant.update(restaurant_params)
      redirect_to @restaurant, {notice: "updated successfully"}
    else
      render 'edit'
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    redirect_to restaurants_path, {notice: "A restaurant deleted"}
  end

  def correct_user_edit
    @restaurant = current_user.restaurants.find_by(id: params[:id])
    redirect_to restaurants_path, notice: "You cannot edit this restaurant" if @restaurant.nil?
  end

  def correct_user_delete
    @restaurant = current_user.restaurants.find_by(id: params[:id])
    redirect_to restaurants_path, notice: "You cannot delete this restaurant" if @restaurant.nil?
  end

  private
  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :cuisine, :image_url, :description, :user_id)
  end
end
