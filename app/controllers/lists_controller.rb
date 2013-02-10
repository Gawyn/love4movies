class ListsController < ApplicationController
  def index
    @user = User.find params[:user_id]
    @lists = @user.lists
    @available_patterns = @user.available_patterns
  end

  def show
    @list = List.find params[:id]
    @movies = @list.movies.decorate
  end

  def create
    pattern = ListPattern.find(params[:list_pattern_id]) if params[:list_pattern_id]
    @list = if pattern
      List.new(:user => current_user, :list_pattern => pattern)
    else
      List.new(:user => current_user, :title => params[:title])
    end
    
    if @list.save
      redirect_to user_list_path(@list, :user_id => current_user)
    else
      redirect_to user_lists_path(current_user)
    end
  end

  def movie_search
    @list = List.find params[:list_id]
    @listed_movies = @list.movies
    @movies = Movie.search(params[:search]).decorate
  end
end
