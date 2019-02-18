class LandingPageController < ApplicationController

  def index

  end

  def contact_us
    if params[:contact][:subject] && params[:contact][:body]
      UserMailer.contact_us(params[:contact]).deliver_now
      redirect_to '/'
    else
      redirect_to '/'
    end
  end
  def contact

  end
end
