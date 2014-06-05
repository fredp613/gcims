require 'test_helper'

class UserClientsControllerTest < ActionController::TestCase
  setup do
    @user_client = user_clients(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_clients)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_client" do
    assert_difference('UserClient.count') do
      post :create, user_client: { client_id: @user_client.client_id, user_id: @user_client.user_id }
    end

    assert_redirected_to user_client_path(assigns(:user_client))
  end

  test "should show user_client" do
    get :show, id: @user_client
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_client
    assert_response :success
  end

  test "should update user_client" do
    patch :update, id: @user_client, user_client: { client_id: @user_client.client_id, user_id: @user_client.user_id }
    assert_redirected_to user_client_path(assigns(:user_client))
  end

  test "should destroy user_client" do
    assert_difference('UserClient.count', -1) do
      delete :destroy, id: @user_client
    end

    assert_redirected_to user_clients_path
  end
end
