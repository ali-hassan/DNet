class TransactionsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  layout "dashboard"
  before_action :build_transaction, only: [:index, :cash_to_smart]

  def index

  end
  def create
    if params[:cash_wallet]
      !(@transaction = current_user.user_transactions.create(permitted_params.merge(receiver_id: current_user.id))).errors.any? && redirect_to(cash_to_smart_transactions_url(subdomain: 'office'), notice: "Successfully transfered") || render(:cash_to_smart)
    else
      (@transaction = current_user.user_transactions.build(permitted_params)).save && redirect_to(transactions_url(subdomain: 'office')) || render(:index)
    end
  end

  def cash_to_smart

  end

  private
  def permitted_params
    params.require(:user_transaction).permit!
  end

  def build_transaction
    @transaction = current_user.user_transactions.build
  end
end
