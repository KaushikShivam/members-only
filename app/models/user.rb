class User < ApplicationRecord
  before_save :email_downcase
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  
  validates :name, presence: true, length: { maximum: 150 }
  validates :email, presence: true, length: { maximum: 150 }, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  
  validates :password, presence: true, length: { in: 6..20 }
  
  has_secure_password
  
  private
  
  def email_downcase
    email.downcase!
  end
end
