require 'rails_helper'

RSpec.describe Review do
  describe "relationships" do
    it { should belong_to :book }
    it { should belong_to :user }
  end

  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :rating }
    it { should validate_presence_of :body }
  end

  describe "class methods" do
    it "should return array of all reviewer ids" do
      book_1 = Book.create!(title: "Title 1", pages: 100, year_pub: 1901, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")

      jeff = User.create!(name: "Jeff")
      jp = User.create!(name: "JP")

      review_1 = Review.create!(title: "Review 1", rating: 4, body: "This is the first review on this book", book_id: book_1.id, user_id: jeff.id)
      review_2 = Review.create!(title: "Review 2", rating: 4, body: "This is the second review on this book", book_id: book_1.id, user_id: jp.id)

      expect(Review.array_of_reviewer_ids).to eq([jeff.id, jp.id])
    end

    describe "instance methods" do
      before :each do
        @book_1 = Book.create!(title: "Title 1", pages: 100, year_pub: 1901, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")

        @author_1 = @book_1.authors.create!(name: "Author 1", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")

        @user_1 = User.create!(name: "User One")

        @review_1 = @book_1.reviews.create!(title: "Review 1", rating: 1, body: "stuff 1", user: @user_1 )

      end

      it "finds reviewer name given a user_id" do

        within "#book-show-page-stats" do
          expect(page).to have_content(@review_1.reviewer_name(@user_1.id))
        end
        
      end
    end

  end

end
