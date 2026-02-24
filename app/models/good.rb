class Good < ApplicationRecord
  belongs_to :good_type

  validates :nombre, presence: true
end
