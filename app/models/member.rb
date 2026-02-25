class Member < ApplicationRecord
  has_secure_password
  has_many :charges

  ROLES = %w[presidente vicepresidente secretario tesorero vocal].freeze

  scope :active, -> { where(churn_date: nil) }

  validates :email, presence: true, uniqueness: true
  validates :user_name, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :surnames, presence: true
  validates :role, inclusion: { in: ROLES }, allow_nil: true, allow_blank: true


  def has_role?
    role.present?
  end

  def president_or_treasurer?
    role == "presidente" || role == "tesorero"
  end

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
