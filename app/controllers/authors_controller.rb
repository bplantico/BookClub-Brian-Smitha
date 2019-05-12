class AuthorsController < ApplicationController
  def show
    @author = Author.find(params[:id])
  end

  def destroy
    author = Author.find(params[:id])
    author.books.each do |book|
        book.authors.each do |book_author|
        # binding.pry
          if book_author.books.count <= 1
            book_author.destroy
          end
        end
      book.destroy
    end
    redirect_to books_path
  end
end
