class PostMailer < ActionMailer::Base
  default from: "from@example.com"

  def new_post(post, attachment_url)
    @post = post
    @attachment_url = attachment_url
    attachments.inline['logo.png'] = File.read("#{Rails.root}/app/assets/images/logo.png")


    mail(:to => @post.page.site.members.where(:receive_post_mails => true).map(&:email),
         :subject => "New #{@post.post_type.singularize.titleize} Post!")
  end
end
