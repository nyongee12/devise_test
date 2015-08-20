class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

	before_action :add_column, if: :devise_controller?

  protected

  def add_column
    registration_params = [:username, :name, :age, :gender, :email, :password, :password_confirmation]
    @page = 1
    if params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) {
        |u| u.permit(registration_params)
      }
      devise_parameter_sanitizer.for(:sign_in) {
        |u| u.permit(registration_params << :remember_me)
      }
    elsif params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) {
        |u| u.permit(registration_params << :current_password)
      }
    end
  end

end
