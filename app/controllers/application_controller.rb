class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :avatar, :password_confirmation, :current_password) }
  end

  def authorize_user_for_action!(author)
    unless current_user == author || current_user.admin?
      permission_denied
    end

    false
  end

  def authorize_user!
    unless current_user
      redirect_to root_path, notice: "You must be signed in to do this."
    end
  end

  def permission_denied
    # render text: 'Bad credentials', status: 401
    raise ActionController::RoutingError.new("Not Found")
  end

  def authorize_admin!
    unless current_user && current_user.admin?
      permission_denied
    end
  end
end
