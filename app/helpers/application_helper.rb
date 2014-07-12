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
end
