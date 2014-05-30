class Love < ActiveRecord::Base
  include Experience

  belongs_to :lovable, polymorphic: true
  belongs_to :user
  has_many :notifications, as: :notificable, dependent: :destroy

  validates_presence_of :user_id, :lovable_id,
    :lovable_type

  after_create :notify!
  after_create :give_love_experience!
  after_destroy :take_love_experience!

  private

  def notify!
    Notification.create(user: lovable.user, notificable: self, triggered_on: lovable) if user != lovable.user
  end

  def give_love_experience!
    give_experience!(lovable.user, Experience::LOVE_EXPERIENCE)
  end

  def take_love_experience!
    take_experience!(lovable.user, Experience::LOVE_EXPERIENCE)
  end
end
