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
    @direct_rf = current_user.adapter.all_users.paginate(page: params[:page], per_page: 10).order(created_at: :desc)
  end

  private
  def permitted_params
    params.require(:my_network).permit!
  end
end
