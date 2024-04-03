class Property < ApplicationRecord
  	resourcify
	belongs_to :user
	has_one :flat_detail, dependent: :destroy
	has_one :address, as: :addressable,dependent: :destroy
	has_one :booking, dependent: :destroy
	has_and_belongs_to_many :amenities, :join_table => :amenities_properties, dependent: :destroy
	has_many :attachments, dependent: :destroy
	has_many :appointments, dependent: :destroy
	has_many :reviews, as: :reviewable  , dependent: :destroy
	has_many :reviewers, through: :reviews, source: :user
	accepts_nested_attributes_for :flat_detail, allow_destroy: true
	accepts_nested_attributes_for :amenities, allow_destroy: true
	accepts_nested_attributes_for :address, allow_destroy: true
	accepts_nested_attributes_for :attachments, allow_destroy: true

	

	enum publish: {
	    NO: 0,
	    YES: 1,
  	}

	enum status: {
	    available: 0,
	    sold: 1,
	    pending: 2 
  	}

  	enum prop_type: {
	    FLAT: 0,
	    PG: 1,
	    ROOM: 2
  	}

  	def average_rating
  		self.reviews.average('reviews.rating')
  	end

  	def self.ransackable_attributes(auth_object = nil)
    	["created_at", "id", "is_paid", "name", "price", "prop_type", "publish", "status", "updated_at", "user_id"]
  	end
  	def self.ransackable_associations(auth_object = nil)
    	["address", "amenities", "attachments", "flat_detail", "user"]
  	end
end
