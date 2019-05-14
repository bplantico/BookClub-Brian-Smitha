require "rails_helper"

RSpec.describe "As a visitor, " do
  describe "when I visit the book index page, " do
    before :each do

      @book_1 = Book.create!(title: "Title 1", pages: 100, year_pub: 1901, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")
      @book_2 = Book.create!(title: "Title 2", pages: 200, year_pub: 1902, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")
      @book_3 = Book.create!(title: "Title 3", pages: 300, year_pub: 1903)
      @book_4 = Book.create!(title: "Title 4", pages: 400, year_pub: 1904)


      @author_1 = @book_1.authors.create!(name: "Author 1", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")
      @author_2 = @book_1.authors.create!(name: "Author 2", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")
      @author_3 = @book_2.authors.create!(name: "Author 3", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")
      @author_4 = @book_3.authors.create!(name: "Author 4", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")
      @author_5 = @book_4.authors.create!(name: "Author 5")

      @user_1 = User.create!(name: "User One")
      @user_2 = User.create!(name: "User Two")
      @user_3 = User.create!(name: "User Three")
      @user_4 = User.create!(name: "User Four")

      @review_1 = @book_1.reviews.create!(title: "Review 1", rating: 1, body: "stuff 1", user: @user_1 )
      @review_2 = @book_1.reviews.create!(title: "Review 2", rating: 2, body: "stuff 2", user: @user_2 )
      @review_7 = @book_1.reviews.create!(title: "Review 7", rating: 3, body: "stuff 2", user: @user_3 )

      @review_3 = @book_2.reviews.create!(title: "Review 3", rating: 3, body: "stuff 3", user: @user_1 )
      @review_4 = @book_2.reviews.create!(title: "Review 4", rating: 3, body: "stuff 4", user: @user_2 )

      @review_5 = @book_3.reviews.create!(title: "Review 5", rating: 1, body: "stuff 5", user: @user_3 )

      @review_6 = @book_4.reviews.create!(title: "Review 6", rating: 4, body: "stuff 5", user: @user_4 )
    end

    it "I should see a links for each sorting" do
      visit books_path

      expect(page).to have_link("Sort By Average Rating (Ascending)")
      expect(page).to have_link("Sort By Average Rating (Descending)")
      expect(page).to have_link("Sort By Number of Pages (Ascending)")
      expect(page).to have_link("Sort By Number of Pages (Descending)")
      expect(page).to have_link("Sort By Number of Reviews (Ascending)")
      expect(page).to have_link("Sort By Number of Reviews (Descending)")
    end

    it "I should see all books sorted by average rating in ascending order" do
      visit books_path

      click_link "Sort By Average Rating (Ascending)"

      within '.books-index' do
        expect(page.all('div')[0]).to have_content(@book_3.title)
        expect(page.all('div')[1]).to have_content("Title 1")
        expect(page.all('div')[2]).to have_content("Title 2")
        expect(page.all('div')[3]).to have_content("Title 4")
      end
    end

    it "I should see all books sorted by average rating in descending order" do
      visit books_path

      click_link "Sort By Average Rating (Descending)"

      within '.books-index' do
        expect(page.all('div')[0]).to have_content("Title 4")
        expect(page.all('div')[1]).to have_content("Title 2")
        expect(page.all('div')[2]).to have_content("Title 1")
        expect(page.all('div')[3]).to have_content("Title 3")
      end
    end

    it "I should see all books sorted by number of pages in ascending order" do
      visit books_path

      click_link "Sort By Number of Pages (Ascending)"

      within '.books-index' do
        expect(page.all('div')[0]).to have_content("Title 1")
        expect(page.all('div')[1]).to have_content("Title 2")
        expect(page.all('div')[2]).to have_content("Title 3")
        expect(page.all('div')[3]).to have_content("Title 4")
      end
    end

    it "I should see all books sorted by number of pages in descending order" do
      visit books_path

      click_link "Sort By Number of Pages (Descending)"

      within '.books-index' do
        expect(page.all('div')[0]).to have_content("Title 4")
        expect(page.all('div')[1]).to have_content("Title 3")
        expect(page.all('div')[2]).to have_content("Title 2")
        expect(page.all('div')[3]).to have_content("Title 1")
      end
    end

    it "I should see all books sorted by number of reviews in ascending order" do
      visit books_path

      click_link "Sort By Number of Reviews (Ascending)"

      within '.books-index' do
        expect(page.all('div')[0]).to have_content("Title 3")
        expect(page.all('div')[1]).to have_content("Title 4")
        expect(page.all('div')[2]).to have_content("Title 2")
        expect(page.all('div')[3]).to have_content("Title 1")
      end
    end

    it "I should see all books sorted by number of reviews in descending order" do
      visit books_path

      click_link "Sort By Number of Reviews (Descending)"

      within '.books-index' do
        expect(page.all('div')[0]).to have_content("Title 1")
        expect(page.all('div')[1]).to have_content("Title 2")
        expect(page.all('div')[2]).to have_content("Title 3")
        expect(page.all('div')[3]).to have_content("Title 4")
      end
    end
  end
end
