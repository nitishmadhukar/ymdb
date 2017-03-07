require 'rails_helper'

RSpec.describe Tmdb::MoviesCollection do
  describe '#latest' do
    it 'retrieves the latest movie data' do
      allow_any_instance_of(Tmdb::Api).to receive(:response) { {test_key: 'test_value'} }
      movies_collection = Tmdb::MoviesCollection.new
      expect(movies_collection.latest[:test_key]).to eq('test_value')
    end
  end
end
