class User < ApplicationRecord
  attr_accessor :remember_token
  before_save :email_downcase
  before_create :create_token
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  
  validates :name, presence: true, length: { maximum: 150 }
  validates :email, presence: true, length: { maximum: 150 }, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  
  validates :password, presence: true, length: { in: 6..20 }
  
  has_secure_password
  
  private

  def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def create_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token=User.create_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  def email_downcase
    email.downcase!
  end
end
