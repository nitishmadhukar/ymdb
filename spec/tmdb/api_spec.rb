require 'rails_helper'

RSpec.describe Tmdb::Api do
  before :each do
    @api = Tmdb::Api.new('test_end_point', :get)
  end

  describe '#new' do
    it 'initializes with given end point' do
      expect(@api.instance_variable_get(:@end_point)).to eq('test_end_point')
    end

    it 'initializes with given http_method' do
      expect(@api.instance_variable_get(:@http_method)).to eq(:get)
    end
  end

  describe '#response' do
    it 'retrieves data from api with given http method and url' do
      http_method = @api.instance_variable_get(:@http_method)
      allow(HTTParty).to receive_message_chain(http_method, :deep_symbolize_keys) { { test_key: 'test_value' } }
      expect(@api.response[:test_key]).to eq('test_value')
    end
  end

  describe 'private#url' do
    it 'sets the url' do
      config = Tmdb::Config.new
      expect(@api.send(:url)).to eq("#{config.base_uri}/test_end_point?api_key=#{config.api_key}")
    end
  end
end
