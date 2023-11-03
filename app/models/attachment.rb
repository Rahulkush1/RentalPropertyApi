class Attachment < ApplicationRecord
	include ActiveStorageSupport::SupportForBase64
	belongs_to :property
	has_one_base64_attached :image, dependent: :destroy

	def self.ransackable_attributes(auth_object = nil)
    	["created_at", "id", "name", "property_id", "updated_at"]
  	end
end
