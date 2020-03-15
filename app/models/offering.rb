class Offering < ApplicationRecord
  belongs_to :product
  belongs_to :producer
  validates :product_id, presence: true
  validates :producer_id, presence: true
end
