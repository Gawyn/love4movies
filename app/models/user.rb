class User < ActiveRecord::Base
  devise :database_authenticatable, :omniauthable,
         :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, 
    :remember_me, :fb_uid, :token, :secret, :expires_at, :avatar

  has_many :ratings, :dependent => :destroy
  has_many :friendships, :dependent => :destroy
  has_many :friends, :through => :friendships

  after_create :create_friendships!

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

  def create_friendships!
    friends_fb_uid = graph.get_connections("me", "friends").map { |friend| friend["id"] }

    User.where(:fb_uid => friends_fb_uid).pluck(:id).each do |friend_id|
      Friendship.create(:user_id => id, :friend_id => friend_id)
    end
  end

  private

  def graph
    @graph ||= Koala::Facebook::API.new(token)
  end
end
