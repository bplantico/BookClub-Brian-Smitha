class Book < ApplicationRecord

  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors
  has_many :reviews, dependent: :destroy

  validates_presence_of :title, :pages, :year_pub, :cover_img
  validates :pages, numericality: { greater_than: 0 }

  validates :title, uniqueness: true

  def average_rating
    reviews.average(:rating).to_f
  end

  def total_reviews
    reviews.count
  end

  def find_top_review
    self.reviews
        .select("reviews.*")
        .order("reviews.rating DESC")
        .first
  end

  def self.find_titles
    self.select(:title).pluck(:title)
  end

  def self.avg_rating(sort_order)
    self.joins(:reviews)
        .select("books.*, AVG(reviews.rating) AS avg_rating")
        .group(:id)
        .order("avg_rating #{sort_order}, books.title")
  end

  def self.sort_by_pages(sort_order)
    self.order("pages #{sort_order}")
  end

  def self.sort_by_reviews(sort_order)
    self.joins(:reviews)
        .select("books.*, COUNT(reviews.id) AS reviews_count")
        .group(:id)
        .order("reviews_count #{sort_order}, books.title")
  end

  def self.top_three_books
    self.joins(:reviews)
        .group(:id)
        .select("books.*, AVG(reviews.rating) AS avg_rating")
        .order("avg_rating DESC, books.title")
        .limit(3)
  end

  def self.bottom_three_books
    self.joins(:reviews)
        .group(:id)
        .select("books.*, AVG(reviews.rating) AS avg_rating")
        .order("avg_rating ASC, books.title")
        .limit(3)
  end
end
