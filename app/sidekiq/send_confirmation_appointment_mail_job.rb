class SendConfirmationAppointmentMailJob
  include Sidekiq::Job

  def perform(appointment)
    AppointmentMailer.confirm_appointment_mail(appointment).deliver_now
  end
end