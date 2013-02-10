class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def invite_user(invitee, invitedBy, site)
    @invitee = invitee
    @invitedBy = invitedBy
    @site = site
    attachments.inline['logo.png'] = File.read("#{Rails.root}/app/assets/images/logo.png")

    mail to: invitee.email, subject: "You've been invited to Condo Motion"
  end

	def invite_manager(invitee, invitedBy)
    @invitee = invitee
    @invitedBy = invitedBy
    attachments.inline['logo.png'] = File.read("#{Rails.root}/app/assets/images/logo.png")

    mail to: invitee.email, subject: "You've been invited to Condo Motion"
  end

end
