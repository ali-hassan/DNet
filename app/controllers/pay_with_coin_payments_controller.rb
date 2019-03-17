class PayWithCoinPaymentsController < ApplicationController
  before_action :authenticate_user!

  def show
    @pay_wcpp = PayWithCoinPayment.new(current_user, params[:id]).gen_url
    if @pay_wcpp.qrcode_url
      redirect_to @pay_wcpp.qrcode_url
    end
  end
end
