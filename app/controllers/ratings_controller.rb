class RatingsController < ApplicationController
  def show
    @rating = Rating.find params[:id]
    @movie = @rating.movie
    @loves = Love.where(lovable_type: "Rating", lovable_id: @rating)
      .includes(:user).group_by(&:lovable_id)

    @description = @rating.short_review || @movie.overview

    @title = "#{@rating.user.name} on #{@movie.title}"
    @fb_title = "#{@movie.title} - #{'&#9733;' * @rating.value}#{'&#9734;' * (10 - @rating.value)}".html_safe
  end

  def create
    @my_rating = Rating.find_by_user_id_and_movie_id(current_user.id,
      params[:movie_id])

    if @my_rating
      @my_rating.update( value: params[:value],
        short_review: params[:short_review].nil? ? @my_rating.short_review : params[:short_review] )
    else
      @my_rating = Rating.create(:user_id => current_user.id,
        :movie_id => params[:movie_id], :value => params[:value],
        short_review: params[:short_review])
    end

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def destroy
    @rating = Rating.find params[:id]

    if @rating.destroy
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end
end
