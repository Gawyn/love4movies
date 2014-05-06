class Love < ActiveRecord::Base
  belongs_to :lovable, polymorphic: true
  belongs_to :user

  validates_presence_of :user_id, :lovable_id,
    :lovable_type

  after_create :notify!

  private

  def notify!
    Notification.create(user: lovable.user, notificable: self, triggered_on: lovable) if user != lovable.user
  end
end
