class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_params, if: :devise_controller?
  before_action :check_subdomain
  protected
  def configure_permitted_params
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:country, :city, :state, :contact_number, :sponsor_id, :referred_by_id,
                                             :pin, :document_number, :first_name, :last_name, :username, :dob])
  end
  def after_sign_in_path_for(resource)
    if resource.class.name != "AdminUser" && !resource.is_admin? && !resource.is_package_activated? && !resource.is_pin
      dashboard_index_url(subdomain: 'office')
    else
      request.env['omniauth.origin'] || stored_location_for(resource) || resource.class.name == "AdminUser" && "/admin" || dashboard_index_url(subdomain: 'office')
    end
  end
  def after_sign_out_path_for(resource)
    new_user_session_url(subdomain: "office")
  end
  def check_subdomain
    if request.subdomain == "office" && (["/affiliate_program", "/download", "/faq", "/terms"].include?(request.path) || request.path == "/")
      redirect_to request.url.sub("office.", "")
    end
  end

end
