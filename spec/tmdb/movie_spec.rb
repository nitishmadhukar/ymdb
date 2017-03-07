require 'rails_helper'

RSpec.describe Tmdb::Movie do
  before :each do
    @movie = Tmdb::Movie.new(1)
  end

  describe '#new' do
    it 'initializes with given movie id' do
      expect(@movie.instance_variable_get(:@movie_id)).to eq(1)
    end
  end

  describe '#details' do
    it 'retrieves details of the movie' do
      allow_any_instance_of(Tmdb::Api).to receive(:response) { {test_key: 'test_value'} }
      expect(@movie.details[:test_key]).to eq('test_value')
    end
  end

  describe '#changes' do
    it 'retrives the changes for a movie' do
      allow_any_instance_of(Tmdb::Api).to receive(:response) { {test_key: 'test_value'} }
      expect(@movie.changes[:test_key]).to eq('test_value')
    end
  end
end
