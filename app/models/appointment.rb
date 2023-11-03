class Appointment < ApplicationRecord
	belongs_to :user
	belongs_to :property
	
	enum status: {
		pending: 0,
		approved: 1,
		rejected: 2
	}
	enum visit_status: {
		visit_pending: 0,
		visit_approved: 1,
		visit_rejected: 2
	}
end
