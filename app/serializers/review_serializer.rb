
class ReviewSerializer 
  include FastJsonapi::ObjectSerializer

  set_key_transform :underscore
  attributes :id, :rating, :review
  
  attribute :user do |object|
  	object&.user.full_name
  end

  attribute :property do |object| 
  	object&.reviewable
  end

end