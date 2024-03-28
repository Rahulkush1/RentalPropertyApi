class SendAppointmentEmailJob
  include Sidekiq::Job

  def perform(appointment)
    AppointmentMailer.appointment_mail(appointment).deliver_now
  end
end