class Amenity < ApplicationRecord
	has_and_belongs_to_many :properties, :join_table => :amenities_properties, dependent: :destroy
	def self.ransackable_attributes(auth_object = nil)
    	["created_at", "id", "title", "updated_at"]
  	end
end
