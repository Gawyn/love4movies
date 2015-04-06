module ApplicationHelper
  def language_selector
    other_languages = LANGUAGES_AND_LOCALES.select { |language, locale| locale != I18n.locale.to_s }
    other_languages.map do |language, locale|
      link_to language, set_locale: locale
    end.join(" ").html_safe
  end

  def tmdb_poster(movie)
    image_tag "http://cf2.imgobject.com/t/p/w185#{movie.tmdb_poster_path}"
  end

  def cp(path)
    "current" if current_page?(path)
  end

  def show_movie(movie)
    Rails.cache.fetch("movie-show-#{movie.id}-#{movie.updated_at.to_s}") do
      render "movies/show", movie: movie
    end
  end

  def share_twitter_url(description)
    "https://twitter.com/intent/tweet?text=#{description}"
  end

  def show_rating(rating, index, title)
    Rails.cache.fetch("#{rating.id}-#{rating.updated_at.to_s}-#{index}") do
      render "users/rating", rating: rating, index: index, header: index.zero?, title: title
    end
  end

  # def show_activity(activity)
  #   Rails.cache.fetch("#{activity.id}-#{activity.updated_at}-#{activity.content.updated_at}") do
  #     render "activities/show", user: activity.user, content: activity.content
  #   end
  # end
  def show_activity(activity)
    render "activities/show", user: activity.user, content: activity.content
  end

  def show_head_activity(activity)
    render "activities/show_head", user: activity.user, content: activity.content
  end
end
