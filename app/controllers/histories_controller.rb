class HistoriesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  layout "dashboard"

  def index
  end

  def show
    @transactions = LoadHistory.new(current_user, params[:id])
  end
end
