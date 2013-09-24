require 'test_helper'

class ProductservicelinesControllerTest < ActionController::TestCase
  setup do
    @productserviceline = productservicelines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:productservicelines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create productserviceline" do
    assert_difference('Productserviceline.count') do
      post :create, productserviceline: { psl_name: @productserviceline.psl_name }
    end

    assert_redirected_to productserviceline_path(assigns(:productserviceline))
  end

  test "should show productserviceline" do
    get :show, id: @productserviceline
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @productserviceline
    assert_response :success
  end

  test "should update productserviceline" do
    put :update, id: @productserviceline, productserviceline: { psl_name: @productserviceline.psl_name }
    assert_redirected_to productserviceline_path(assigns(:productserviceline))
  end

  test "should destroy productserviceline" do
    assert_difference('Productserviceline.count', -1) do
      delete :destroy, id: @productserviceline
    end

    assert_redirected_to productservicelines_path
  end
end
