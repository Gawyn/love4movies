class Admin::HomeController < Admin::AdminController
  def index
    @user_number = User.count
    @movie_number = Movie.count
  end
end
