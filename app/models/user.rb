class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :address, presence: true
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true
  has_many :favourite_producers
  has_many :favourite_products
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  acts_as_voter
end
