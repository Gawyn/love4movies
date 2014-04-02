class Notification < ActiveRecord::Base
  belongs_to :notificable, polymorphic: true
  belongs_to :user

  scope :pending, -> { where(pending: true) }
end
