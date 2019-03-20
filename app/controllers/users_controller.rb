class UsersController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  layout "dashboard"

  def me

  end

  def system_password

  end

  def update
    if params[:user][:current_financial_pin].present?
      verify_pin && (current_user.update(whitelist_user_params.except(:current_financial_pin).merge({current_financial_pin: params[:user][:current_financial_pin]})) && dashboard_index_url(subdomain: 'office'))
    else
      current_user.update(whitelist_user_params) && redirect_to(me_users_url(subdomain: 'office')) || render(:me)
    end
  end

  def show
    redirect_to dashboard_index_url(subdomain: 'office')
  end

  def kyc
  end

  def financial_pin
  end

  def support

  end

  private
  def whitelist_user_params
    params.require(:user).permit!
  end

  def verify_pin
    params[:user][:current_financial_pin] == current_user.financial_pin
  end
end
