# controllers/books_controller.rb

class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    book = Book.new(book_params)
    book.save
    #before saving, condition for book exits and titlize
    #before saving, condition for author exists and comma-separated stuff
    #conditional for default image, after saving
    #after saving, authors, if new will be added to db.
    redirect_to book_path(book)
  end

  private

  def book_params
    params.require(:book).permit(:title, :pages, :year_pub, :cover_img)
  end
end
