class WithdrawlRequestsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  layout "dashboard"

  def index
    @withdrawl_request = current_user.withdrawl_requests.build
  end
  def create
    (@withdrawl_request = current_user.withdrawl_requests.build(permitted_params)).save && redirect_to(withdrawl_requests_url(subdomain: 'office'), notice: 'successfully request submitted') || render(:index)
  end
  private
  def permitted_params
    params.require(:withdrawl_request).permit(:pts, :bitcoin_url)
  end
end
