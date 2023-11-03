class Address < ApplicationRecord
	belongs_to :addressable, polymorphic: true
	def self.ransackable_attributes(auth_object = nil)
    	["address_line", "addressable_id", "addressable_type", "city", "country", "created_at", "id", "state", "street", "updated_at"]
  	end
end
