class SendEmailJob
  include Sidekiq::Job

  def perform(email)
    account_sid = ENV['ACCOUNT_SID']
    auth_token = ENV['AUTH_TOKEN']
    service_sid = ENV['SERVICE_SID']

    client = Twilio::REST::Client.new(account_sid, auth_token)
    verification_service = client.verify.v2.services(service_sid)
    verification_service
      .verifications
      .create(to: phone_number_with_code, channel: 'sms')

  end
end