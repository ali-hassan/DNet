class BuyPlansController < ApplicationController
  before_action :authenticate_user!
  layout "dashboard"
  before_action :shift_to_pkg, only: [:create], if: -> { current_user.is_pin }
  before_action :find_package, only: [:show]
  skip_before_action :verify_authenticity_token

  def create
    ChargeAmountAtA.new(current_user, params[:plan_id], upgrade_plan).charge!
    redirect_to(dashboard_index_url(subdomain: 'office'), notice: 'Package Successfully Activated')
  end
  def edit
    @package = ChargeAmountAtA.new(current_user, params[:id], upgrade_plan)
  end
  private
  def find_package
    @package = FindPackages.new(params[:id])
  end
  def upgrade_plan
    false
  end
  def shift_to_pkg
    current_user.update is_pin: false, binary_bonus: 0.0, total_income: 0.0#, pin_capacity: nil
  end
end
