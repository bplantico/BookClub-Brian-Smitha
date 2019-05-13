require 'rails_helper'

RSpec.describe Author do
  describe "relationships" do
    it { should have_many :book_authors }
    it { should have_many(:books).through(:book_authors) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :author_img }
  end

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

  describe "instance methods" do
    it "can find top reviews for each book for a specific author" do
      expect(@author_1.find_top_review).to eq([@review_3, @review_2, @review_6])
    end
  end
end
