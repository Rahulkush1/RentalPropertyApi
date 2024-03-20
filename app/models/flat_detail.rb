class FlatDetail < ApplicationRecord
	belongs_to :property

	enum flat_type: {
		ONE_BHK: 0,
		TWO_BHK: 1,
		THREE_BHK: 2
	}

	def self.ransackable_attributes(auth_object = nil)
    		["area", "available_for", "created_at", "flat_type", "id", "property_id", "updated_at"]
  	end
end
