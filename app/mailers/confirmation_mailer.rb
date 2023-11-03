class ConfirmationMailer < ActionMailer::Base
  default from: "rahulkushwaha191121@gmail.com"

  def confirm_mail(user)
  	@decode_user = JsonWebTokenService.decode(user)
  	@url = "http://localhost:3000/api/v1/users/registerations/email_confirm?token=#{user}"
    mail(to: @decode_user["email"], subject: "Confirm your account ")
  end
end
