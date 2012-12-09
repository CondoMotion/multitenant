class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def invite_user(invitee, invitedBy)
    @invitee = invitee
    @invitedBy = invitedBy

    mail to: invitee.email, subject: "You've been invited to Condo Motion"
  end

end
