class Book < ApplicationRecord

  has_many :book_authors
  has_many :authors, through: :book_authors
  has_many :reviews

  validates_presence_of :title, :pages, :year_pub, :cover_img

  def average_rating

    reviews.average(:rating)

    # self.joins(:reviews).group(:id).average('reviews.rating') ## Keeping this for sorting later
  end

  def total_reviews
    reviews.count
  end

end
