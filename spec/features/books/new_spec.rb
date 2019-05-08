require 'rails_helper'

RSpec.describe "As a visitor, " do
  describe "when I visit the books index page, " do
    it "I see a link to add a new book" do
      visit books_path

      expect(page).to have_link("Add New Book")
    end

    it "I am taken to a form to add new book after I click on Add New Book" do
      visit books_path

      click_link "Add New Book"
      expect(current_path).to eq(new_book_path)
    end
  end
end
