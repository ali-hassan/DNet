class SystemCredentialsController < ApplicationController
  before_action :authenticate_user!
  layout "dashboard"
  def create
    (@user = current_user).update_with_password(user_params) && redirect_to(system_credentials_url(subdomain: 'office')) || render(:index)
  end

  private
  def user_params
    params.require(:user).permit!
  end
end
