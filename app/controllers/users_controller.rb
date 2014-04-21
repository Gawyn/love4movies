# encoding: utf-8
class UsersController < ApplicationController
  def login
    redirect_to root_path if current_user

    omniauth = request.env["omniauth.auth"]
    user = User.find_by_fb_uid(omniauth["uid"])

    if user
      user.update_data!(omniauth)
    else
      user = User.generate_from_omniauth(omniauth)
    end

    if user.save
      session[:just_logged_in] = true
      sign_in_and_redirect(:user, user)
    else
      redirect_to root_path
    end
  end

  def ranking
    @user = User.find params[:user_id]
    @ratings = @user.ratings.by_value.includes(:movie)
  end

  def show
    @user = User.find params[:id]
    @ratings = @user.ratings.newest_first.includes(:movie).page(params[:page])
    render layout: "person"
  end
end
