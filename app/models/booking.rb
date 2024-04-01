class Booking < ApplicationRecord
	belongs_to :user
	belongs_to :property
	has_one :payment, dependent: :destroy

	accepts_nested_attributes_for :payment
end
