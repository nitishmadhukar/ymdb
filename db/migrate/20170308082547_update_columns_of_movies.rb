class UpdateColumnsOfMovies < ActiveRecord::Migration[5.0]
  def change
  	change_column :movies, :production_companies, :text
  	change_column :movies, :production_countries, :text
  	change_column :movies, :genres, :text
  end
end
