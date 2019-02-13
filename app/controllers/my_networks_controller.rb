class MyNetworksController < ApplicationController
  
  def index

  end
  def new
    @my_network = User.new
  end
  def create
    @add_new_network = AddNewNetwork.new(current_user, permitted_params)
  end
  private
  def permitted_params
    params.require(:user).permit(:parent_position)
  end
end
