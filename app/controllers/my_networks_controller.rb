class MyNetworksController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  layout "dashboard"

  def show
    @children = User.where(parent_id: params[:id])
  end
  def new
    @user = AddNewNetwork.new(current_user, permitted_params)
  end
  def create
    @user = AddNewNetwork.new(current_user, permitted_params)
  end

  def my_binary

  end

  def direct_referrals

  end

  private
  def permitted_params
    params.require(:my_network).permit!
  end
end
