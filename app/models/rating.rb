class Rating < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user, :counter_cache => true

  validates_inclusion_of :value, :in => 1..10
  validates_presence_of :movie_id, :user_id
  validates_uniqueness_of :user_id, :scope => :movie_id

  after_save :recalculate_movie_rating
  after_destroy :recalculate_movie_rating

  scope :by_value, -> { order(arel_table[:value].desc) }

  private

  def recalculate_movie_rating
    new_rating = movie.calculate_rating_average

    if movie.rating_average != new_rating
      movie.rating_average = new_rating
    end

    movie.total_ratings += 1
    movie.save
  end
end
