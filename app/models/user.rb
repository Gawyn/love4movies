class User < ActiveRecord::Base
  AVATAR_SIZES = %w{ small medium big }
  ROLES = %w{ user admin }

  devise :database_authenticatable, :omniauthable,
         :rememberable, :trackable, :validatable

  has_many :ratings, :dependent => :destroy
  has_many :friendships, :dependent => :destroy
  has_many :friends, :through => :friendships
  has_many :comments, :dependent => :destroy
  has_many :lists, :dependent => :destroy

  validates_inclusion_of :role, in: ROLES

  before_validation :define_role, on: :create

  ROLES.each do |role_type|
    define_method "#{role_type}?" do
      role == role_type
    end
  end

  after_create :create_friendships!

  def update_data!(omniauth)
    credentials = omniauth["credentials"]
    self.token = credentials["token"]
    self.small_avatar = graph.get_picture("me")
    self.big_avatar = graph.get_picture("me", { :width => 200,
      :height => 200 })
    self.medium_avatar = graph.get_picture("me", { :width => 100,
      :height => 100 })
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

  def avatar(size = "medium")
    return unless AVATAR_SIZES.include? size
    send("#{size}_avatar")
  end

  def available_patterns
    completed_patterns = lists.pluck(:list_pattern_id)
    completed_patterns.any? ? ListPattern.where(ListPattern.arel_table[:id].not_in(completed_patterns)) : ListPattern.all
  end

  private

  def graph
    @graph ||= Koala::Facebook::API.new(token)
  end

  def define_role
    self.role ||= "user"
  end
end
