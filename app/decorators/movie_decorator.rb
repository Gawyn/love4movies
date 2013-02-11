class MovieDecorator < Draper::Decorator
  delegate_all

  def print_poster
    return unless posters.any?
    h.image_tag posters.first.url(Poster::SIZES.first)
  end

  def director
    technical_participations.where(:job => "Director").map{ |participation| participation.person.name }.to_sentence
  end
end
