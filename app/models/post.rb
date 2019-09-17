# frozen_string_literal: true

class Post < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :user
  validates :title, presence: true, length: { maximum: 155 }
  validates :body, presence: true, length: { in: 10..1000 }
end
