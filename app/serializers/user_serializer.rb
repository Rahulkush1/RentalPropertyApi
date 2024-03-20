# class UserSerializer < ActiveModel::Serializer
#   attributes :id,:email
#   has_many :roles
#   has_one :address
# end

class UserSerializer 
  include FastJsonapi::ObjectSerializer

  set_key_transform :underscore
  attributes :id, :email
  
  attribute :full_name do |object|
    object&.full_name
  end

  # attribute :avatar do |object|
  #   object&.attachments.map do |obj|
  #     Rails.application.routes.url_helpers.rails_blob_url(obj.image,only_path: true)
  #   end
  # end
  attributes :roles do |object|
    object&.roles
  end

  attribute :address do |object|
    object&.address
  end


end