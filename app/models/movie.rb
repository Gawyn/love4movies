class Movie < ActiveRecord::Base
  MOVIES_PER_PAGE = 24
  BASIC_ATTRIBUTES = ["title"].map do |attr|
    LOCALES.map do |locale|
      "#{attr}_#{locale}"
    end
  end.flatten

  translates :title, :overview

  validates_uniqueness_of :tmdb_id

  has_many :participations, :dependent => :destroy
  has_many :performances
  has_many :technical_participations
  has_many :people, :through => :participations
  has_many :actors, :through => :performances, :source => :person
  has_many :technical_members, :through => :technical_participations, :source => :person
  has_and_belongs_to_many :genres
  has_many :ratings, :dependent => :destroy
  has_many :images, as: :owner, :dependent => :destroy
  has_many :posters, as: :owner
  has_many :backdrops, as: :owner
  has_many :reviews, :dependent => :destroy
  has_many :list_belongings, :dependent => :destroy
  has_many :lists, :through => :list_belongings
  has_many :movie_in_badges
  has_many :badges, through: :movie_in_badges
  has_many :country_movies
  has_many :countries, through: :country_movies

  scope :by_rating_average, -> { order(arel_table[:rating_average].desc) }
  scope :by_l4m_rating_average, -> { order(arel_table[:l4m_rating_average].desc) }
  scope :hidden, -> { where(hidden: true) }
  scope :not_hidden, -> { where(:hidden => false) }
  scope :more_total_ratings_than, lambda { |total| where(arel_table[:total_ratings].gt(total)) }
  scope :more_ratings_than, lambda { |total| where(arel_table[:ratings_count].gt(total)) }
  scope :by_popularity, -> { order(arel_table[:popularity].desc) }

  before_create :set_total_ratings
  before_create :set_slug
  before_save :hide_adult!

  searchable do
    integer :id
    text :original_title
    text :title_en
    text :title_es
    boolean :hidden
    integer :ratings_count
    integer :total_ratings
    integer :genre_ids, multiple: true
    double :l4m_rating_average
    double :tmdb_vote_average
    double :rating_average
    double :popularity
  end

  def calculate_rating_average
    if ratings.any?
      total_ratings = ratings.count
      my_ratings_average = ratings.pluck(:value).sum.to_f/total_ratings
      (my_ratings_average * total_ratings + tmdb_vote_average * tmdb_vote_count) / (total_ratings + tmdb_vote_count)
    else
      tmdb_vote_average
    end
  end

  def calculate_l4m_rating_average
    ratings.pluck(:value).sum.to_f/ratings.count
  end

  def self.standard_search(query, locale = I18n.locale)
    search do
      fulltext query do
        fields(:original_title, ("title_" + I18n.locale.to_s).to_sym)
      end
      order_by(:popularity, :desc)
      with :hidden, false
    end
  end

  def set_slug
    self.slug = self.original_title.to_ascii.parameterize

    if Movie.find_by_slug(slug)
      self.slug = slug + "-#{release_date.year}" unless release_date.blank?

      if Movie.find_by_slug(slug)
        i = 2
        self.slug = slug + "-#{i}"

        while Movie.find_by_slug(slug)
          i = i + 1
          splitted_slug = slug.split("-")
          splitted_slug[-1] = i.to_s
          self.slug = splitted_slug.join("-")
        end
      end
    end
  end

  def to_param
    slug
  end

  private

  def set_total_ratings
    self.total_ratings = tmdb_vote_count
  end

  def hide_adult!
    self.hidden = true if adult
  end
end
