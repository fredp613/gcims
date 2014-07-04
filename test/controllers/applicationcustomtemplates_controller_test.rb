require 'test_helper'

class ApplicationcustomtemplatesControllerTest < ActionController::TestCase
  setup do
    @applicationcustomtemplate = applicationcustomtemplates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:applicationcustomtemplates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create applicationcustomtemplate" do
    assert_difference('Applicationcustomtemplate.count') do
      post :create, applicationcustomtemplate: { application_id: @applicationcustomtemplate.application_id, customtemplate_id: @applicationcustomtemplate.customtemplate_id, user_id: @applicationcustomtemplate.user_id }
    end

    assert_redirected_to applicationcustomtemplate_path(assigns(:applicationcustomtemplate))
  end

  test "should show applicationcustomtemplate" do
    get :show, id: @applicationcustomtemplate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @applicationcustomtemplate
    assert_response :success
  end

  test "should update applicationcustomtemplate" do
    patch :update, id: @applicationcustomtemplate, applicationcustomtemplate: { application_id: @applicationcustomtemplate.application_id, customtemplate_id: @applicationcustomtemplate.customtemplate_id, user_id: @applicationcustomtemplate.user_id }
    assert_redirected_to applicationcustomtemplate_path(assigns(:applicationcustomtemplate))
  end

  test "should destroy applicationcustomtemplate" do
    assert_difference('Applicationcustomtemplate.count', -1) do
      delete :destroy, id: @applicationcustomtemplate
    end

    assert_redirected_to applicationcustomtemplates_path
  end
end
