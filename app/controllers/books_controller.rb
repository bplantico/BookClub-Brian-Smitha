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
    title = (params[:book][:title]).titleize
    if Book.find_titles.include?(title)
      redirect_to new_book_path
    else
      (params[:book][:authors]).split(",").map do |author|
          author = author.downcase.strip.titleize
          book_author = Author.find_or_create_by!(name: author)
          book.authors << book_author
        end
      book.save
      redirect_to book_path(book)
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :pages, :year_pub)
  end
end
