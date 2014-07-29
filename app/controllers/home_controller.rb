class HomeController < ApplicationController
  def index
    if current_user
      @type = calculate_type
      show_home
    else
      render "no_current_user", layout: "landing"
    end
  end

  def show_home
    if @type == "activities"

      @followeds_activities = Activity.where(user_id: current_user.followed_users_and_me_ids).includes(:user).includes(:content).order("created_at desc").limit(12)
      @users = User.more_experience_first.first(10)

    elsif @type == "popularity"
      popular_movies_ids = Rating.where("created_at > ?", Time.now - 1.month).pluck(:movie_id).inject(Hash.new(0)) do |r, v|
        r[v] += 1
        r
      end.sort_by(&:last).reverse[0..19].map(&:first)

      @popular_movies = Movie.find(popular_movies_ids).index_by(&:id).values_at(*popular_movies_ids)
    end
  end

  private

  def calculate_type
    if ["activities", "popularity"].include?(params[:type])
      params[:type]
    else
      "activities"
    end
  end
end
