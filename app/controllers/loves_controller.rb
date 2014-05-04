class LovesController < ApplicationController
  def create
    @love = Rating.find_or_create_by_user_id_and_lovable_type_and_lovable_id(
      current_user.id, params[:lovable_type], params[:lovable_id])

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
