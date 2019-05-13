require 'rails_helper'

RSpec.describe "When I visit the author's show page" do
  before :each do
    @book_1 = Book.create!(title: "Title 1", pages: 100, year_pub: 1901, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")
    @book_2 = Book.create!(title: "Title 2", pages: 200, year_pub: 1902, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")
    @book_3 = Book.create!(title: "Title 3", pages: 300, year_pub: 1903)
    @book_4 = Book.create!(title: "Title 4", pages: 400, year_pub: 1904)
    @book_5 = Book.create!(title: "Title 5", pages: 500, year_pub: 1905)

    @author_1 = Author.create!(name: "Author 1", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")
    @author_2 = Author.create!(name: "Author 2", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")

    BookAuthor.create!(book: @book_1, author: @author_1)
    BookAuthor.create!(book: @book_1, author: @author_2)

    BookAuthor.create!(book: @book_2, author: @author_1)
    BookAuthor.create!(book: @book_2, author: @author_2)

    BookAuthor.create!(book: @book_3, author: @author_1)

    BookAuthor.create!(book: @book_4, author: @author_1)

    @user_1 = User.create!(name: "User One")
    @user_2 = User.create!(name: "User Two")
    @user_3 = User.create!(name: "User Three")
    @user_4 = User.create!(name: "User Four")

    @review_1 = @book_1.reviews.create!(title: "Review 1", rating: 1, body: "stuff 1", user: @user_1)
    @review_2 = @book_1.reviews.create!(title: "Review 2", rating: 2, body: "stuff 2", user: @user_2)
    @review_3 = @book_1.reviews.create!(title: "Review 3", rating: 3, body: "stuff 3", user: @user_3)

    @review_4 = @book_2.reviews.create!(title: "Review 4", rating: 1, body: "stuff 4", user: @user_1)
    @review_5 = @book_2.reviews.create!(title: "Review 5", rating: 2, body: "stuff 5", user: @user_2)

    @review_6 = @book_3.reviews.create!(title: "Review 6", rating: 5, body: "stuff 6", user: @user_2)

    # @review_7 = @book_4.reviews.create!(title: "Review 7", rating: 2, body: "stuff 7", user: @user_2)
  end

  it "I should see one of the highest rated reviews for each book" do
    visit author_path(@author_1.id)
    expect(current_path).to eq(author_path(@author_1.id))

    within "#test-author-book-info-#{@book_1.id}" do
      expect(page).to have_content("Review Title: Review 3")
      expect(page).to have_content("User Name: User Three")
      expect(page).to have_content("Rating: 3")
      expect(page).to have_content("Description: Stuff 3")

      expect(page).to_not have_content("Review Title: Review 1")
    end

    within "#test-author-book-info-#{@book_2.id}" do
      expect(page).to have_content("Review Title: Review 5")
      expect(page).to have_content("User Name: User Two")
      expect(page).to have_content("Rating: 2")
      expect(page).to have_content("Description: stuff 5")
    end

    within "#test-author-book-info-#{@book_2.id}" do
      expect(page).to have_content("Review Title: Review 6")
      expect(page).to have_content("User Name: User Two")
      expect(page).to have_content("Rating: 5")
      expect(page).to have_content("Description: stuff 6")
    end
  end
# (review should contain the title, score, and user name)
end
