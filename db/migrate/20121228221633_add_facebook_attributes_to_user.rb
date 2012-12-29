class AddFacebookAttributesToUser < ActiveRecord::Migration
  def change
    add_column :users, :fb_uid, :string
    add_column :users, :token, :string
  end
end
