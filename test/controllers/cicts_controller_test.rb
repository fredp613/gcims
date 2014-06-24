require 'test_helper'

class CictsControllerTest < ActionController::TestCase
  setup do
    @cict = cicts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cicts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cict" do
    assert_difference('Cict.count') do
      post :create, cict: { commitmentitem_id: @cict.commitmentitem_id, customtemplate_id: @cict.customtemplate_id }
    end

    assert_redirected_to cict_path(assigns(:cict))
  end

  test "should show cict" do
    get :show, id: @cict
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cict
    assert_response :success
  end

  test "should update cict" do
    patch :update, id: @cict, cict: { commitmentitem_id: @cict.commitmentitem_id, customtemplate_id: @cict.customtemplate_id }
    assert_redirected_to cict_path(assigns(:cict))
  end

  test "should destroy cict" do
    assert_difference('Cict.count', -1) do
      delete :destroy, id: @cict
    end

    assert_redirected_to cicts_path
  end
end
