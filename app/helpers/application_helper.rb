module ApplicationHelper
  def tmdb_poster(movie)
    image_tag "http://cf2.imgobject.com/t/p/w185#{movie.tmdb_poster_path}" 
  end
end
