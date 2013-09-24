require 'test_helper'

class AddresstypesControllerTest < ActionController::TestCase
  setup do
    @addresstype = addresstypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:addresstypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create addresstype" do
    assert_difference('Addresstype.count') do
      post :create, addresstype: { type: @addresstype.type }
    end

    assert_redirected_to addresstype_path(assigns(:addresstype))
  end

  test "should show addresstype" do
    get :show, id: @addresstype
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @addresstype
    assert_response :success
  end

  test "should update addresstype" do
    put :update, id: @addresstype, addresstype: { type: @addresstype.type }
    assert_redirected_to addresstype_path(assigns(:addresstype))
  end

  test "should destroy addresstype" do
    assert_difference('Addresstype.count', -1) do
      delete :destroy, id: @addresstype
    end

    assert_redirected_to addresstypes_path
  end
end
