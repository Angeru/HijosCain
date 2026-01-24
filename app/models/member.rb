class Member < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :user_name, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :surnames, presence: true
end
