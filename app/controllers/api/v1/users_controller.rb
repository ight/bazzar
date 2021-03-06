class Api::V1::UsersController < ApplicationController

  # Checking authorization
  load_and_authorize_resource :user

  swagger_controller :users, "For User actions"


  swagger_api :profile do
    summary 'Fetches the profile details of current user'
    response :ok
    response :unauthorized
    response :not_acceptable
  end

  def profile
    @user = current_user
    render :show
  end
end