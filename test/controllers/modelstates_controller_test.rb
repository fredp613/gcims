require 'test_helper'

class ModelstatesControllerTest < ActionController::TestCase
  setup do
    @modelstate = modelstates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:modelstates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create modelstate" do
    assert_difference('Modelstate.count') do
      post :create, modelstate: { object: @modelstate.object, state: @modelstate.state, user_id: @modelstate.user_id }
    end

    assert_redirected_to modelstate_path(assigns(:modelstate))
  end

  test "should show modelstate" do
    get :show, id: @modelstate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @modelstate
    assert_response :success
  end

  test "should update modelstate" do
    patch :update, id: @modelstate, modelstate: { object: @modelstate.object, state: @modelstate.state, user_id: @modelstate.user_id }
    assert_redirected_to modelstate_path(assigns(:modelstate))
  end

  test "should destroy modelstate" do
    assert_difference('Modelstate.count', -1) do
      delete :destroy, id: @modelstate
    end

    assert_redirected_to modelstates_path
  end
end
