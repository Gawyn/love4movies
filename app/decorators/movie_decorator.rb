class MovieDecorator < Draper::Decorator
  delegate_all

  def print_poster
    return unless posters.any?
    h.image_tag posters.first.url(Poster::SIZES.first)
  end

  def get_backdrop
    backdrops.first ? backdrops.first.url("w1280") : ActionController::Base.helpers.asset_path("default-backdrop.jpg")
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
      date = DateTime.parse(release_date)
      date.strftime('%Y')
    rescue
    end
  end

  def full_genres
    genres.map(&:name).join " · "
  end
end
