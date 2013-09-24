require 'test_helper'

class ClienttypesControllerTest < ActionController::TestCase
  setup do
    @clienttype = clienttypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:clienttypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create clienttype" do
    assert_difference('Clienttype.count') do
      post :create, clienttype: { name: @clienttype.name }
    end

    assert_redirected_to clienttype_path(assigns(:clienttype))
  end

  test "should show clienttype" do
    get :show, id: @clienttype
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @clienttype
    assert_response :success
  end

  test "should update clienttype" do
    put :update, id: @clienttype, clienttype: { name: @clienttype.name }
    assert_redirected_to clienttype_path(assigns(:clienttype))
  end

  test "should destroy clienttype" do
    assert_difference('Clienttype.count', -1) do
      delete :destroy, id: @clienttype
    end

    assert_redirected_to clienttypes_path
  end
end
