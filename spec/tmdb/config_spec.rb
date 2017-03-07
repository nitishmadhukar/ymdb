require 'rails_helper'

RSpec.describe Tmdb::Config do
  before :each do
    @config = Tmdb::Config.new
  end

	describe '#new' do
    it 'initializes with default value for base uri' do
      expect(@config.instance_variable_get(:@base_uri)).to eq(TMDB_INFO[:api_v3])
    end

    it 'initializes with default value for api key' do
      expect(@config.instance_variable_get(:@api_key)).to eq(TMDB_INFO[:api_key])
    end
  end

  describe '#base_uri' do
    it 'returns the default value' do
      expect(@config.base_uri).to eq(TMDB_INFO[:api_v3])
    end
  end

  describe '#api_key' do
    it 'returns the default value' do
      expect(@config.api_key).to eq(TMDB_INFO[:api_key])
    end
  end
end
