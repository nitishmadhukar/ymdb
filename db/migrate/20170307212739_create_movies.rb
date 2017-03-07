class CreateMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :movies do |t|
      t.boolean :adult
      t.string :backdrop_path
      t.float :budget
      t.string :genres, array: true
      t.string :homepage
      t.integer :tmdb_id
      t.string :original_language
      t.string :original_title
      t.text :overview
      t.float :popularity
      t.string :poster_path
      t.string :production_companies, array: true
      t.string :production_countries, array: true
      t.date :release_date
      t.float :revenue
      t.integer :runtime
      t.string :spoken_languages, array: true
      t.string :status
      t.text :tagline
      t.string :title
      t.boolean :video
      t.float :vote_average
      t.integer :vote_count
      t.timestamps
    end
  end
end
