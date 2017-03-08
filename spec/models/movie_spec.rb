require 'rails_helper'

RSpec.describe Movie do
  describe '.list' do
    before :each do
      @test_movie = FactoryGirl.create(:movie)
    end

    context 'when page is within limit' do
      it 'retrieves data from database' do
        movies = Movie.list(1)
        expect(movies.first.original_title).to eq(@test_movie.original_title)
        expect(Movie.first.original_title).to eq(@test_movie.original_title)
      end
    end

    context 'when page is out of limit' do
      before :each do
        @test_movie_titles = [{original_title: 'test_movie1'}, {original_title: 'test_movie2'}]
      end

      it 'retrieves data from tmdb api' do
        allow(Movie).to receive(:save_to_db)
        expect(Movie).to receive(:load_next10_from_tmdb)
        Movie.list(2)
      end

      it 'saves loaded movies to database' do
        allow(Movie).to receive(:load_next10_from_tmdb).and_return(@test_movie_titles)
        expect(Movie).to receive(:save_to_db).with(@test_movie_titles)
        Movie.list(2)
      end
    end
  end

  describe '#id=' do
    it 'changes to tmdb=' do
      Movie.new(id: 10).save
      expect(Movie.first.tmdb_id).to eq(10)
    end
  end

  describe '.last_db_clear' do
    it 'returns class variable' do
      time = Time.zone.now
      Movie.class_variable_set(:@@last_db_clear, time)
      expect(Movie.last_db_clear).to eq(time)
    end
  end

  describe '.clear_db' do
    context 'when its time to destroy db' do
      it 'destroys all data' do
        allow(Movie).to receive(:time_for_movies_destroy?).and_return(true)
        allow(Movie).to receive(:reset_last_db_clear_time)
        expect(Movie).to receive(:destroy_all)
        Movie.clear_db
      end
    end

    context 'when its not time to destroy db' do
      it 'returns nil' do
        allow(Movie).to receive(:time_for_movies_destroy?).and_return(false)
        allow(Movie).to receive(:reset_last_db_clear_time)
        expect(Movie.clear_db).to be_nil
      end
    end
  end
end
