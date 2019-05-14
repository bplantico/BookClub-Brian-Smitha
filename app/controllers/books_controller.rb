# controllers/books_controller.rb

class BooksController < ApplicationController
  def index
    if params[:sort] == "avg_rating_asc"
      @books = Book.avg_rating("ASC")
    elsif params[:sort] == "avg_rating_desc"
      @books = Book.avg_rating("DESC")
    elsif params[:sort] == "pages_asc"
      @books = Book.sort_by_pages("ASC")
    elsif params[:sort] == "pages_desc"
      @books = Book.sort_by_pages("DESC")
    elsif params[:sort] == "reviews_asc"
      @books = Book.sort_by_reviews("ASC")
    elsif params[:sort] == "reviews_desc"
      @books = Book.sort_by_reviews("DESC")
    else
      @books = Book.all
    end
    @top_three_books = Book.top_three_books
    @bottom_three_books = Book.bottom_three_books
    @top_three_users = User.top_three_users
  end

  def show
    @book = Book.find(params[:id])
  end

  def destroy
    @book = Book.destroy(params[:id])
    redirect_to books_path
  end

  def new
    @book = Book.new
  end

  def create
    book = Book.new(book_params)
    title = (params[:book][:title]).strip.downcase.titleize
    if Book.find_titles.include?(title) || book.pages <= 0
      redirect_to new_book_path
    else
      (params[:book][:authors]).split(",").map do |author|
          author = author.strip.downcase.titleize
          book_author = Author.find_or_create_by!(name: author)
          book.authors << book_author
      end
      book.title = title
      book.save
      redirect_to book_path(book)
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :pages, :year_pub)
  end
end
