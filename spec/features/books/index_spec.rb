require 'rails_helper'

RSpec.describe "As a visitor " do
  describe "When I visit books index page, " do
    it "I see all the books and their attributes" do
    visit '/books'

    #book_1 will have two authors
    #need to test for multiple authors (unordered)
    #test data, after model test is set up.
      within "#test-book-index-#{book_1.id}" do
        expect(page).to have_content(book_1.title)
        expect(page).to have_content(book_1.author)
        expect(page).to have_content(book_1.pages)
        expect(page).to have_content(book_1.year_pub)
        expect(page).to have_css("img src='book_1.cover_img'")

        expect(page).to_not have_content(book_2.title)
      end

      within "#test-book-index-#{book_2.id}" do
        expect(page).to have_content(book_2.title)
        expect(page).to have_content(book_2.author)
        expect(page).to have_content(book_2.pages)
        expect(page).to have_content(book_2.year_pub)
        expect(page).to have_css("img src='book_2.cover_img'")
      end

      within "#test-book-index-#{book_3.id}" do
        expect(page).to have_content(book_3.title)
        expect(page).to have_content(book_3.author)
        expect(page).to have_content(book_3.pages)
        expect(page).to have_content(book_3.year_pub)
        expect(page).to have_css("img src='book_3.cover_img'")
      end
    end
  end
end
