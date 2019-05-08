require 'rails_helper'

RSpec.describe "As a visitor " do
  describe "When I visit books index page, " do
    before :each do
      @book_1 = Book.create!(title: "Title 1", pages: 100, year_pub: 1901, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")
      @book_2 = Book.create!(title: "Title 2", pages: 200, year_pub: 1902, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")
      @book_3 = Book.create!(title: "Title 3", pages: 300, year_pub: 1903, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")

      @author_1 = @book_1.authors.create!(name: "Author 1", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")
      @author_2 = @book_1.authors.create!(name: "Author 2", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")
      @author_3 = @book_2.authors.create!(name: "Author 3", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")
      @author_4 = @book_3.authors.create!(name: "Author 4", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")
    end

    it "I see all the books and their attributes" do

      visit books_path

      within "#test-book-index-#{@book_1.id}" do
        expect(page).to have_content(@book_1.title)
        expect(page).to have_content(@book_1.pages)
        expect(page).to have_content(@book_1.year_pub)
        expect(page).to have_content(@author_1.name)
        expect(page).to have_content(@author_2.name)
        expect(page).to have_css("img[src='#{@book_1.cover_img}']")

        expect(page).to_not have_content(@book_2.title)
      end

      within "#test-book-index-#{@book_2.id}" do
        expect(page).to have_content(@book_2.title)
        expect(page).to have_content(@book_2.pages)
        expect(page).to have_content(@book_2.year_pub)
        expect(page).to have_css("img[src='#{@book_2.cover_img}']")
        expect(page).to have_content(@author_3.name)
      end

      within "#test-book-index-#{@book_3.id}" do
        expect(page).to have_content(@book_3.title)
        expect(page).to have_content(@book_3.pages)
        expect(page).to have_content(@book_3.year_pub)
        expect(page).to have_css("img[src='#{@book_3.cover_img}']")
        expect(page).to have_content(@author_4.name)
      end
    end

    it "all the book titles are link to a show page" do
      visit books_path

      within "#test-book-index-#{@book_1.id}" do
        expect(page).to have_link("#{@book_1.title}")
        expect(page).to_not have_link("#{@book_2.title}")
      end

      within "#test-book-index-#{@book_2.id}" do
        expect(page).to have_link("#{@book_2.title}")
      end

      within "#test-book-index-#{@book_3.id}" do
        expect(page).to have_link("#{@book_3.title}")
      end
    end
  end
end
