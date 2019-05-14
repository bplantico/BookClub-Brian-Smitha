require 'rails_helper'

RSpec.describe "As a visitor " do
  describe "When I visit books index page, " do
    before :each do

      @book_1 = Book.create!(title: "Title 1", pages: 100, year_pub: 1901, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")
      @book_2 = Book.create!(title: "Title 2", pages: 200, year_pub: 1902, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")
      @book_3 = Book.create!(title: "Title 3", pages: 300, year_pub: 1903)
      @book_4 = Book.create!(title: "Title 4", pages: 300, year_pub: 1903)

      @author_1 = @book_1.authors.create!(name: "Author 1", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")
      @author_2 = @book_1.authors.create!(name: "Author 2", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")
      @author_3 = @book_2.authors.create!(name: "Author 3", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")
      @author_4 = @book_3.authors.create!(name: "Author 4", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")
      @author_5 = @book_4.authors.create!(name: "Author 5", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")

      @user_1 = User.create!(name: "User One")
      @user_2 = User.create!(name: "User Two")
      @user_3 = User.create!(name: "User Three")
      @user_4 = User.create!(name: "User Four")

      @review_1 = @book_1.reviews.create!(title: "Review 1", rating: 1, body: "stuff 1", user: @user_1 )
      @review_2 = @book_1.reviews.create!(title: "Review 2", rating: 2, body: "stuff 2", user: @user_2 )
      @review_6 = @book_1.reviews.create!(title: "Review 6", rating: 3, body: "stuff 6", user: @user_3 )

      @review_3 = @book_2.reviews.create!(title: "Review 3", rating: 3, body: "stuff 3", user: @user_1 )
      @review_4 = @book_2.reviews.create!(title: "Review 4", rating: 3, body: "stuff 4", user: @user_2 )

      @review_5 = @book_3.reviews.create!(title: "Review 5", rating: 4, body: "stuff 5", user: @user_1 )

      @review_7 = @book_4.reviews.create!(title: "Review 7", rating: 5, body: "stuff 7", user: @user_4 )
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

    it "shows the average rating and number of reviews for each book title" do

      visit books_path

      within "#test-book-index-#{@book_1.id}" do
        expect(page).to have_content("Rating: #{@book_1.average_rating}")
        expect(page).to have_content("Reviews: #{@book_1.total_reviews}")

        expect(page).to_not have_content("Rating: #{@book_2.average_rating}")
        expect(page).to_not have_content("Reviews: #{@book_2.total_reviews}")
      end

      within "#test-book-index-#{@book_2.id}" do
        expect(page).to have_content("Reviews: #{@book_2.total_reviews}")
        expect(page).to have_content("Rating: #{@book_2.average_rating}")
      end

      within "#test-book-index-#{@book_3.id}" do
        expect(page).to have_content("Reviews: #{@book_3.total_reviews}")
        expect(page).to have_content("Rating: #{@book_3.average_rating}")
      end

    end

    it "shows statistics for all books" do
      visit books_path

      within "#test-best-books" do
        expect(page.all('ul')[0]).to have_content("Title: #{@book_4.title}")
        expect(page.all('ul')[0]).to have_content("Average Rating: #{@book_4.average_rating}")
        expect(page.all('ul')[2]).to have_content("Title: #{@book_2.title}")
        expect(page.all('ul')[2]).to have_content("Average Rating: #{@book_2.average_rating}")
      end
      within "#test-worst-books" do
        expect(page.all('ul')[0]).to have_content("Title: #{@book_1.title}")
        expect(page.all('ul')[0]).to have_content("Average Rating: #{@book_1.average_rating}")
        expect(page.all('ul')[2]).to have_content("Title: #{@book_3.title}")
        expect(page.all('ul')[2]).to have_content("Average Rating: #{@book_3.average_rating}")
      end
      within "#test-best-users" do
        expect(page.all('ul')[0]).to have_content("User Name: #{@user_1.name}")
        expect(page.all('ul')[0]).to have_content("Number of Reviews: #{@user_1.reviews.count}")
        expect(page.all('ul')[2]).to have_content("User Name: #{@user_4.name}")
        expect(page.all('ul')[2]).to have_content("Number of Reviews: #{@user_4.reviews.count}")
      end
    end
  end
end
