class Appointment < ApplicationRecord
	belongs_to :user
	belongs_to :property
	after_create :send_appointment_mail
	
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

	def send_appointment_mail
		SendAppointmentEmailJob.perform_async(self.to_json)
	end
end
