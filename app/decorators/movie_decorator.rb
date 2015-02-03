class MovieDecorator < Draper::Decorator
  delegate_all

  def print_poster
    return unless posters.any?
    h.image_tag posters.first.url(Poster::SIZES.first)
  end

  def get_background_image
    if backdrop = backdrops.first
      backdrop.url("w1280")
    elsif poster = posters.first
      poster.url("original")
    else
      ActionController::Base.helpers.asset_path("default-backdrop.jpg")
    end
  end

  def get_backdrop
    backdrops.first ? backdrops.first.url("w1280") : ActionController::Base.helpers.asset_path("default-backdrop.jpg")
  end

  def get_rating
    l4m_rating_average ? l4m_rating_average.round(2) : "-"
  end

  def directors
    technical_participations.where(:job => "Director").map do |participation|
      h.link_to participation.person.name, participation.person
    end.join(", ").html_safe
  end

  def directors_list
    technical_participations.where(:job => "Director").map{ |participation| participation.person }
  end

  def actors
    performances.includes(:person).limit(15).map do |performance|
      h.link_to performance.person.name, performance.person
    end.join(", ").html_safe
  end

  def movie_year
    begin
      release_date.year
    rescue
    end
  end

  def full_genres
    genres.map(&:name).join " · "
  end
end
