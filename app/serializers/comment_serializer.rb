class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :user_id, :created_at
  has_one :user
  has_one :post
  has_many :replies
end
