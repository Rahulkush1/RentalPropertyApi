class PropertySerializer < ActiveModel::Serializer
  attributes :id, :name, :status, :publish, :price, :prop_type, :user_id
  belongs_to :user
  has_one :address
  has_many :amenities
end

# class PropertySerializer 
#   include FastJsonapi::ObjectSerializer

#   set_key_transform :underscore
#   attributes :id, :name, :status, :publish, :price, :prop_type, :user_id
  
#   attribute :user_email do |object|
#     object.user&.email
#   end



#   belongs_to :user
#   has_one :address
#   has_many :amenities
# end

