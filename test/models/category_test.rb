require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  # Test Association
  test 'has_many items' do
    assert categories(:wrist_watch).items.exists?
  end
end
