class User < ActiveRecord::Base
  devise :database_authenticatable, :omniauthable,
         :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, 
    :remember_me, :fb_uid, :token, :secret, :expires_at

  def update_credentials!(omniauth)
    credentials = omniauth["credentials"]
    self.token = credentials["token"]
  end

  def self.generate_from_omniauth(omniauth)
    user = User.new
    user.email = omniauth["info"]["email"]
    user.fb_uid = omniauth["uid"]
    user.update_credentials!(omniauth)
    user
  end
end
