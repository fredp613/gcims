require 'test_helper'

class CorporationsControllerTest < ActionController::TestCase
  setup do
    @corporation = corporations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:corporations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create corporation" do
    assert_difference('Corporation.count') do
      post :create, corporation: { businessnumber: @corporation.businessnumber, client_id: @corporation.client_id, level: @corporation.level }
    end

    assert_redirected_to corporation_path(assigns(:corporation))
  end

  test "should show corporation" do
    get :show, id: @corporation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @corporation
    assert_response :success
  end

  test "should update corporation" do
    put :update, id: @corporation, corporation: { businessnumber: @corporation.businessnumber, client_id: @corporation.client_id, level: @corporation.level }
    assert_redirected_to corporation_path(assigns(:corporation))
  end

  test "should destroy corporation" do
    assert_difference('Corporation.count', -1) do
      delete :destroy, id: @corporation
    end

    assert_redirected_to corporations_path
  end
end
