require 'test_helper'

class CustomtemplatetypesControllerTest < ActionController::TestCase
  setup do
    @customtemplatetype = customtemplatetypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customtemplatetypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customtemplatetype" do
    assert_difference('Customtemplatetype.count') do
      post :create, customtemplatetype: { modelstate_id: @customtemplatetype.modelstate_id, type: @customtemplatetype.type }
    end

    assert_redirected_to customtemplatetype_path(assigns(:customtemplatetype))
  end

  test "should show customtemplatetype" do
    get :show, id: @customtemplatetype
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @customtemplatetype
    assert_response :success
  end

  test "should update customtemplatetype" do
    patch :update, id: @customtemplatetype, customtemplatetype: { modelstate_id: @customtemplatetype.modelstate_id, type: @customtemplatetype.type }
    assert_redirected_to customtemplatetype_path(assigns(:customtemplatetype))
  end

  test "should destroy customtemplatetype" do
    assert_difference('Customtemplatetype.count', -1) do
      delete :destroy, id: @customtemplatetype
    end

    assert_redirected_to customtemplatetypes_path
  end
end
