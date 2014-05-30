class Rating < ActiveRecord::Base
  belongs_to :movie, counter_cache: true
  belongs_to :user, :counter_cache => true

  has_many :comments, as: :commentable
  has_many :loves, counter_cache: true

  validates_inclusion_of :value, :in => 1..10
  validates_presence_of :movie_id, :user_id
  validates_uniqueness_of :user_id, :scope => :movie_id

  scope :newest_first, -> { order(arel_table[:updated_at].desc) }
  scope :highest_first, -> { order(arel_table[:value].desc) }
  scope :with_short_review, -> { where(with_short_review: true) }
  scope :without_short_review, -> { where(with_short_review: false) }
  scope :most_loved_first, -> { order(arel_table[:loves_count].desc) }

  before_save :set_with_short_review

  after_create :give_rating_experience!
  after_destroy :take_rating_experience!

  after_save :recalculate_movie_ratings
  after_destroy :recalculate_movie_ratings

  after_commit :check_badges!
  after_commit :create_activity!, on: :create

  scope :by_value, -> { order(arel_table[:value].desc) }

  private

  def recalculate_movie_ratings
    new_rating = movie.calculate_rating_average

    if movie.rating_average != new_rating
      movie.rating_average = new_rating
    end

    new_l4m_rating = movie.calculate_l4m_rating_average

    if movie.l4m_rating_average != new_l4m_rating
      movie.l4m_rating_average = new_l4m_rating
    end

    movie.total_ratings += 1
    movie.save
  end

  def create_activity!
    Activity.create(user_id: user_id, content: self)
  end

  def check_badges!
    return unless with_short_review
    Badge.all.each do |badge|
      WonBadge.create(winner_id: user.id, badge_id: badge.id) if badge.can_receive?(user)
    end
  end

  def set_with_short_review
    with_short_review = short_review.present?
    true
  end

  def give_rating_experience!
    give_experience!(user, short_review.present? ? SHORT_REVIEW_EXPERIENCE : RATING_EXPERIENCE)
  end

  def take_rating_experience!
    tak_experience!(user, short_review.present? ? SHORT_REVIEW_EXPERIENCE : RATING_EXPERIENCE)
  end
end
