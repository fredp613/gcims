require 'test_helper'

class CustomfieldsControllerTest < ActionController::TestCase
  setup do
    @customfield = customfields(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customfields)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customfield" do
    assert_difference('Customfield.count') do
      post :create, customfield: { field_class: @customfield.field_class, field_name: @customfield.field_name, field_type: @customfield.field_type }
    end

    assert_redirected_to customfield_path(assigns(:customfield))
  end

  test "should show customfield" do
    get :show, id: @customfield
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @customfield
    assert_response :success
  end

  test "should update customfield" do
    patch :update, id: @customfield, customfield: { field_class: @customfield.field_class, field_name: @customfield.field_name, field_type: @customfield.field_type }
    assert_redirected_to customfield_path(assigns(:customfield))
  end

  test "should destroy customfield" do
    assert_difference('Customfield.count', -1) do
      delete :destroy, id: @customfield
    end

    assert_redirected_to customfields_path
  end
end
