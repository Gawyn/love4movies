class Review < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user

  after_commit :create_activity!, on: :create

  private

  def create_activity!
    Activity.create(user_id: user_id, content: self) 
  end
end
