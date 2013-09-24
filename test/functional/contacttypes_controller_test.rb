require 'test_helper'

class ContacttypesControllerTest < ActionController::TestCase
  setup do
    @contacttype = contacttypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contacttypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contacttype" do
    assert_difference('Contacttype.count') do
      post :create, contacttype: { type: @contacttype.type }
    end

    assert_redirected_to contacttype_path(assigns(:contacttype))
  end

  test "should show contacttype" do
    get :show, id: @contacttype
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contacttype
    assert_response :success
  end

  test "should update contacttype" do
    put :update, id: @contacttype, contacttype: { type: @contacttype.type }
    assert_redirected_to contacttype_path(assigns(:contacttype))
  end

  test "should destroy contacttype" do
    assert_difference('Contacttype.count', -1) do
      delete :destroy, id: @contacttype
    end

    assert_redirected_to contacttypes_path
  end
end
