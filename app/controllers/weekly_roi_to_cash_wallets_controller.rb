class WeeklyRoiToCashWalletsController < ApplicationController
  before_action :authenticate_user!
  layout "dashboard"
  def index
    @transaction = current_user.user_transactions.build
  end
  def create
    (@transaction = current_user.user_transactions.build(permitted_params.merge(receiver_id: current_user.id))).save && redirect_to(weekly_roi_to_cash_wallets_url(subdomain: 'office'), notice: "Successfully transfered") || render(:index)
  end

  private
  def permitted_params
    params[:user_transaction].permit!
  end

end
