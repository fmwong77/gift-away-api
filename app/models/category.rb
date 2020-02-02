class Category < ApplicationRecord
  # include ActiveModel::Serialization 
    has_many :posts
  has_many :users, through: :posts
end
