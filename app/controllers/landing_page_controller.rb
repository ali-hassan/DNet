class LandingPageController < ApplicationController
  layout "layout", only: [:index]
  layout "pages", only: [:terms]

  def contact_us
    if params[:contact][:subject] && params[:contact][:body]
      UserMailer.contact_us(params[:contact]).deliver_now
      redirect_to '/', notice:  'We received your message and will get back to you ASAP'
    else
      redirect_to '/'
    end
  end
  def contact

  end
  def terms

  end
end
