class BuyPlansController < ApplicationController
  before_action :authenticate_user!
  layout "dashboard"
  before_action :find_package, only: [:show]
  skip_before_action :verify_authenticity_token

  def create
    ChargeAmountAtA.new(current_user, params[:plan_id]).charge!
    redirect_to(dashboard_index_url(subdomain: 'office'), notice: 'Successfully scribed')
  end
  def edit
    @package = FindPackages.new(params[:id])
  end
  private
  def find_package
    @package = FindPackages.new(params[:id])
  end
end
