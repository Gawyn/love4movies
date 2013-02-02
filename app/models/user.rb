class User < ActiveRecord::Base
  devise :database_authenticatable, :omniauthable,
         :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, 
    :remember_me, :fb_uid, :token, :avatar, :nickname, :name,
    :first_name, :last_name, :location

  has_many :ratings, :dependent => :destroy
  has_many :friendships, :dependent => :destroy
  has_many :friends, :through => :friendships
  has_many :comments, :dependent => :destroy

  after_create :create_friendships!

  def update_data!(omniauth)
    credentials = omniauth["credentials"]
    self.token = credentials["token"]
    self.avatar = graph.get_picture("me")
  end

  def self.generate_from_omniauth(omniauth)
    user = User.new
    user.email = omniauth["info"]["email"]
    user.nickname = omniauth["info"]["nickname"]
    user.name = omniauth["info"]["name"]
    user.first_name = omniauth["info"]["first_name"]
    user.last_name = omniauth["info"]["last_name"]
    user.location = omniauth["info"]["location"]
    user.fb_uid = omniauth["uid"]
    user.password = Devise.friendly_token[0,20]
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
