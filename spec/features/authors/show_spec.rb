require "rails_helper"

RSpec.describe "As a visitor, " do
  describe "when I visit an author's show page" do
    before :each do
      @book_1 = Book.create!(title: "Title 1", pages: 100, year_pub: 1901, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")
      @book_2 = Book.create!(title: "Title 2", pages: 200, year_pub: 1902, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")
      @book_3 = Book.create!(title: "Title 3", pages: 300, year_pub: 1903)
      @book_4 = Book.create!(title: "Title 4", pages: 400, year_pub: 1904)
      @book_5 = Book.create!(title: "Title 5", pages: 500, year_pub: 1905)

      @author_1 = Author.create!(name: "Author 1", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")
      @author_2 = Author.create!(name: "Author 2", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")
      @author_3 = Author.create!(name: "Author 3", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")
      @author_4 = Author.create!(name: "Author 4", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")
      @author_5 = Author.create!(name: "Author 5", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")

      BookAuthor.create!(book: @book_1, author: @author_1)
      BookAuthor.create!(book: @book_1, author: @author_2)
      BookAuthor.create!(book: @book_1, author: @author_3)

      BookAuthor.create!(book: @book_2, author: @author_2)

      BookAuthor.create!(book: @book_3, author: @author_3)

      BookAuthor.create!(book: @book_4, author: @author_4)

      BookAuthor.create!(book: @book_5, author: @author_4)
      BookAuthor.create!(book: @book_5, author: @author_5)
    end

    it "I see authors names are links from book index page" do
      visit books_path

      within "#test-book-index-#{@book_1.id}" do
        expect(page).to have_link(@author_1.name)
        expect(page).to have_link(@author_2.name)
        expect(page).to have_link(@author_3.name)

        expect(page).to_not have_link(@author_4.name)
      end

      within "#test-book-index-#{@book_2.id}" do
        expect(page).to have_link(@author_2.name)
      end

      within "#test-book-index-#{@book_3.id}" do
        expect(page).to have_link(@author_3.name)
      end
    end

    it "I am taken to author's show page when I click their name from book index" do
      visit books_path

      within "#test-book-index-#{@book_1.id}" do
        expect(page).to have_link(@author_1.name)
        expect(page).to have_link(@author_2.name)
      end

      click_link "#{@author_1.name}"
      expect(current_path).to eq(author_path(@author_1.id))
    end

    it "I see a link from book show page, I click the link to go to author's show page" do
      visit book_path(@book_1.id)

      expect(page).to have_link(@author_1.name)
      expect(page).to have_link(@author_2.name)

      click_link "#{@author_1.name}"
      expect(current_path).to eq(author_path(@author_1.id))
    end

    it "I can see the selected author's information" do
      visit author_path(@author_2.id)

      expect(current_path).to eq(author_path(@author_2.id))

      expect(page).to have_content(@author_2.name)

      within "#test-author-book-info-#{@book_1.id}" do
        expect(page).to have_link(@book_1.title)
        expect(page).to have_content("Number of Pages: #{@book_1.pages}")
        expect(page).to have_content("Year Published: #{@book_1.year_pub}")
        expect(page).to have_css("img[src='#{@book_1.cover_img}']")
        expect(page).to have_content("Co-Author: #{@author_1.name}")
        expect(page).to have_content("Co-Author: #{@author_3.name}")

        expect(page).to_not have_content(@book_3.title)
      end

      within "#test-author-book-info-#{@book_2.id}" do
        expect(page).to have_link(@book_2.title)
        expect(page).to have_content("Number of Pages: #{@book_2.pages}")
        expect(page).to have_content("Year Published: #{@book_2.year_pub}")
        expect(page).to have_css("img[src='#{@book_2.cover_img}']")

        expect(page).to_not have_content("Co-Author: #{@author_1.name}")
      end
    end

    it "shows co-author's names as links to their respective show page." do
      visit author_path(@author_2.id)

      expect(current_path).to eq(author_path(@author_2.id))

      expect(page).to have_link(@author_1.name)

      click_link "#{@author_1.name}"
      expect(current_path).to eq(author_path(@author_1.id))
    end

    it "I see a link to delete the author" do
      visit author_path(@author_4.id)
      expect(current_path).to eq(author_path(@author_4.id))

      expect(page).to have_link("Delete Author")
    end

    it "I click on delete author, I no longer see the author and their books" do
      visit author_path(@author_4.id)
      expect(current_path).to eq(author_path(@author_4.id))

      expect(page).to have_link("Delete Author")
      click_link "Delete Author"
      expect(current_path).to eq(books_path)
      expect(page).to_not have_content(@author_4.name)

      expect(page).to_not have_content(@book_4.title)
      expect(page).to_not have_content(@book_5.title)
    end

    it "I click on delete author, I can see the co-author and their own book" do
      # binding.pry
      visit author_path(@author_5.id)
      expect(current_path).to eq(author_path(@author_5.id))

      expect(page).to have_link("Delete Author")
      click_link "Delete Author"

      expect(current_path).to eq(books_path)
      expect(page).to_not have_content(@book_5.title)
      expect(page).to_not have_content(@author_5.name)

      expect(page).to have_content(@book_4.title)
      expect(page).to have_content(@author_4.name)

      expect(page).to have_content(@book_1.title)
      expect(page).to have_content(@author_1.name)

      expect(page).to have_content(@book_2.title)
      expect(page).to have_content(@author_2.name)
    end
  end
end
