class UserMailer < ApplicationMailer
  def contact_us(params)
    @sender = 'support@DNet.com'

    @name     = params[:name]
    @message  = params[:body]
    @phone    = params[:phone]
    @subject  = params[:subject]
    @email    = params[:email]
    mail(to: @sender, subject: "Contact us email | #{@subject} | #{@name}")
  end
  def support(spprt)
    @sender = 'support@DNet.com'
    @spprt = spprt
    mail(to: @sender, subject: "Support | #{@spprt.user.email} | #{@spprt.username} | #{@spprt.subject} | #{@spprt.type}")
  end
  def welcome(user)
    @user = user
    mail(to: user.email, subject: "Welcome to DNet")
  end
  def buy_package(user)
    @user = user
    @package_name = FindPackages.new(user.package_id).current_package["category"]
    mail(to: user.email, subject: "Welcome to DNet")
  end
  def upgrade_package(user)
    @user = user
    @package_name = FindPackages.new(user.package_id).current_package["category"]
    mail(to: user.email, subject: "Welcome to DNet")
  end
end
