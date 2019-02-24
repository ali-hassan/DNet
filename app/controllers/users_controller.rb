class UsersController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  layout "dashboard"

  def me

  end

  def system_password

  end

  def update
    current_user.update(whitelist_user_params) && redirect_to(me_users_url(subdomain: 'office')) || render(:me)
  end

  def show
  end

  def kyc

  end

  private
  def whitelist_user_params
    params.require(:user).permit!
  end
end
