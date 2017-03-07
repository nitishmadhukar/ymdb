# Module for tmdb api library
module Tmdb
  class Api
    include HTTParty

    def initialize(end_point, http_method)
      @end_point = end_point
      @http_method = http_method
    end

    def response
      HTTParty.send(@http_method, url).deep_symbolize_keys
    rescue StandardError => e
      file = File.open('tmdb_api.log', File::WRONLY | File::APPEND)
      logger = Logger.new(file)
      logger.error e
      return
    end

    private

    def url
      config = Tmdb::Config.new
      base_uri = config.base_uri
      api_key = config.api_key
      "#{base_uri}/#{@end_point}?api_key=#{api_key}"
    end
  end
end