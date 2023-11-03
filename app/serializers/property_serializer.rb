class PropertySerializer < ActiveModel::Serializer
  attributes :id, :name, :status, :publish, :price, :prop_type, :user_id
  belongs_to :user
  has_one :address
  has_many :amenities
  
end
