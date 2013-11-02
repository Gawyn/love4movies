module UserActivityHooks
  def create_activity
    Activity.create(user_id: user_id, content: self)
  end

  def self.included(base)
    base.class_eval do
      after_create :create_activity
    end
  end
end

Activity::ACTIVITY_TYPES.each do |activity_class|
  activity_class.send(:include, UserActivityHooks)
end
