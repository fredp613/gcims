require 'test_helper'

class BudgetitemsControllerTest < ActionController::TestCase
  setup do
    @budgetitem = budgetitems(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:budgetitems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create budgetitem" do
    assert_difference('Budgetitem.count') do
      post :create, budgetitem: { actual: @budgetitem.actual, application_id: @budgetitem.application_id, budgetcategory_id: @budgetitem.budgetcategory_id, desc: @budgetitem.desc, fiscalyear_id: @budgetitem.fiscalyear_id, forecast: @budgetitem.forecast, title: @budgetitem.title }
    end

    assert_redirected_to budgetitem_path(assigns(:budgetitem))
  end

  test "should show budgetitem" do
    get :show, id: @budgetitem
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @budgetitem
    assert_response :success
  end

  test "should update budgetitem" do
    put :update, id: @budgetitem, budgetitem: { actual: @budgetitem.actual, application_id: @budgetitem.application_id, budgetcategory_id: @budgetitem.budgetcategory_id, desc: @budgetitem.desc, fiscalyear_id: @budgetitem.fiscalyear_id, forecast: @budgetitem.forecast, title: @budgetitem.title }
    assert_redirected_to budgetitem_path(assigns(:budgetitem))
  end

  test "should destroy budgetitem" do
    assert_difference('Budgetitem.count', -1) do
      delete :destroy, id: @budgetitem
    end

    assert_redirected_to budgetitems_path
  end
end
