class UserMailer < ApplicationMailer
  def contact_us(name,message)
    @email = 'abidiqbal4u@gmail.com'
    @name = name
    @message = message
    mail(to: @email, subject: 'Contact us email')
  end
end
