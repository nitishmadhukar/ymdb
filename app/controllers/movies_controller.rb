class MoviesController < ApplicationController
  before_action :set_movie, only: :show

  def index
    @movies = Movie.list(params[:page])
    @favorites = Favorite.all
    respond_to do |format|
      format.html
      format.json { render json: @movies }
    end
  end

  def show
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end
end
