require 'test_helper'

class SubservicelinesControllerTest < ActionController::TestCase
  setup do
    @subserviceline = subservicelines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subservicelines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subserviceline" do
    assert_difference('Subserviceline.count') do
      post :create, subserviceline: { active: @subserviceline.active, ssl_name: @subserviceline.ssl_name, updated_by: @subserviceline.updated_by }
    end

    assert_redirected_to subserviceline_path(assigns(:subserviceline))
  end

  test "should show subserviceline" do
    get :show, id: @subserviceline
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @subserviceline
    assert_response :success
  end

  test "should update subserviceline" do
    put :update, id: @subserviceline, subserviceline: { active: @subserviceline.active, ssl_name: @subserviceline.ssl_name, updated_by: @subserviceline.updated_by }
    assert_redirected_to subserviceline_path(assigns(:subserviceline))
  end

  test "should destroy subserviceline" do
    assert_difference('Subserviceline.count', -1) do
      delete :destroy, id: @subserviceline
    end

    assert_redirected_to subservicelines_path
  end
end
