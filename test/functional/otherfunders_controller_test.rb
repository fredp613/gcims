require 'test_helper'

class OtherfundersControllerTest < ActionController::TestCase
  setup do
    @otherfunder = otherfunders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:otherfunders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create otherfunder" do
    assert_difference('Otherfunder.count') do
      post :create, otherfunder: { application_id: @otherfunder.application_id, name: @otherfunder.name, requested: @otherfunder.requested }
    end

    assert_redirected_to otherfunder_path(assigns(:otherfunder))
  end

  test "should show otherfunder" do
    get :show, id: @otherfunder
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @otherfunder
    assert_response :success
  end

  test "should update otherfunder" do
    put :update, id: @otherfunder, otherfunder: { application_id: @otherfunder.application_id, name: @otherfunder.name, requested: @otherfunder.requested }
    assert_redirected_to otherfunder_path(assigns(:otherfunder))
  end

  test "should destroy otherfunder" do
    assert_difference('Otherfunder.count', -1) do
      delete :destroy, id: @otherfunder
    end

    assert_redirected_to otherfunders_path
  end
end
