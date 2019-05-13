# controllers/reviews_controller.rb

class ReviewsController < ApplicationController

  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create

    review = Review.new(review_params)
    title = review_params[:title].strip.downcase.titleize
    review.title = title

    # find the user object
    user = user_params[:user].strip.downcase.titleize
    user = User.find_or_create_by(name: user_params[:user])
    review.user = user

    # find the book
    book = Book.find(params[:book_id])
    review.book_id = book.id

    # reject if user.id already in book.reviews
    if Review.array_of_reviewer_ids.include?(user.id)
      redirect_to new_book_review_path
    else
      review.save
      redirect_to book_path(book)
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :rating, :body)
  end

  def user_params
    params.require(:review).permit(:user)
  end

end
