class VerifySponsorUsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def show
    @user = User.find_by sponsor_id: params[:id]
  end
end
