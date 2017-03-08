class FavoritesController < ApplicationController
  before_action :set_movie, only: :create
  before_action :find_favorite, only: :destroy

  def index
    @favorites = Favorite.list
    respond_to do |format|
      format.html
      format.json { render json: @favorites }
      format.js
    end
  end

  def create
    favorite = Favorite.new(movie: @movie)
    favorite.save
  end

  def destroy
    @favorite.destroy
    redirect_to favorites_path
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def find_favorite
    @favorite = Favorite.find(params[:id])
  end
end
