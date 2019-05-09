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

      fill_in :book_title, with: "tiTle oNe  "
      fill_in :book_pages, with: 304
      fill_in :book_year_pub, with: 1901
      fill_in :book_cover_img, with: " "
      fill_in :book_authors, with: "AuThor 1,    author 2"

      click_button "Add Book"

      new_book = Book.last

      expect(current_path).to eq(book_path(new_book))
      expect(page).to have_content(new_book.title)
      expect(page).to have_content("Title One")

      expect(page).to have_content(new_book.pages)
      expect(page).to have_content(new_book.year_pub)
      expect(page).to have_css("img[src='#{new_book.cover_img}']")
      expect(page).to have_content("Author 1")
      expect(page).to have_content("Author 2")
    end

    it "I cannot add an existing title or a negative number for pages" do
      book_1 = Book.create!(title: "Title 1", pages: 100, year_pub: 1901, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")

      visit books_path

      click_link "Add New Book"
      expect(current_path).to eq(new_book_path)

      fill_in :book_title, with: " tiTle oNe "
      fill_in :book_pages, with: -304
      fill_in :book_year_pub, with: 1901
      fill_in :book_cover_img, with: " "
      fill_in :book_authors, with: "Author 1, Author 2"

      click_button "Add Book"
      expect(current_path).to eq(new_book_path)
    end
  end
end
