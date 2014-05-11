class BackfillingUserProvider < ActiveRecord::Migration
  def change
    User.update_all(provider: "facebook")
  end
end
