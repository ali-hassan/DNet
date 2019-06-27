class PayWithBitcoinsController < ApplicationController
  before_action :authenticate_user!
  def show
    redirect_to PayWithBitcoin.new(current_user, params[:id]).gen_url
  end
end
