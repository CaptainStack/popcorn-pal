require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  test "should get home" do
    get :index
    assert_response :success
  end

end
