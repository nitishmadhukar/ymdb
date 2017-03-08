class AddColumnsToMovies < ActiveRecord::Migration[5.0]
  def change
  	add_column :movies, :imdb_id, :string
  	add_column :movies, :belongs_to_collection, :text
  end
end
