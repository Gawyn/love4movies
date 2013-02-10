class ListsController < ApplicationController
  def index
    @user = User.find params[:user_id]
    @lists = @user.lists
    @available_patterns = @user.available_patterns
  end

  def show
    @list = List.find params[:id]
  end

  def create
    pattern = ListPattern.find(params[:list_pattern_id]) if params[:list_pattern_id]
    @list = if pattern
      List.create(:user => current_user, :list_pattern => pattern)
    else
      List.create(:user => current_user, :title => params[:title])
    end

    redirect_to user_list_path(@list, :user_id => current_user)
  end
end
