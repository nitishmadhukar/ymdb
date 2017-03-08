class Movie < ApplicationRecord
  @@last_db_clear ||= Time.zone.now # Last db clear should be stored in a persistent storage in realtime apps

  validates_presence_of :tmdb_id

  def self.list(page)
  	movies = paginate(page: page, per_page: 10)
    if movies.to_a.count == 0
      movies = load_next10_from_tmdb
      save_to_db(movies)
    end
    return Array(movies)
  end

  def id=(value)
    tmdb_id = :tmdb_id
    send("#{tmdb_id}=", value)
  end

  def self.last_db_clear
  	@@last_db_clear
  end

  def self.clear_db
    if time_for_movies_destroy?
  	  destroy_all
  	  reset_last_db_clear_time
    else
      return nil
    end
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

  def self.load_next10_from_tmdb
    last_movie_id = Movie.last.tmdb_id if Movie.last
    last_movie_id ||= 0
    Tmdb::MoviesCollection.next10(last_movie_id)
  end

  def self.save_to_db(movies)
    movies.each do |movie_details|
      new(movie_details).save
    end
  end
end
