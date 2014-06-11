require 'test_helper'

class CustomfieldvalidatorsControllerTest < ActionController::TestCase
  setup do
    @customfieldvalidator = customfieldvalidators(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customfieldvalidators)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customfieldvalidator" do
    assert_difference('Customfieldvalidator.count') do
      post :create, customfieldvalidator: { customfield_id: @customfieldvalidator.customfield_id, type: @customfieldvalidator.type }
    end

    assert_redirected_to customfieldvalidator_path(assigns(:customfieldvalidator))
  end

  test "should show customfieldvalidator" do
    get :show, id: @customfieldvalidator
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @customfieldvalidator
    assert_response :success
  end

  test "should update customfieldvalidator" do
    patch :update, id: @customfieldvalidator, customfieldvalidator: { customfield_id: @customfieldvalidator.customfield_id, type: @customfieldvalidator.type }
    assert_redirected_to customfieldvalidator_path(assigns(:customfieldvalidator))
  end

  test "should destroy customfieldvalidator" do
    assert_difference('Customfieldvalidator.count', -1) do
      delete :destroy, id: @customfieldvalidator
    end

    assert_redirected_to customfieldvalidators_path
  end
end
