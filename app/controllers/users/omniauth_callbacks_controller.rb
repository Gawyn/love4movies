class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    redirect_to root_path if current_user

    user = request.env["omniauth.auth"] ? omniauth_login : password_login

    if user && user.save
      session[:just_logged_in] = true
      sign_in_and_redirect(:user, user)
    else
      redirect_to root_path
    end
  end

  def twitter
    facebook
  end

  private

  def omniauth_login
    omniauth = request.env["omniauth.auth"]
    return unless omniauth['uid']
    user = User.find_by_fb_uid(omniauth["uid"])

    if user
      user.update_data!(omniauth)
    else
      user = User.generate_from_omniauth(omniauth)
    end

    user
  end

  def password_login
    return unless params[:email]
    user = User.find_by_email(params[:email])

    sign_in(user) if user && user.valid_password?(params[:password])

    user
  end
end
