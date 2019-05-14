require 'rails_helper'

RSpec.describe User do
  describe "relationships" do
    it { should have_many :reviews }
  end

  describe "validations" do
    it { should validate_presence_of :name }
  end

  before :each do
    @book_1 = Book.create!(title: "Title 1", pages: 100, year_pub: 1901, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")
    @book_2 = Book.create!(title: "Title 2", pages: 200, year_pub: 1902, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")
    @book_3 = Book.create!(title: "Title 3", pages: 300, year_pub: 1903, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")
    @book_4 = Book.create!(title: "Title 4", pages: 400, year_pub: 1904, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")

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

    @review_5 = @book_3.reviews.create!(title: "Review 5", rating: 5, body: "stuff 5", user: @user_1 )

    @review_7 = @book_4.reviews.create!(title: "Review 7", rating: 4, body: "stuff 7", user: @user_4 )
  end

  describe "class methods" do
    it "finds top users based on number of reviews" do
      expect(User.top_three_users).to eq([@user_1, @user_2, @user_4])
    end
  end
end
