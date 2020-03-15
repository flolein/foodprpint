class Producer < ApplicationRecord
  # has_one_attached :photo
  acts_as_votable
  validates :company_name, presence: true
  validates :owner_name, presence: true
  validates :address, presence: true
  has_many :offerings, dependent: :destroy
  has_many :products, through: :offerings
  has_many :posts, dependent: :destroy
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
