require 'rails_helper'

RSpec.describe "as a visitor, " do
  describe "when I visit a book show page" do
    before :each do
      @book_1 = Book.create!(title: "Book 1", pages: 100, year_pub: 1901, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")
      @book_2 = Book.create!(title: "Book 2", pages: 200, year_pub: 1902, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")
      @book_3 = Book.create!(title: "Book 3", pages: 300, year_pub: 1903, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")

      @author_1 = @book_1.authors.create!(name: "Author of Book 1", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")
      @author_2 = @book_2.authors.create!(name: "Author of Book 2", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")
      @author_3 = @book_3.authors.create!(name: "Author of Book 3", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")

      User.destroy_all

    end

    it "all the reviewer names are links to that user's show page" do
      user_1 = User.create!(name: "User One")

      review_1 = @book_1.reviews.create!(title: "Review of Book 1", rating: 1, body: "stuff about book 1", user: user_1 )
      review_2 = @book_2.reviews.create!(title: "Review of Book 2", rating: 2, body: "stuff about book 2", user: user_1 )
      review_3 = @book_3.reviews.create!(title: "Review of Book 3", rating: 3, body: "stuff about book 3", user: user_1 )

      visit book_path(@book_1)

      expect(page).to have_link("User One")

    end

    it "clicking a reviewer's name takes me to that user's show page" do

      user_1 = User.create!(name: "User One")

      review_1 = @book_1.reviews.create!(title: "Review of Book 1", rating: 1, body: "stuff about book 1", user: user_1 )
      review_2 = @book_2.reviews.create!(title: "Review of Book 2", rating: 2, body: "stuff about book 2", user: user_1 )
      review_3 = @book_3.reviews.create!(title: "Review of Book 3", rating: 3, body: "stuff about book 3", user: user_1 )

      visit book_path(@book_1)

      click_link "User One"

      expect(current_path).to eq(user_path(user_1))

    end
  end

  describe "when I visit a user show page" do
    before :each do
      @book_1 = Book.create!(title: "Book 1", pages: 100, year_pub: 1901, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")
      @book_2 = Book.create!(title: "Book 2", pages: 200, year_pub: 1902, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")
      @book_3 = Book.create!(title: "Book 3", pages: 300, year_pub: 1903, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")

      @author_1 = @book_1.authors.create!(name: "Author of Book 1", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")
      @author_2 = @book_2.authors.create!(name: "Author of Book 2", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")
      @author_3 = @book_3.authors.create!(name: "Author of Book 3", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")

      User.destroy_all
    end

    it "the reviewer's show page has their reviews with details" do
      user_1 = User.create!(name: "User One")

      review_1 = @book_1.reviews.create!(title: "Review of Book 1", rating: 1, body: "stuff about book 1", user: user_1 )
      review_2 = @book_2.reviews.create!(title: "Review of Book 2", rating: 2, body: "stuff about book 2", user: user_1 )
      review_3 = @book_3.reviews.create!(title: "Review of Book 3", rating: 3, body: "stuff about book 3", user: user_1 )

      visit user_path(user_1)

      expect(page).to have_content(review_1.title)
      expect(page).to have_content(review_2.title)
      expect(page).to have_content(review_3.title)

      expect(page).to have_content(review_1.body)
      expect(page).to have_content(review_2.body)
      expect(page).to have_content(review_3.body)

      expect(page).to have_content(@book_1.title)
      expect(page).to have_content(@book_2.title)
      expect(page).to have_content(@book_3.title)

    end

    it "I see a link to delete a review" do
      visit user_path(user)
      expect(current_path).to eq(author_path(@author_4.id))

      expect(page).to have_link("Delete Author")
    end

  end

end
