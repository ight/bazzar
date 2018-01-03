class ApplicationController < ActionController::Base

  include Swagger::Docs::ImpotentMethods
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  rescue_from Bazzar::Exception::InvalidParameter, with: :invalid_parameter

  def render_error_json(message, status = :bad_request)
    render json: { error: message }, status: status
  end

  def invalid_parameter(exception)
    render_error_json(exception.message)
  end

  def authenticate_user!
    unauthorized_access if current_user.blank?
  end

  def unauthorized_access
    render_error_json(_('errors.unauthorized'), :unauthorized)
  end

  def current_user
    @current_user ||= User.from_authentication_token(request.env["HTTP_X_API_KEY"], true)
  end
end
