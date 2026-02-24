class Member < ApplicationRecord
  has_secure_password
  has_many :charges

  scope :active, -> { where(churn_date: nil) }

  validates :email, presence: true, uniqueness: true
  validates :user_name, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :surnames, presence: true


  def full_name
    "#{first_name} #{surnames}"
  end

  def status 

    # if charges.where(charge_date: nil).any? 
    #   return "Pendiente"
    # end

    'Al corriente'
  end
end
