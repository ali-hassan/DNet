class CurrentWeeklyRoiToCashTransfersController < ApplicationController
  layout "dashboard"
  before_action :authenticate_user!, only: [:new, :create]
  def new
    @transaction = current_user.user_transactions.build
  end
  def create
    (@transaction = current_user.user_transactions.build(permitted_params.merge(receiver_id: current_user.id))).save && redirect_to(new_current_weekly_roi_to_cash_transfer_url(subdomain: 'office'), notice: "Successfully transfered") || render(:new, notice: "Successfully transfered")
  end

  private
  def permitted_params
    params[:user_transaction].permit!
  end
end
