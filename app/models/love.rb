class Love < ActiveRecord::Base
  belongs_to :lovable, polymorphic: true
  belongs_to :user

  validates_presence_of :user_id, :lovable_id,
    :lovable_type
end
