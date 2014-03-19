class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  
  def after_sign_in_path_for(resource)
    lists_path
  end

  private

  def authenticate_user
    unless current_user
      redirect_to root_path, 
        alert: t("auth_alerts.#{request.symbolized_path_parameters[:controller]}.#{request.symbolized_path_parameters[:action]}")
    end
  end

  def render_404
    flash[:error] = t("404_errors.#{request.symbolized_path_parameters[:controller]}.#{request.symbolized_path_parameters[:action]}")
    if request.symbolized_path_parameters[:controller] == "lists"
      redirect_to lists_path
    else
      redirect_to tasks_path
    end
  end
end
