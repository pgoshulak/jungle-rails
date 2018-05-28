class User < ActiveRecord::Base

  has_many :reviews
  
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, 
    presence: true, 
    uniqueness: { case_sensitive: false }
  validates :password, 
    presence: true,
    length: { within: 6..40 }
  validates :password_confirmation, presence: true

  before_save :downcase_email

  protected

  def self.authenticate_with_credentials(email, password)
    user = self.find_by_email(email.downcase.strip)
    user && user.authenticate(password) || nil
  end

  private

  def downcase_email
    self.email.downcase!
  end
  
end
