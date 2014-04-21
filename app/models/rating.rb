class Rating < ActiveRecord::Base
  belongs_to :movie, counter_cache: true
  belongs_to :user, :counter_cache => true

  has_many :comments, as: :commentable

  validates_inclusion_of :value, :in => 1..10
  validates_presence_of :movie_id, :user_id
  validates_uniqueness_of :user_id, :scope => :movie_id

  scope :newest_first, -> { order(arel_table[:updated_at].desc) }

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
    Badge.where(id: MovieInBadge.where(movie_id: movie_id).pluck(:badge_id)).each do |badge|
      WonBadge.create(winner_id: user.id, badge_id: badge.id) if badge.can_receive?(user)
    end
  end
end
