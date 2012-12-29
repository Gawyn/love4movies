# encoding: utf-8
class UsersController < ApplicationController
  def login
    redirect_to root_path if current_user

    omniauth = request.env["omniauth.auth"]
    user = User.find_by_fb_uid(omniauth["uid"])

    if user
      user.update_credentials!(omniauth)
    else
      user = User.generate_from_omniauth(omniauth)
      user.save
      flash[:notice] = "¡Bienvenido!"
    end

    sign_in_and_redirect(:user, user)
  end
end
