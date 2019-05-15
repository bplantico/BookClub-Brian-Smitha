class Review < ApplicationRecord

  belongs_to :book
  belongs_to :user

  validates_presence_of :title, :rating, :body

  validates :rating, numericality: { greater_than_or_equal_to: 1 }
  validates :rating, numericality: { less_than_or_equal_to: 5 }
  validates :rating, numericality: { only_integer: true }

  def self.array_of_reviewer_ids
    self.select(:user_id).pluck(:user_id)
  end

  def reviewer_name
    User.find(self.user_id).name
  end

end
