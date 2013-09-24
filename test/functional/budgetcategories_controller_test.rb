require 'test_helper'

class BudgetcategoriesControllerTest < ActionController::TestCase
  setup do
    @budgetcategory = budgetcategories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:budgetcategories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create budgetcategory" do
    assert_difference('Budgetcategory.count') do
      post :create, budgetcategory: { name: @budgetcategory.name }
    end

    assert_redirected_to budgetcategory_path(assigns(:budgetcategory))
  end

  test "should show budgetcategory" do
    get :show, id: @budgetcategory
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @budgetcategory
    assert_response :success
  end

  test "should update budgetcategory" do
    put :update, id: @budgetcategory, budgetcategory: { name: @budgetcategory.name }
    assert_redirected_to budgetcategory_path(assigns(:budgetcategory))
  end

  test "should destroy budgetcategory" do
    assert_difference('Budgetcategory.count', -1) do
      delete :destroy, id: @budgetcategory
    end

    assert_redirected_to budgetcategories_path
  end
end
