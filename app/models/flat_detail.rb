class FlatDetail < ApplicationRecord
	belongs_to :property

	def self.ransackable_attributes(auth_object = nil)
    		["area", "available_for", "created_at", "flat_type", "id", "property_id", "updated_at"]
  	end
end
