require 'rails_autolink'
class TrainingsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  layout "dashboard"


  def index
    @trainings = Training.all
  end
end
