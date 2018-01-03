class Users::RegistrationsController < Devise::RegistrationsController

	skip_before_action :verify_authenticity_token
  before_filter :configure_permitted_parameters


  # skip_before_action :authenticate_user_token!, only: [:create]
  respond_to :json

  #Add this line
  swagger_controller :user_registrations, "Registrations"
 
  #Add this swagger_api block
  swagger_api :create do
    summary "Creates a new User"
    param :form, :'user[first_name]', :string, "First name"
    param :form, :'user[last_name]', :string, "Last name"
    param :form, :'user[email]', :string, :required, "Email address"
    param :form, :'user[password]', :string, :required, "Password"
    param :form, :'user[password_confirmation]', :string, :required, "Password Confirmation"
    param :form, :'user[contact_number]', :string, :required, "Phone Number"
    response :unauthorized
    response :not_acceptable
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:contact_number, :email, :first_name, :last_name, :password, :password_confirmation])
    # devise_parameter_sanitizer.for(:sign_up).push(:contact_number, :email, :first_name, :last_name, :password, :password_confirmation)
  end

  # private
  # def sign_up_params
  #   params.require(:user).permit(:contact_number, :email, :first_name, :last_name, :password, :password_confirmation)
  # end
end
