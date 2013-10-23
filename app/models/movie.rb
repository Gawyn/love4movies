class Movie < ActiveRecord::Base
  BASIC_ATTRIBUTES = ["title", "overview"].map do |attr|
    LOCALES.map do |locale|
      "#{attr}_#{locale}"
    end
  end.flatten

  translates :title, :overview

  validates_uniqueness_of :tmdb_id
  validate :not_hidden_needs_poster

  has_many :participations, :dependent => :destroy
  has_many :performances
  has_many :technical_participations
  has_many :people, :through => :participations
  has_many :actors, :through => :performances, :source => :person
  has_many :technical_members, :through => :technical_participations, :source => :person
  has_and_belongs_to_many :genres
  has_many :ratings, :dependent => :destroy
  has_many :images, :dependent => :destroy
  has_many :posters
  has_many :backdrops
  has_many :comments, :dependent => :destroy
  has_many :list_belongings, :dependent => :destroy
  has_many :lists, :through => :list_belongings

  scope :by_rating_average, -> { order(arel_table[:rating_average].desc) }
  scope :hidden, -> { where(hidden: true) }
  scope :not_hidden, -> { where(:hidden => false) }
  scope :more_total_ratings_than, lambda { |total| where(arel_table[:total_ratings].gt(total)) }
  scope :by_popularity, -> { order(arel_table[:popularity].desc) }

  before_create :set_hidden
  before_create :set_total_ratings

  def calculate_rating_average
    if ratings.any?
      total_ratings = ratings.count
      my_ratings_average = ratings.pluck(:value).sum.to_f/total_ratings
      (my_ratings_average * total_ratings + tmdb_vote_average * tmdb_vote_count) / (total_ratings + tmdb_vote_count)
    else
      tmdb_vote_average
    end
  end

  def self.search(title)
    Movie.where(Movie.arel_table[:title_en].matches("%#{title}%"))
  end

  private

  def set_hidden
    self.hidden ||= true if tmdb_vote_count == 0 || genres.empty?
  end

  def set_total_ratings
    self.total_ratings = tmdb_vote_count
  end

  def not_hidden_needs_poster
    errors.add(:not_hidden_needs_poster, "A public movie needs a poster") if !hidden && !tmdb_poster_path
  end
end
