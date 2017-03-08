module Api
  module V1
    class MoviesController < ApplicationController
      API_TOKEN = 'not_so_secure' # API_TOKEN storage should be more secure in real-time apps
      before_action :set_movie, only: :show
      before_action :set_paginate, only: :index

      def index
        @movies = Movie.paginate(page: @page, per_page: @per_page)
        if valid_api_token?
          render json: @movies, status: :ok
        else
          render json: { message: 'Invalid API request' }, status: :bad_request
        end
      end

      def show
        if valid_api_token?
          render json: @movie, status: :ok
        else
          render json: { message: 'Invalid API request' }, status: :bad_request
        end
      end

      private

      def valid_api_token?
        params[:api_token] == API_TOKEN ? true : false
      end

      def set_movie
        @movie = Movie.find_by(id: params[:id])
      end

      def set_paginate
        @page = params[:page] || 1
        @per_page = params[:per_page] || 10
      end
    end
  end
end
