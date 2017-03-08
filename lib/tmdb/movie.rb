# Module for tmdb api library
module Tmdb
  class Movie
    MOVIE_END_POINTS = [
      'account_states', 'alternative_titles', 'changes', 'credits', 'images', 'keywords', 'release_dates', 'videos',
      'translations', 'recommendations', 'similar', 'reviews', 'lists'
    ].freeze

    def initialize(movie_id)
      @movie_id = movie_id
    end

    def details
      details = Tmdb::Api.new(@movie_id, :get).response
      return nil unless details.keys.include? :id
      details
    end

    def method_missing(method_id, *args, &block)
      if MOVIE_END_POINTS.include? method_id.to_s
        complete_end_point = "#{@movie_id}/#{method_id}"
        Tmdb::Api.new(complete_end_point, :get).response
      else
        super
      end
    end
  end
end
