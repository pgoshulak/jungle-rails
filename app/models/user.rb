class User < ActiveRecord::Base

  has_many :reviews
  
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, 
    presence: true,
    length: { within: 6..40 }
  validates :password_confirmation, presence: true

end
