class RenameAvatarToSmallAvatarInUser < ActiveRecord::Migration
  def change
    rename_column :users, :avatar, :small_avatar
  end
end
