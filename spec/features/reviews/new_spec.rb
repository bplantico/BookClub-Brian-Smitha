# /spec/features/reviews/new_spec.rb

require 'rails_helper'

RSpec.describe "As a visitor, " do
  describe "when I visit a books show page, " do

    it "I see a link to add a new review" do
      book_1 = Book.create!(title: "Title 1", pages: 100, year_pub: 1901, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")
      visit book_path(book_1)

      expect(page).to have_link("Add A Review")
    end

    it "I am taken to a form to add new review after I click on Add A Review" do
      book_1 = Book.create!(title: "Title 1", pages: 100, year_pub: 1901, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")
      brian = User.create!(name: "Brian Plantico")

      visit book_path(book_1)

      click_link "Add A Review"

      expect(current_path).to eq(new_book_review_path(book_1))

      fill_in :review_title, with: "reView oNe  "
      fill_in :review_user, with: "brian plantico"
      fill_in :review_rating, with: 5
      fill_in :review_body, with: "This is by far the absolute best Book I have ever read."

      click_button "Create Review"

      new_review = Review.last

      expect(current_path).to eq(book_path(book_1))
      expect(page).to have_content(new_review.title)
      expect(page).to have_content("Title 1")

      expect(page).to have_content(new_review.rating)
      expect(page).to have_content(new_review.body)

    end

    it "I cannot add a review if user already reviewed" do
      book_1 = Book.create!(title: "Title 1", pages: 100, year_pub: 1901, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")
      brian = User.create!(name: "Brian Plantico")

      review_1 = Review.create!(title: "Review 1", rating: 4, body: "This is the first review on this book", book_id: book_1.id, user_id: brian.id)

      visit book_path(book_1)

      click_link "Add A Review"

      expect(current_path).to eq(new_book_review_path(book_1))

      fill_in :review_title, with: "reView TWo "
      fill_in :review_user, with: "Brian Plantico"
      fill_in :review_rating, with: 5
      fill_in :review_body, with: "This would be my second review of this book."

      click_button "Create Review"

      expect(current_path).to eq(new_book_review_path(book_1))

    end

  end
end
