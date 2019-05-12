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
    book_1 = Book.create!(title: "Title 1", pages: 100, year_pub: 1901, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")

    jeff = User.create!(name: "Jeff")
    jp = User.create!(name: "JP")

    review_1 = Review.create!(title: "Review 1", rating: 4, body: "This is the first review on this book", book_id: book_1.id, user_id: jeff.id)
    review_2 = Review.create!(title: "Review 2", rating: 4, body: "This is the second review on this book", book_id: book_1.id, user_id: jp.id)

    it "should return array of all reviewer ids" do
      expect(Review.array_of_reviewer_ids).to eq([brian.id, bp.id])
    end

  end

end
