require 'test_helper'

class ApplicationtypesControllerTest < ActionController::TestCase
  setup do
    @applicationtype = applicationtypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:applicationtypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create applicationtype" do
    assert_difference('Applicationtype.count') do
      post :create, applicationtype: { name: @applicationtype.name }
    end

    assert_redirected_to applicationtype_path(assigns(:applicationtype))
  end

  test "should show applicationtype" do
    get :show, id: @applicationtype
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @applicationtype
    assert_response :success
  end

  test "should update applicationtype" do
    put :update, id: @applicationtype, applicationtype: { name: @applicationtype.name }
    assert_redirected_to applicationtype_path(assigns(:applicationtype))
  end

  test "should destroy applicationtype" do
    assert_difference('Applicationtype.count', -1) do
      delete :destroy, id: @applicationtype
    end

    assert_redirected_to applicationtypes_path
  end
end
