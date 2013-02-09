class ListsController < ApplicationController
  def index
    @user = User.find params[:user_id]
    @lists = @user.lists
  end
end
