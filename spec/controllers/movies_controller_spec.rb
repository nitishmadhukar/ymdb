require 'rails_helper'

RSpec.describe MoviesController do
  before :each do
    @test_movie = FactoryGirl.create(:movie)
  end

  describe 'GET#index' do
    before :each do
      get :index
    end

    it 'assigns movies list' do
      expect(assigns(:movies)).to eq([@test_movie])
    end

    it 'renders index template' do
      expect(response).to render_template("index")
    end
  end

  describe 'GET#show' do
    before :each do
      get :show, params: { id: @test_movie.id }
    end

    it 'assigns movie' do
      expect(assigns(:movie)).to eq(@test_movie)
    end

    it 'renders show template' do
      expect(response).to render_template("show")
    end
  end
end
