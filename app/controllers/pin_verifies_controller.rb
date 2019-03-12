class PinVerifiesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def show
    @pin_verify = PinVerify.new(current_user)
  end
  def create
    (@pin_verify = PinVerify.new(current_user, permitted_params)).valid? || render(:show)
  end
  private
  def permitted_params
    params.require(:pin_verify).permit!
  end
end
