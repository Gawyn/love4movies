require "#{Rails.root}/lib/the_movie_db.rb"

TMDBClient = TheMovieDB::Client.new(APP_CONFIG["tmdb"]["key"])
