class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def invite_user(invitee, invitedBy, site)
    @invitee = invitee
    @invitedBy = invitedBy
    @site = site

    mail to: invitee.email, subject: "#{@site.company.name} has created a website for your community on Condo Motion"
  end

	def invite_manager(invitee, invitedBy)
    @invitee = invitee
    @invitedBy = invitedBy

    mail to: invitee.email, subject: "#{@invitedBy} has created a manager account for you on Condo Motion"
  end

end
