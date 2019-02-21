class UserMailer < ApplicationMailer
  def contact_us(params)
    @sender = 'support@forexhometrade.com'

    @name     = params[:name]
    @message  = params[:body]
    @phone    = params[:phone]
    @subject  = params[:subject]
    @email    = params[:email]
    mail(to: @sender, subject: "Contact us email | #{@subject} | #{@name}")
  end
end