class PostSerializer < ActiveModel::Serializer
  
  has_one :user
  has_one :category

  include Rails.application.routes.url_helpers
  attributes :id, :title, :description, :user_id, :category_id, :image, :latitude, :longitude

  def image
    return unless object.image.attached?
    object.image.blob.attributes
          .slice('filename', 'byte_size')
          .merge(url: image_url)
          .tap { |attrs| attrs['name'] = attrs.delete('filename') }
  end

  def image_url
    url_for(object.image)
  end
end
