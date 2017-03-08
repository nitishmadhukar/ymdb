require 'rails_helper'

RSpec.describe Api::V1::MoviesController do
  describe 'GET#index' do
    before :each do
      10.times { FactoryGirl.create(:movie) }
    end

    context 'when API Token is provided' do
      before :each do
        get :index, params: { page: 1, per_page: 5, api_token: 'not_so_secure' }
      end

      it 'retrieves list of movies with given per page count' do
        expect(assigns(:movies).to_a.count).to eq(5)
      end

      it 'responds with success status code' do
        expect(response.status).to eq(200)
      end
    end

    context 'when API Token is not provided' do
      before :each do
        get :index, params: { page: 1, per_page: 5 }
      end

      it 'responds with error message' do
        expect(JSON.parse(response.body)["message"]).to eq('Invalid API request')
      end

      it 'responds with bad request status' do
        expect(response.status).to eq(400)
      end
    end
  end

  describe 'GET#show' do
    before :each do
      FactoryGirl.create(:movie)
      @test_movie = Movie.first
    end

    context 'when API Token is provided' do
      before :each do
        get :show, params: { id: @test_movie.id, api_token: 'not_so_secure' }
      end

      it 'retrieves the movie' do
        expect(assigns(:movie)).to eq(@test_movie)
      end

      it 'responds with success status code' do
        expect(response.status).to eq(200)
      end
    end

    context 'when API Token is not provided' do
      before :each do
        get :show, params: { id: @test_movie.id }
      end

      it 'responds with error message' do
        expect(JSON.parse(response.body)["message"]).to eq('Invalid API request')
      end

      it 'responds with bad request status' do
        expect(response.status).to eq(400)
      end
    end
  end
end
