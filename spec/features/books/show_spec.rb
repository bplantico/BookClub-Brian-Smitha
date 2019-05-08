require 'rails_helper'

RSpec.describe "as a visitor, " do
  describe "when I visit a book show page" do
    before :each do
      @book_1 = Book.create!(title: "Title 1", pages: 100, year_pub: 1901, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")
      @book_2 = Book.create!(title: "Title 2", pages: 200, year_pub: 1902, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")
      @book_3 = Book.create!(title: "Title 3", pages: 300, year_pub: 1903, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")

      @author_1 = @book_1.authors.create!(name: "Author 1", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")
      @author_2 = @book_1.authors.create!(name: "Author 2", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")
      @author_3 = @book_2.authors.create!(name: "Author 3", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")
      @author_4 = @book_3.authors.create!(name: "Author 4", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")


      @user_1 = User.create!(name: "User One")
      @user_2 = User.create!(name: "User Two")

      @review_1 = @user_1.reviews.create!(title: "Review 1", rating: 1, body: "stuff 1" )
      @review_2 = @user_2.reviews.create!(title: "Review 2", rating: 2, body: "stuff 2" )

      @book_1 << @review_1
      @book_1 << @review_2
      
    end

    it "shows details about the books" do

      visit books_path

      within "#test-book-index-#{@book_1.id}" do
        click_link("#{@book_1.title}")
      end

      expect(current_path).to eq("/books/#{@book_1.id}")
      expect(current_path).to_not eq("/books/#{@book_2.id}")
      expect(page).to have_content(@book_1.title)
      expect(page).to_not have_content(@book_2.title)
      expect(page).to have_content(@book_1.pages)
      expect(page).to have_content(@book_1.year_pub)
      expect(page).to have_css("img[src='#{@book_1.cover_img}']")

      expect(page).to have_content(@author_1.name)
      expect(page).to have_content(@author_2.name)
      expect(page).to_not have_content(@author_3.name)
    end

    it "shows a list of reviews for that book" do
      visit "/books/#{@book_1.id}"

      expect(page).to have_content(@review_1.title)
      expect(page).to have_content(@review_1.rating)
      expect(page).to have_content(@review_1.body)

      expect(page).to have_content(@review_2.title)
      expect(page).to have_content(@review_2.rating)
      expect(page).to have_content(@review_2.body)
    end
  end
end
