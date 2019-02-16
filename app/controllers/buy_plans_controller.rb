class BuyPlansController < ApplicationController
  before_action :authenticate_user!
  layout "dashboard"
  def show
    @package = FindPackages.new(params[:id])
  end
end
