class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates :rating, presence: true
  scope :find_comments, ->(comment){where "product_id = ?", comment.product_id}
  scope :order_comments, ->{order created_at: :desc}
end
