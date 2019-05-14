class User < ApplicationRecord
  has_many :reviews

  validates_presence_of :name
  validates :name, uniqueness: true

  def self.top_three_users
    # binding.pry
    self.joins(:reviews)
        .group(:id)
        .select("COUNT(reviews.id) as reviews_count, users.*")
        .order("reviews_count DESC, users.name ASC")
        .limit(3)
  end
end
