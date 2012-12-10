class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def invite_user(invitee, invitedBy, site)
    @invitee = invitee
    @invitedBy = invitedBy
    @site = site

    mail to: invitee.email, subject: "You've been invited to Condo Motion"
  end

end
