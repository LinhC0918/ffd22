class Order < ApplicationRecord
  enum status: {pending: 0, approved: 1, cancelled: 2}
  belongs_to :user
  has_many :order_products, dependent: :destroy
  scope :order_day_desc, ->{order created_at: :desc}
end
