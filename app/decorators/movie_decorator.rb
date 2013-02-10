class MovieDecorator < Draper::Decorator
  delegate_all

  def print_poster
    return unless posters.any?
    h.image_tag posters.first.url(Poster::SIZES.first)
  end
end
