# Module for tmdb api library
module Tmdb
  class Config
    attr_reader :base_uri, :api_key

    def initialize
      @base_uri = TMDB_INFO[:api_v3]
      @api_key = TMDB_INFO[:api_key]
    end
  end
end