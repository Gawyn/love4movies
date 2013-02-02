class AddBigAvatarToUser < ActiveRecord::Migration
  def change
    add_column :users, :big_avatar, :string
    User.all.each do |user|
      user_graph = Koala::Facebook::API.new(user.token)
      big_avatar = user_graph.get_picture("me", { :width => 200,
        :height => 200 })
      user.update_attribute(:big_avatar, big_avatar)
    end
  end
end
