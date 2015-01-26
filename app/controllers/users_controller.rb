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

  def ranking
    @user = User.find params[:user_id]
    @ratings = @user.ratings.by_value.includes(:movie)
  end

  def show
    @user = User.find params[:id]
    @ratings = @user.ratings.newest_first.includes(:movie).page(params[:page])
    @highest_ratings = @user.ratings.highest_first.includes(:movie).limit(8)
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
