class FavoritesController < ApplicationController
  def index
    render json: User.find(params[:user_id]).favorites
  end

  def create
    favorite = Favorite.new(favorite_params)
    if favorite.save
      render json: favorite
    else
      render(json: favorite.errors.full_messages, status: :unprocessable_entity)
    end
  end

  def destroy
    favorite = Favorite.find(params[:id])
    favorite.destroy
    render json: favorite
  end

  def favorite_params
    params.require(:favorite).permit(:user_id, :contact_id)
  end
end
