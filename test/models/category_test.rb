require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  # Test Association
  test 'has_many items' do
    assert categories(:wrist_watch).items.exists?
  end

  test 'has_many brands' do
    assert categories(:wrist_watch).brands.exists?
  end

  # Test callback
  test 'update_cat_list is called on create' do
    category = new_category
    category.expects(:update_cat_list)
    category.save
  end

  test 'update_cat_list is called on destroy' do
    category = categories(:wrist_watch)
    category.expects(:update_cat_list)
    category.destroy
  end

  # Test validations
  test 'validation works' do
    category = new_category
    category.category_name = categories(:wrist_watch).category_name
    category.save
    assert_not category.valid?
    assert category.errors.messages.has_key?(:category_name)
  end

  # Callback works
  test 'update_cat_list works' do
    category = categories(:wrist_watch)
    Category.expects(:list)
    category.update_cat_list
  end

  # Test class method
  test 'list for reload false' do
    cache = mock('cache')
    key = "bazzar_cat_list"
    Rails.stubs('cache').returns(cache)
    cache.expects(:delete).with(key).never
    cache.expects(:fetch).with(key, expires_in: 15.days)
    Category.list(false)
  end

  test 'list for reload true' do
    cache = mock('cache')
    key = "bazzar_cat_list"
    Rails.stubs('cache').returns(cache)
    cache.expects(:delete).with(key)
    cache.expects(:fetch).with(key, expires_in: 15.days)
    Category.list(true)
  end

  # Test instance methods
  test 'disable works' do
    category = categories(:wrist_watch)
    category_status = category.status
    category.disable
    assert_equal category.status, "disabled"
  end

  private

  def new_category
    Category.new( category_name: 'new category')
  end
end
