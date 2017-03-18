class Favorite < ApplicationRecord
  belongs_to :movie
  validates :movie_id, uniqueness: true

  def self.list
  	favorites = Favorite.includes(:movie)
  	movies = []
  	favorites.each do |f|
  	  movies << f.movie
  	end
  	return Array(movies)
  end
end
