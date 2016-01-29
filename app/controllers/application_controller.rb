class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
      respond_to do |format|
      format.json { render nothing: true, status: :forbidden }
      format.html { redirect_to main_app.root_url, :alert => exception.message }
    end
   end



  protected

  def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :current_password, :avatar) }
  end

end