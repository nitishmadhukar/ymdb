class Movie < ApplicationRecord
  @@last_db_clear ||= Time.zone.now # Last db clear should be stored in a persistent storage in realtime apps

  def self.list(page)
  	movies = paginate(page: page, per_page: 10)
  	movies = Tmdb::MoviesCollection.next10(Movie.last.server_id) if movies.to_a.count == 0
  end

  def self.last_db_clear
  	@@last_db_clear
  end

  def self.clear_db
  	destroy_all if time_for_movies_destroy?
  	reset_last_db_clear_time
  end

  def self.save_from_tmdb(movie_id)
  	movie_details = Tmdb::Movie.new(movie_id).details
  	new(movie_details).save if movie_details
  end

  def id=(value)
  	tmdb_id = :tmdb_id
  	send("#{tmdb_id}=", value)
  end

  private

  def self.time_for_movies_destroy?
  	if (Time.zone.now - last_db_clear).seconds > MOVIE_DB_CLEAR[:time]
  	  true
  	else
  	  false
  	end
  end

  def self.reset_last_db_clear_time
  	@@last_db_clear = Time.zone.now
  end
end
