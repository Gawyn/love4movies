class User < ActiveRecord::Base
  devise :database_authenticatable, :omniauthable,
         :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, 
    :remember_me, :fb_uid, :token, :secret, :expires_at
end
