class Post < ApplicationRecord
  belongs_to :producer

  validates :title, presence: true
  validates :producer_id, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
