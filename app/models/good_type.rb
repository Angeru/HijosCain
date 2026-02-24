class GoodType < ApplicationRecord
  has_many :goods

  validates :name, presence: true
end
