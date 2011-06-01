class ContactMailer < ActionMailer::Base

  def contact_message(user, message)
    @sender_email = message[:sender_email]
    @sender_name = message[:sender_name]
    @subject = message[:subject]
    @body = message[:body]
    mail(:to => "#{user.name} <#{user.email}>",
         :from => "#{@sender_name} <#{@sender_email}>",
         :subject => @subject,
         :body => @body)
  end

end

