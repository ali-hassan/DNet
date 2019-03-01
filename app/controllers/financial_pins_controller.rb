class FinancialPinsController < ApplicationController
  layout "dashboard"
  def new
    @user = current_user
  end
  def create
    (@user = current_user).update(permitted_params) && redirect_to(financial_pins_url(subdomain: 'office')) || render(:new)
  end
  private
  def permitted_params
    params.require(:user).permit(:current_pin, :pin)
  end
end
