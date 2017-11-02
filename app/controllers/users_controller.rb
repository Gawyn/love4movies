# encoding: utf-8
class UsersController < ApplicationController
  def login
    redirect_to root_path if current_user

    user = request.env["omniauth.auth"] ? omniauth_login : password_login

    if user && user.save
      session[:just_logged_in] = true
      sign_in_and_redirect(:user, user)
    else
      redirect_to root_path
    end
  end

  def in
    render layout: "landing"
  end

  def decade
    @decade = params[:decade]
    start_year = params[:decade][0..3].to_i
    end_year = start_year + 9

    @user = User.find_by_nickname params[:user_id]
    ratings = @user.ratings.by_value.joins(:movie).where("extract(year from release_date) >= ? and extract(year from release_date) <= ?", start_year, end_year)

    @total_pages = (ratings.count.to_f / Movie::MOVIES_PER_PAGE).ceil
    @ratings = ratings.page(params[:page]).per(Movie::MOVIES_PER_PAGE)

    @js_url = "/users/#{@user.nickname}/#{@decade}"

    render "year"
  end

  def year
    @year = params[:year]
    @user = User.find_by_nickname params[:user_id]
    @total_pages = (@user.ratings.by_value.joins(:movie).where("extract(year from release_date) = ?", params[:year]).count.to_f / Movie::MOVIES_PER_PAGE).ceil
    @ratings = @user.ratings.by_value.joins(:movie).where("extract(year from release_date) = ?", params[:year]).page(params[:page]).per(Movie::MOVIES_PER_PAGE)

    @js_url = "/users/#{@user.nickname}/#{@year}"
  end

  def ranking
    @user = User.find_by_nickname params[:user_id]
    @total_pages = (@user.ratings.count.to_f / Movie::MOVIES_PER_PAGE).ceil
    @ratings = @user.ratings.by_value.includes(:movie).page(params[:page]).per(Movie::MOVIES_PER_PAGE)
  end

  def show
    @user = User.find_by_nickname params[:id]
    @ratings = @user.ratings.newest_first.includes(:movie).page(params[:page])
    @highest_ratings = @user.ratings.by_value.includes(:movie).limit(8)
    @follow = Follow.find_by(follower_id: current_user.id, followed_id: @user.id) if current_user
  end

  def index
    @users = User.more_experience_first
    @active_follows = current_user.active_follows if current_user
  end

  private

  def omniauth_login
    omniauth = request.env["omniauth.auth"]
    user = User.find_by_fb_uid(omniauth["uid"])

    if user
      user.update_data!(omniauth)
    else
      user = User.generate_from_omniauth(omniauth)
    end

    user
  end

  def password_login
    user = User.find_by_email(params[:email])

    sign_in(user) if user && user.valid_password?(params[:password])

    user
  end
end
