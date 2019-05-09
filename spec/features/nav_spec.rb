require "rails_helper"

RSpec.describe "As a visitor, " do
  describe "I see a navigation bar" do
    it "links to Home and All books" do
      visit root_path

      expect(current_path).to eq(root_path)
      expect(page).to have_link("Home")
      expect(page).to have_link("All Books")

      click_link "All Books"
      expect(current_path).to eq(books_path)
    end

    it "navigates to Home and All Books when links are clicked" do
      visit books_path

      expect(page).to have_link("Home")
      expect(page).to have_link("All Books")

      click_link "Home"
      expect(current_path).to eq(root_path)
    end
  end
end
