class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_params, if: :devise_controller?
  protected
  def configure_permitted_params
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:country, :city, :state, :contact_number, :sponsor_id,
                                             :document_number, :first_name, :last_name])
  end

end
