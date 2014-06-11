require 'test_helper'

class CustomfieldconditionsControllerTest < ActionController::TestCase
  setup do
    @customfieldcondition = customfieldconditions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customfieldconditions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customfieldcondition" do
    assert_difference('Customfieldcondition.count') do
      post :create, customfieldcondition: { condition: @customfieldcondition.condition, customfieldvalidator_id: @customfieldcondition.customfieldvalidator_id }
    end

    assert_redirected_to customfieldcondition_path(assigns(:customfieldcondition))
  end

  test "should show customfieldcondition" do
    get :show, id: @customfieldcondition
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @customfieldcondition
    assert_response :success
  end

  test "should update customfieldcondition" do
    patch :update, id: @customfieldcondition, customfieldcondition: { condition: @customfieldcondition.condition, customfieldvalidator_id: @customfieldcondition.customfieldvalidator_id }
    assert_redirected_to customfieldcondition_path(assigns(:customfieldcondition))
  end

  test "should destroy customfieldcondition" do
    assert_difference('Customfieldcondition.count', -1) do
      delete :destroy, id: @customfieldcondition
    end

    assert_redirected_to customfieldconditions_path
  end
end
