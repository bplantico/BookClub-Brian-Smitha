# controllers/reviews_controller.rb

class ReviewsController < ApplicationController

  def new
    @review = Review.new
  end

  def create
    # username = params[:review][:username]
    # User.name.find do |name|

  end

  private

  def review_params
    params.require(:review).permit(:title, :rating, :body)
  end

end
