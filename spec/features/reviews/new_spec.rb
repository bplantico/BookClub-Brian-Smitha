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
  end
end
