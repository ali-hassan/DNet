class NewsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  layout "dashboard"

  def index
    @news = News.where(is_active: true).paginate(page: params[:page]).order(created_at: :desc)
  end
end
