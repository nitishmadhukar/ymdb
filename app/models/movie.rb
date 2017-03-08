class Movie < ApplicationRecord
  @@last_db_clear ||= Time.zone.now # Last db clear should be stored in a persistent storage in realtime apps
  def self.retrieve_movies
  	if Movie.count == 0
  	  Tmdb::MovieCollection.latest
  	else
  	  false
  	end
  end

  def self.last_db_clear
  	@@last_db_clear
  end

  def self.destroy_all
  	destroy_all if time_for_movies_destroy?
  	reset_last_db_clear_time
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
