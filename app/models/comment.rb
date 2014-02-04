class Comment < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user

  after_create :create_activity!

  private

  def create_activity!
    Activity.create(user_id: user_id, content: self) 
  end
end
