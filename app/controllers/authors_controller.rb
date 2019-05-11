class AuthorsController < ApplicationController
  def show
    @author = Author.find(params[:id])
  end
end

#look at all books assoc with author
#for each book check if it has multiple authors
#assign the other author to an ivar and call that within the iteration on author show page.
