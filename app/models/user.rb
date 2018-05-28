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

  protected

  def self.authenticate_with_credentials(email, password)
    user = self.find_by_email(email)
    user && user.authenticate(password) || nil
  end
  
end
