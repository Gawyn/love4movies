class AddMediumAvatarToUser < ActiveRecord::Migration
  def change
    add_column :users, :medium_avatar, :string
    User.all.each do |user|
      user_graph = Koala::Facebook::API.new(user.token)
      medium_avatar = user_graph.get_picture("me", { :width => 100,
        :height => 100 })
      user.update_attribute(:medium_avatar, medium_avatar)
    end
  end
end
