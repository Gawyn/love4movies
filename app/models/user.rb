class User < ActiveRecord::Base
  devise :database_authenticatable, :omniauthable,
         :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, 
    :remember_me, :fb_uid, :token, :secret, :expires_at, :avatar

  has_many :ratings

  def update_data!(omniauth)
    credentials = omniauth["credentials"]
    self.token = credentials["token"]
    self.avatar = graph.get_picture("me")
  end

  def self.generate_from_omniauth(omniauth)
    user = User.new
    user.email = omniauth["info"]["email"]
    user.fb_uid = omniauth["uid"]
    user.update_data!(omniauth)
    user
  end

  private

  def graph
    @graph ||= Koala::Facebook::API.new(token)
  end
end
