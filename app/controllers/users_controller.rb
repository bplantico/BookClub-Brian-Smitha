# controllers/users_controller.rb

class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])

    if params[:sort] == "newest"
      @reviews = @user.sort_reviews_newest
    elsif params[:sort] == "oldest"
      @reviews = @user.sort_reviews_oldest
    else
      @reviews = @user.reviews
    end
  end

end
