ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!(Minitest::Reporters::ProgressReporter.new, ENV, Minitest.backtrace_filter)

class ActionController::TestCase
  include Devise::Test::ControllerHelpers
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def api_key_header
    {'X-API-KEY' => 'some_api_key'}
  end

  def setup
    if @controller.present? && !@controller.instance_of?(UserSessionsController)
      @request.headers['HTTP_X_API_KEY'] = 'some_api_key'
      @request.host = 'ight.me'
      ActiveSupport::Cache::FileStore.any_instance.stubs(:read).with("api/some_api_key").returns("prakash_auth")
    end

    if @controller.present? && (@controller.class <= ApplicationController) && !@controller.instance_of?(UserSessionsController)
      sign_in(users(:prakash))
    end
  end

  # Add more helper methods to be used by all tests here...

  require 'mocha/setup'
  require 'test_unit_extensions'
end
