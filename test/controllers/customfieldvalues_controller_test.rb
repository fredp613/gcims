require 'test_helper'

class CustomfieldvaluesControllerTest < ActionController::TestCase
  setup do
    @customfieldvalue = customfieldvalues(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customfieldvalues)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customfieldvalue" do
    assert_difference('Customfieldvalue.count') do
      post :create, customfieldvalue: { user_id: @customfieldvalue.user_id, value: @customfieldvalue.value, wizardcustomtemplate_id: @customfieldvalue.wizardcustomtemplate_id }
    end

    assert_redirected_to customfieldvalue_path(assigns(:customfieldvalue))
  end

  test "should show customfieldvalue" do
    get :show, id: @customfieldvalue
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @customfieldvalue
    assert_response :success
  end

  test "should update customfieldvalue" do
    patch :update, id: @customfieldvalue, customfieldvalue: { user_id: @customfieldvalue.user_id, value: @customfieldvalue.value, wizardcustomtemplate_id: @customfieldvalue.wizardcustomtemplate_id }
    assert_redirected_to customfieldvalue_path(assigns(:customfieldvalue))
  end

  test "should destroy customfieldvalue" do
    assert_difference('Customfieldvalue.count', -1) do
      delete :destroy, id: @customfieldvalue
    end

    assert_redirected_to customfieldvalues_path
  end
end
