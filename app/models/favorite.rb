class Favorite < ApplicationRecord
  belongs_to :movie

  def self.list
  	favorites = Favorite.includes(:movie)
  	movies = []
  	favorites.each do |f|
  	  movies << f.movie
  	end
  	return Array(movies)
  end
end
