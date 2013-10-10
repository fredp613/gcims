require 'test_helper'

class SearchesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get advanced" do
    get :advanced
    assert_response :success
  end

end