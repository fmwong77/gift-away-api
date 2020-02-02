class ReplySerializer < ActiveModel::Serializer
  attributes :id, :content
  has_one :user
  has_one :comment
end
