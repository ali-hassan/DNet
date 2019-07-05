class BuyPlansController < ApplicationController
  before_action :authenticate_user!
  layout "dashboard"
  before_action :shift_to_pkg, only: [:create], if: -> { current_user.is_pin }
  before_action :rebuy_package, only: [:create], if: -> { current_user.package_id.present? && params["controller"] != "upgrade_plans"}
  before_action :upgrade_package, only: [:create], if: -> { params["controller"] == "upgrade_plans"}
  before_action :find_package, only: [:show]
  skip_before_action :verify_authenticity_token

  def create
    ChargeAmountAtA.new(current_user, params[:plan_id], upgrade_plan).charge!
    if Rails.env == "production"
      params["controller"] == "upgrade_plans" ? UserMailer.upgrade_package(current_user).deliver_now : UserMailer.buy_package(current_user).deliver_now
    end
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
    binary_bonus_minus = current_user.minus_x_factor_binary.to_f + current_user.binary_bonus_for_xfactor.to_f
    current_user.update is_pin: false, is_package_converted: true, minus_x_factor_binary: binary_bonus_minus, binary_bonus: 0.0, binary_bonus_for_xfactor: 0.0,  current_x_factor_income: 0  #, pin_capacity: nil
  end
  def rebuy_package
    binary_bonus_minus = current_user.minus_x_factor_binary.to_f + current_user.binary_bonus_for_xfactor.to_f
    current_user.update re_buy: true, current_x_factor_income: binary_bonus_minus, minus_x_factor_binary: binary_bonus_minus
  end
  def upgrade_package
    current_user.update is_package_updated: true
  end
end
