class NotificationDecorator < Draper::Decorator
  delegate_all

  def title
    if notificable_type == "Love"
      h.link_to triggered_on do
        "<strong>#{user.name}</strong> #{I18n.t('notifications.love-rating')} <strong>#{movie.title}</strong>".html_safe
      end
    else

      case triggered_on

      when "Rating"
        h.link_to notification.triggered_on do
          "<strong>#{user.name}</strong> #{I18n.t('notifications.comment-rating')} <strong>#{movie.title}</strong>".html_safe
        end

      when "Review"
        "<strong>#{h.link_to(user.name, user)}</strong> #{t('notifications.comment-review')} <strong>#{h.link_to(movie.title, triggered_on)}</strong>".html_safe

      when "Comment"
        "<strong>#{h.link_to(user.name, user)}</strong> #{t('notifications.answer-comment')} <strong>#{h.link_to(movie.title, triggered_on.commentable)}</strong>".html_safe

      end
    end
  end

  def sanitized_title
    ActionView::Base.full_sanitizer.sanitize title
  end

  private

  def movie
    notification.triggered_on_type == "Comment" ? notification.triggered_on.commentable.movie : notification.triggered_on.movie
  end

  def user
    notificable.user
  end
end
