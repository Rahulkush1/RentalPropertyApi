# class PropertySerializer < ActiveModel::Serializer
#   attributes :id, :name, :status, :publish, :price, :prop_type, :user_id
#   belongs_to :user
#   has_one :address
#   has_many :amenities

#   attribute :avatar do |object|
#     binding.pry
#     @object&.attachments.each do |obj|
#       Rails.application.routes.url_helpers.rails_blob_url(obj.image,only_path: true)
#     end
#   end
# end

class PropertySerializer 
  include FastJsonapi::ObjectSerializer

  set_key_transform :underscore
  attributes :id, :name, :status, :publish, :price, :prop_type, :user_id, :is_paid
  
  attribute :user_email do |object|
    object.user&.email
  end

  attribute :flat_detail do |object|
    object&.flat_detail
  end

  attribute :posted do |object|
    object&.user.roles.last.name
  end

  attribute :average_rating do |object|
    object&.average_rating
  end

  attribute :reviews do |object| 
    ReviewSerializer.new(object&.reviews)
  end

  attribute :avatar do |object|
    object&.attachments.map do |obj|
      Rails.application.routes.url_helpers.rails_blob_url(obj.image,only_path: true)
    end
  end

  attribute :address do |object|
    object&.address
  end

  attribute :amenities do |object|
    object&.amenities
  end

end
