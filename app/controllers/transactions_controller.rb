class TransactionsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  layout "dashboard"

  def index
    @transaction = current_user.user_transactions.build
  end
  def create
    (@transaction = current_user.user_transactions.build(permitted_params)).save && redirect_to(transactions_url(subdomain: 'office')) || render(:index)
  end

  private
  def permitted_params
    params.require(:user_transaction).permit!
  end
end
