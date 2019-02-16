class LandingPageController < ApplicationController

  def index

  end
  def contact_us
    if params[:contact][:name] && params[:contact][:body]
      UserMailer.contact_us(params[:contact][:name],params[:contact][:body]).deliver_now
      redirect_to '/'
    else
      redirect_to '/'
    end
  end
end
