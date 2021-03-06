# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :remember_token
  before_save :email_downcase
  before_create :remember

  has_many :posts

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  validates :name, presence: true, length: { maximum: 150 }
  validates :email, presence: true, length: { maximum: 150 },
                    uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }

  validates :password, presence: true, length: { in: 6..20 }

  has_secure_password

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.create_token
    SecureRandom.urlsafe_base64
  end

  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  private

  def email_downcase
    email.downcase!
  end

  def remember
    self.remember_token = User.create_token
    self.remember_digest = User.digest(remember_token)
  end
end
