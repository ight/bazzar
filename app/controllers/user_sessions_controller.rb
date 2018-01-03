class UserSessionsController < Devise::SessionsController

  skip_before_action :verify_authenticity_token, :verify_signed_out_user

  respond_to :json

  swagger_controller :user_sessions, "User Login Management"

  swagger_api :create do
    summary 'Sign in a user to the application and returns back authentication token'
    param :form, :'user[email]', :string, :required, 'Email'
    param :form, :'user[password]', :password, :required, 'Password'
    response :created
    response :unauthorized
  end
end