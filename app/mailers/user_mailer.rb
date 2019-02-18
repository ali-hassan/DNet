class UserMailer < ApplicationMailer
  def contact_us(params)
    @email = 'support@forexhometrade.com'

    @name     = params[:name]
    @message  = params[:body]
    @phone    = params[:phone]
    @subject  = params[:subject]
    @email    = params[:email]
    mail(to: @email, subject: "Contact us email | #{@subject} | #{@name}")
  end
end
