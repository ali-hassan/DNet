class SupportsController < ApplicationController
  layout 'dashboard'
  
  def index
    @support = Support.new(current_user)
  end
  def create
    (@support = Support.new(current_user, permitted_params)).commit! && redirect_to(supports_url(subdomain: 'office'), notice: "Ticket successfully submitted") || render(:index)
  end
  private
  def permitted_params
    params.require(:support).permit!
  end
end
