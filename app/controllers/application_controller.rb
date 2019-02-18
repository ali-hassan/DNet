class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_params, if: :devise_controller?
  before_action :check_subdomain
  protected
  def configure_permitted_params
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:country, :city, :state, :contact_number, :sponsor_id, :referred_by_id,
                                             :document_number, :first_name, :last_name, :username])
  end
  def after_sign_in_path_for(resource)
    if resource.class.name != "AdminUser" && !resource.is_admin? && !resource.is_package_activated?
      buy_plans_path
    else
      request.env['omniauth.origin'] || stored_location_for(resource) || root_path
    end
  end
  def check_subdomain
    if request.subdomain == "office" && ["/", "/affiliate_program", "/download", "/faq", "/terms"].include?(request.path)
      redirect_to request.url.sub("office.", "")
    end
  end

end
