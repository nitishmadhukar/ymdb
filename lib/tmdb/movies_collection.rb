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
  end
end
