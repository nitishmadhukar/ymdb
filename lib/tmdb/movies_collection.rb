# Module for tmdb api library
module Tmdb
  class MoviesCollection
    MOVIES_COLLECTION_END_POINTS = [
      'latest', 'now_playing', 'popular', 'top_rated', 'upcoming'
    ].freeze

    def method_missing(method_id, *args, &block)
      if MOVIES_COLLECTION_END_POINTS.include? method_id.to_s
        Tmdb::Api.new(method_id, :get).response
      else
        super
      end
    end

    def self.next10(last_movie_id)
      movies = []
      movie_id = last_movie_id + 1
      while movies.count < 10
        details = Tmdb::Movie.new(movie_id).details
        movies << details if details
        movie_id += 1
      end
      return movies
    end
  end
end
