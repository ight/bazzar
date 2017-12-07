class Api::V1::CategoriesController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:create]
	swagger_controller :categories, "Handle Categories in Market"

  swagger_api :create do
  	summary 'Add a Category to Bazzar'
  	param :form, :"category[category_name]", :string, :required, "Enter Category Name"
  	response :created
  	response :bad_request
    response :unauthorized
    response :not_acceptable
    response :unprocessable_entity
  end

  def create
  	raise Bazzar::Exception::InvalidParameter.new(_('errors.categories.invalid_category_name')) if category_params[:category_name].blank?
  	@category = Category.new(category_params)
  	if @category.save
  		render 'show', status: :created
  	else
  		render 'shared/model_errors', locals: { object: @category }, status: :bad_request
  	end
  end

  private

  def category_params
  	params.require(:category).permit(:category_name)
  end

end