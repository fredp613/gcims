require 'test_helper'

class CfctsControllerTest < ActionController::TestCase
  setup do
    @cfct = cfcts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cfcts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cfct" do
    assert_difference('Cfct.count') do
      post :create, cfct: { customfield_id: @cfct.customfield_id, customtemplate_id: @cfct.customtemplate_id }
    end

    assert_redirected_to cfct_path(assigns(:cfct))
  end

  test "should show cfct" do
    get :show, id: @cfct
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cfct
    assert_response :success
  end

  test "should update cfct" do
    patch :update, id: @cfct, cfct: { customfield_id: @cfct.customfield_id, customtemplate_id: @cfct.customtemplate_id }
    assert_redirected_to cfct_path(assigns(:cfct))
  end

  test "should destroy cfct" do
    assert_difference('Cfct.count', -1) do
      delete :destroy, id: @cfct
    end

    assert_redirected_to cfcts_path
  end
end
