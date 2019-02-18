class VerifySponsorUsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def show
    @user = User.find_by username: params[:id]
  end
end
