require "rails_helper"

RSpec.describe "As a visitor, " do
  describe "when I visit an author's show page" do
    before :each do
      @book_1 = Book.create!(title: "Title 1", pages: 100, year_pub: 1901, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")
      @book_2 = Book.create!(title: "Title 2", pages: 200, year_pub: 1902, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")
      @book_3 = Book.create!(title: "Title 3", pages: 300, year_pub: 1903)

      @author_1 = Author.create!(name: "Author 1", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")
      @author_2 = Author.create!(name: "Author 2", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")
      @author_3 = Author.create!(name: "Author 3", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")

      BookAuthor.create!(book: @book_1, author: @author_1)
      BookAuthor.create!(book: @book_1, author: @author_2)

      BookAuthor.create!(book: @book_2, author: @author_2)

      BookAuthor.create!(book: @book_3, author: @author_3)
    end

    it "I click on author link from book index page" do
      visit books_path

      within "#test-book-index-#{@book_1.id}" do
        expect(page).to have_link(@author_1.name)
        expect(page).to have_link(@author_2.name)

        expect(page).to_not have_link(@author_3.name)
      end

      within "#test-book-index-#{@book_2.id}" do
        expect(page).to have_link(@author_2.name)
      end

      within "#test-book-index-#{@book_3.id}" do
        expect(page).to have_link(@author_3.name)
      end
    end
  end
end

# As a Visitor,
# When I visit an author's show page
# I see all books by that author
# Each book should show:
# - the book title
# - the number of pages in the book
# - the year the book was published
# - a small image of the book cover
