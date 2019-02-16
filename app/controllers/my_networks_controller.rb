class MyNetworksController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  layout "dashboard"

  def index

  end
  def show
    @children = User.where(parent_id: params[:id])
  end
  def new
    @my_network = User.new
  end
  def create
    @add_new_network = AddNewNetwork.new(current_user, permitted_params)
  end
  private
  def permitted_params
    params.require(:user).permit(:parent_position, :parent_id)
  end
end
