require 'test_helper'

class CommitmentitemsControllerTest < ActionController::TestCase
  setup do
    @commitmentitem = commitmentitems(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:commitmentitems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create commitmentitem" do
    assert_difference('Commitmentitem.count') do
      post :create, commitmentitem: { active: @commitmentitem.active, ci_name: @commitmentitem.ci_name, updated_by: @commitmentitem.updated_by }
    end

    assert_redirected_to commitmentitem_path(assigns(:commitmentitem))
  end

  test "should show commitmentitem" do
    get :show, id: @commitmentitem
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @commitmentitem
    assert_response :success
  end

  test "should update commitmentitem" do
    put :update, id: @commitmentitem, commitmentitem: { active: @commitmentitem.active, ci_name: @commitmentitem.ci_name, updated_by: @commitmentitem.updated_by }
    assert_redirected_to commitmentitem_path(assigns(:commitmentitem))
  end

  test "should destroy commitmentitem" do
    assert_difference('Commitmentitem.count', -1) do
      delete :destroy, id: @commitmentitem
    end

    assert_redirected_to commitmentitems_path
  end
end
