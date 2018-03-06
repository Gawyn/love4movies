class User < ActiveRecord::Base
  AVATAR_SIZES = %w{ small medium big }
  ROLES = %w{ user admin }

  devise :database_authenticatable, :omniauthable,
         :rememberable, :trackable, :validatable

  has_many :ratings, :dependent => :destroy
  has_many :friendships, :dependent => :destroy
  has_many :friends, :through => :friendships
  has_many :reviews, :dependent => :destroy
  has_many :lists, :dependent => :destroy
  has_many :passive_follows, dependent: :destroy, foreign_key: "followed_id", class_name: "Follow"
  has_many :active_follows, dependent: :destroy, foreign_key: "follower_id", class_name: "Follow"
  has_many :followers, through: :passive_follows, source: "follower"
  has_many :followeds, through: :active_follows, source: "followed"
  has_many :activities
  has_many :notifications
  has_many :won_badges, foreign_key: :winner_id
  has_many :badges, through: :won_badges
  has_many :imports

  scope :more_experience_first, -> { order(arel_table[:experience].desc) }

  validates_inclusion_of :role, in: ROLES

  before_validation :define_role, on: :create
  after_update :set_level!, if: lambda { experience_changed? }

  ROLES.each do |role_type|
    define_method "#{role_type}?" do
      role == role_type
    end
  end

  after_create :create_friendships!

  def followed_users_ids
    active_follows.pluck(:followed_id)
  end

  def followed_users_and_me_ids
    followed_users_ids + [id]
  end

  def following?(user)
    followed_users_ids.include? user.id
  end

  def update_data!(omniauth)
    credentials = omniauth["credentials"]
    self.token = credentials["token"]

    set_avatar!(omniauth)
  end

  def self.generate_from_omniauth(omniauth)
    user = User.new
    user.email = omniauth["info"]["email"]
    user.name = omniauth["info"]["name"]
    user.nickname = get_usable_nickname(user.name.parameterize)
    user.fb_uid = omniauth["uid"]
    user.provider = omniauth["provider"]
    user.password = Devise.friendly_token[0,20]

    user.update_data!(omniauth)
    user
  end

  def self.get_usable_nickname(base_nickname)
    return base_nickname if User.where(nickname: base_nickname).empty?

    i = 1
    nickname = base_nickname + '-' + i.to_s
    while !User.where(nickname: nickname).empty?
      i += 1
      nickname = base_nickname + '-' + i.to_s
    end

    nickname
  end

  def create_friendships!
    return unless token && provider == "facebook"
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

  def to_param
    nickname
  end

  private

  def graph
    @graph ||= Koala::Facebook::API.new(token)
  end

  def define_role
    self.role ||= "user"
  end

  def set_avatar!(omniauth)
    if omniauth["provider"] == "facebook"
      self.small_avatar = graph.get_picture("me")
      self.big_avatar = graph.get_picture("me", { :width => 200,
        :height => 200 })
      self.medium_avatar = graph.get_picture("me", { :width => 100,
        :height => 100 })
    elsif omniauth["provider"] = "twitter"
      self.small_avatar = omniauth["info"]["image"]
      self.medium_avatar = omniauth["info"]["image"].sub("_normal", "")
      self.big_avatar = omniauth["info"]["image"]
    end
  end

  def email_required?
    false
  end

  def set_level!
    my_level = Experience::level_for_experience(experience)

    if my_level != level
      update_attribute(:level, my_level)
    end
  end
end
