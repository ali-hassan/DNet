class UsersController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  layout "dashboard"

  def me

  end

  def system_password

  end

  def update
    if user.valid_password?(params[:user][:current_password])
      current_user.update(whitelist_user_params)
    end
  end

  def show
  end

  private
    def whitelist_user_params
      params.require(:user).permit(:password,
                                   :password_confirmation,
                                   :current_password, :first_name, :last_name, :username,
                                   :email, :phone, :gender, :package_id, :address, :country,
                                   :state, :zipcode)
    end
end
