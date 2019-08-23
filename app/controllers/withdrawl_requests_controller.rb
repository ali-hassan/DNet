class WithdrawlRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :update_gateway, only: [:create]
  skip_before_action :verify_authenticity_token
  layout "dashboard"
  before_action only: [:create] do
    @cash_wallet_message = Setting.find_by(key: "cash_wallet_message").value
    if @cash_wallet_message.present?
      redirect_to(withdrawl_requests_url(subdomain: 'office'), notice: @cash_wallet_message)
    # elsif (current_user.adapter.cash_wallet_total < permitted_params[:pts].try(:to_f))
    #   redirect_to(withdrawl_requests_url(subdomain: 'office'), notice: "You don't have enough money to make this request.")
    # else
    #   current_hongkong_time = Time.current.in_time_zone('Hong Kong')
    #   Time.zone = "Hong Kong"
    #   if (current_user.withdrawl_date.present? && current_user.withdrawl_date.to_date.to_s(:db) == Date.today.to_s(:db))
    #     redirect_to(withdrawl_requests_url(subdomain: 'office'), notice: 'Only one withdrawl allowed per day')
    #   else
    #     (current_hongkong_time.between?(Time.zone.parse("10:00am"), Time.zone.parse("7:00pm")) && current_hongkong_time.sunday?)  || redirect_to(withdrawl_requests_url(subdomain: 'office'), notice: 'Withdrawl is only allowed on Sunday from 10:00 AM to 7:00 PM time (GMT+8)')
    #   end
    # end
  end
  after_action only: [:create] do
    current_user.update bitcoin_url: permitted_params[:permitted_params]
  end
  def index
    @withdrawl_request = current_user.withdrawl_requests.build
    @is_cash_wallet = Setting.find_by(key: "is_cash_wallet_enable").try(:value)
    @wallets = ["ROI Wallet"]
    @is_cash_wallet == "true" && @wallets.push("Cash Wallet") || @wallets
  end
  def create
    (@withdrawl_request = current_user.withdrawl_requests.build(permitted_params)).save && redirect_to(withdrawl_requests_url(subdomain: 'office'), notice: 'successfully request submitted') || render(:index)
  end
  private
  def permitted_params
    params.require(:withdrawl_request).permit(:pts, :bitcoin_url, :cash_wallet, :amount, :service, :wallet_address, :wallet)
  end
  def update_gateway
    params[:withdrawl_request][:withdraw_gateway].present? && current_user.update(withdraw_gateway: params[:withdrawl_request][:withdraw_gateway])
  end
end
