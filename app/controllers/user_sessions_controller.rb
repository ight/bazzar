class UserSessionsController < Devise::SessionsController

  skip_before_action :verify_authenticity_token, :verify_signed_out_user
  skip_before_action :authenticate_user!, only: [:create]

  respond_to :json

  swagger_controller :user_sessions, "User Login Management"

  swagger_api :create do
    summary 'Sign in a user to the application and returns back authentication token'
    param :form, :'user[email]', :string, :required, 'Email'
    param :form, :'user[password]', :password, :required, 'Password'
    response :created
    response :unauthorized
  end

  # Create method
  #
  # This method uses devise authentication system
  #
  # We are make it return authentication key in returns.
  def create
    resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    render json: { api_key: resource.generate_auth_token }, status: :created
  end
end