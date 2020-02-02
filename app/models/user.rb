class User < ApplicationRecord
  has_many :posts
  has_many :categories, through: :posts
  has_secure_password
  validates :username, uniqueness: { case_sensitive: false }
end
