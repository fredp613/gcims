require 'test_helper'

class CustomtemplatesControllerTest < ActionController::TestCase
  setup do
    @customtemplate = customtemplates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customtemplates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customtemplate" do
    assert_difference('Customtemplate.count') do
      post :create, customtemplate: { commitmentitem_id: @customtemplate.commitmentitem_id, name: @customtemplate.name }
    end

    assert_redirected_to customtemplate_path(assigns(:customtemplate))
  end

  test "should show customtemplate" do
    get :show, id: @customtemplate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @customtemplate
    assert_response :success
  end

  test "should update customtemplate" do
    patch :update, id: @customtemplate, customtemplate: { commitmentitem_id: @customtemplate.commitmentitem_id, name: @customtemplate.name }
    assert_redirected_to customtemplate_path(assigns(:customtemplate))
  end

  test "should destroy customtemplate" do
    assert_difference('Customtemplate.count', -1) do
      delete :destroy, id: @customtemplate
    end

    assert_redirected_to customtemplates_path
  end
end
