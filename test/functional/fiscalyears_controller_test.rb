require 'test_helper'

class FiscalyearsControllerTest < ActionController::TestCase
  setup do
    @fiscalyear = fiscalyears(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fiscalyears)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fiscalyear" do
    assert_difference('Fiscalyear.count') do
      post :create, fiscalyear: { fy: @fiscalyear.fy }
    end

    assert_redirected_to fiscalyear_path(assigns(:fiscalyear))
  end

  test "should show fiscalyear" do
    get :show, id: @fiscalyear
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fiscalyear
    assert_response :success
  end

  test "should update fiscalyear" do
    put :update, id: @fiscalyear, fiscalyear: { fy: @fiscalyear.fy }
    assert_redirected_to fiscalyear_path(assigns(:fiscalyear))
  end

  test "should destroy fiscalyear" do
    assert_difference('Fiscalyear.count', -1) do
      delete :destroy, id: @fiscalyear
    end

    assert_redirected_to fiscalyears_path
  end
end
