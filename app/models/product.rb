class Product < ApplicationRecord
  acts_as_votable
  validates :name, presence: true
  validates :category, inclusion: {in: %w(fruits vegetables cereals dairy meat)}
  validates :season_start, presence: true
  validates :season_end, presence: true
  has_many :offerings, dependent: :destroy
  has_many :producers, through: :offerings

  def season_start_month
    Date::MONTHNAMES[season_start].slice(0, 3)
  end

  def season_end_month
    Date::MONTHNAMES[season_end].slice(0, 3)
  end
end
