class Author < ApplicationRecord
  has_many :book_authors, dependent: :destroy
  has_many :books, through: :book_authors

  validates_presence_of :name, :author_img

  def find_top_review
    binding.pry
    
  end
end
