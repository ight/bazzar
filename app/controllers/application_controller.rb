class ApplicationController < ActionController::Base

  include Swagger::Docs::ImpotentMethods
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Bazzar::Exception::InvalidParameter, with: :invalid_parameter

  def render_error_json(message, status = :bad_request)
    render json: { error: message }, status: status
  end

  def invalid_parameter(exception)
    render_error_json(exception.message)
  end
end
