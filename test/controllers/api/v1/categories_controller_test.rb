require 'test_helper'

class Api::V1::CategoriesControllerTest < ActionController::TestCase

  test 'create' do
    post :create, params: { category: { category_name: 'sample category' } }
    assert_response :created
    [:id, :category_name].each do |attr|
      assert json_response["category"].has_key?(attr.to_s), "The key #{attr.to_s} was not present"
    end   
  end

  test 'create errors fails for no name' do
    post :create, params: { category: { category_name: nil } }
    assert_equal _('errors.categories.invalid_category_name'), json_response['error']
  end  

  test 'create fails for duplicate name' do
    category = categories(:wrist_watch)
    post :create, params: { category: { category_name: category.category_name } }
    assert_equal  json_response['errors']['messages'].first, "Category name has already been taken"
  end

  test 'index' do
    get :index
    assert_response :ok
    assert_template :index
    [:id, :category_name].each do |attr|
      assert json_response["categories"][0].has_key?(attr.to_s), "The key #{attr.to_s} was not present"
    end
  end

  test 'destroy' do
    category = categories(:wrist_watch)
    delete :destroy, params: { category_id: category.id }
    assert_response :ok
  end

end