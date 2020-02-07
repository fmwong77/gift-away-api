class ReplySerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :user_id
  has_one :user
  has_one :comment
end
