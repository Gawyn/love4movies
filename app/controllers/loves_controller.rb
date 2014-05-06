class LovesController < ApplicationController
  def create
    @love = Love.find_or_create_by(user_id: current_user.id, 
      lovable_type: params[:lovable_type], lovable_id: params[:lovable_id])

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def destroy
    @love = Love.find params[:id]

    if @love.destroy
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end
end
