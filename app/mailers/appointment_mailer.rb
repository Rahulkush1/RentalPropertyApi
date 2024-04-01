class AppointmentMailer < ActionMailer::Base
  def confirm_appointment_mail(appointment)
  	appointment = JSON.parse(appointment)
  	@user = User.find_by(id: appointment['user_id']) 
  	@appointment = Appointment.find_by(id: appointment['id'])
  	@property = Property.find_by(id: appointment['property_id'])
  	# @url = "http://localhost:3000/api/v1/users/registerations/email_confirm?token=#{user}"
    mail(to: @user.email, subject: "Confirmation: Property Visit Appointment Scheduled")
  end

  def appointment_mail(appointment)
  	appointment = JSON.parse(appointment)
  	@user = User.find_by(id: appointment['user_id']) 
  	@appointment = Appointment.find_by(id: appointment['id'])
  	@property = Property.find_by(id: appointment['property_id'])
  	# @url = "http://localhost:3000/api/v1/users/registerations/email_confirm?token=#{user}"
    mail(to: @user.email, subject: "Appointment: Property Visit Appointment Schedule ")
  end
end
