class WithdrawlRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :update_gateway, only: [:index]
  skip_before_action :verify_authenticity_token
  layout "dashboard"
  before_action only: [:create] do
    current_hongkong_time = Time.current.in_time_zone('Hong Kong')
    (current_hongkong_time.between?(Time.parse("10:00am"), Time.parse("7:00pm")) && current_hongkong_time.saturday? && (current_user.withdrawl_date.blank? || current_user.withdrawl_date.in_time_zone('Hong Kong').to_date.to_s(:db) != current_hongkong_time.to_date.to_s(:db))) || redirect_to(withdrawl_requests_url(subdomain: 'office'), notice: 'Withdrawl only allowed from saturday 10 am to 7 pm Hongkong time')
  end
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
  def update_gateway
    current_user.update(withdraw_gateway: params[:withdraw_gateway])
  end
end
