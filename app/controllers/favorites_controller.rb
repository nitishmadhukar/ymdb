class FavoritesController < ApplicationController
  before_action :set_movie, only: :create
  before_action :find_favorite, only: :destroy

  def index
    @favorites = Favorite.list
    respond_to do |format|
      format.html
      format.json { render json: @favorites }
    end
  end

  def create
    favorite = Favorite.new(movie: @movie)
    if favorite.save
      render json: {favorite: favorite}, status: :created
    else
      render json: {}, status: :unprocessible_entity
    end
  end

  def destroy
    if @favorite.destroy
      render json: {}, status: :ok
    else
      render json: {}, status: :unprocessible_entity
    end
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def find_favorite
    @favorite = Favorite.find(params[:id])
  end
end
