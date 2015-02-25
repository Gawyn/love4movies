class NotificationDecorator < Draper::Decorator
  include Rails.application.routes.url_helpers
  delegate_all

  def title
    if notificable_type == "Love"
      h.link_to triggered_on do
        "<strong>#{user.name}</strong> #{I18n.t('notifications.love-rating')} <strong>#{movie.title}</strong>".html_safe
      end
    else

      case triggered_on_type

      when "Rating"
        h.link_to triggered_on do
          "<strong>#{user.name}</strong> #{I18n.t('notifications.comment-rating')} <strong>#{movie.title}</strong>".html_safe
        end

      when "Review"
        "<strong>#{h.link_to(user.name, user)}</strong> #{I18n.t('notifications.comment-review')} <strong>#{h.link_to(movie.title, triggered_on)}</strong>".html_safe

      when "Comment"
        "<strong>#{h.link_to(user.name, user)}</strong> #{I18n.t('notifications.answer-comment')} <strong>#{h.link_to(movie.title, triggered_on.commentable)}</strong>".html_safe

      end
    end
  end

  def sanitized_title
    if notificable_type == "love"
        "#{user.name} #{I18n.t('notifications.love-rating')} #{movie.title}"
    else
      case triggered_on_type

      when "Rating"
        "#{user.name} #{I18n.t('notifications.comment-rating')} #{movie.title}"

      when "Review"
        "#{user.name} #{I18n.t('notifications.comment-review')} #{movie.title}"

      when "Comment"
        "#{user.name} #{I18n.t('notifications.answer-comment')} #{movie.title}"
      end
    end
  end

  def answer_url
    case triggered_on_type

    when "Rating" 
      rating_url(triggered_on)
    when "Review" 
      review_url(triggered_on)
    when "Comment" 
      triggered_on.commentable_type == "Rating" ? rating_url(triggered_on) : review_url(triggered_on)
    end
  end

  private

  def movie
    notification.triggered_on_type == "Comment" ? notification.triggered_on.commentable.movie : notification.triggered_on.movie
  end

  def user
    notificable.user
  end
end
