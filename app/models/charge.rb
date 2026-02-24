class Charge < ApplicationRecord
  belongs_to :quote
  belongs_to :member
end
