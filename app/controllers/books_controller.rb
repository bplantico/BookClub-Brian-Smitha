# controllers/books_controller.rb

class BooksController < ApplicationController
  def index
    @books = Book.all
  end
end
