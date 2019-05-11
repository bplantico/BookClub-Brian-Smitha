# /spec/features/reviews/new_spec.rb

require 'rails_helper'

RSpec.describe "As a visitor, " do
  describe "when I visit a books show page, " do
    before :each do
      @book_1 = Book.create!(title: "Title 1", pages: 100, year_pub: 1901, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")
      @book_2 = Book.create!(title: "Title 2", pages: 200, year_pub: 1902, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")
      @user_1 = User.create!(name: "User One")
      @user_2 = User.create!(name: "User Two")
    end

    it "I see a link to add a new review" do
      visit book_path(@book_1)

      expect(page).to have_link("Add A Review")
    end

    it "I am taken to a form to add new book after I click on Add A Review" do
      visit book_path(@book_1)

      click_link "Add A Review"
      expect(current_path).to eq(new_review_path)

      fill_in :review_title, with: "reView oNe  "
      fill_in :review_rating, with: 5
      fill_in :review_body, with: "This is by far the absolute best Book I have ever read."

      click_button "Create Review"

      new_review = Review.last

      expect(current_path).to eq(book_path)
      expect(page).to have_content(new_book.title)
      expect(page).to have_content("Title One")

      expect(page).to have_content(new_review.title)
      expect(page).to have_content(new_review.rating)
      expect(page).to have_content(new_review.body)

    end
  end
end
