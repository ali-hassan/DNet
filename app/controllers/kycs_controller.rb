class KycsController < ApplicationController
  before_action :authenticate_user!
  layout 'dashboard'
  def edit
    @kyc = current_user
  end
  def update
    (@kyc=current_user).update(permitted_params) && redirect_to(edit_kyc_url(subdomain: 'office'), notice: 'Successfully submitted') || render(:edit)
  end
  private
  def permitted_params
    params.require(:user).permit!
  end
end
