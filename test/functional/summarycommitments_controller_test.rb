require 'test_helper'

class SummarycommitmentsControllerTest < ActionController::TestCase
  setup do
    @summarycommitment = summarycommitments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:summarycommitments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create summarycommitment" do
    assert_difference('Summarycommitment.count') do
      post :create, summarycommitment: { active: @summarycommitment.active, sc_name: @summarycommitment.sc_name, updated_by: @summarycommitment.updated_by }
    end

    assert_redirected_to summarycommitment_path(assigns(:summarycommitment))
  end

  test "should show summarycommitment" do
    get :show, id: @summarycommitment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @summarycommitment
    assert_response :success
  end

  test "should update summarycommitment" do
    put :update, id: @summarycommitment, summarycommitment: { active: @summarycommitment.active, sc_name: @summarycommitment.sc_name, updated_by: @summarycommitment.updated_by }
    assert_redirected_to summarycommitment_path(assigns(:summarycommitment))
  end

  test "should destroy summarycommitment" do
    assert_difference('Summarycommitment.count', -1) do
      delete :destroy, id: @summarycommitment
    end

    assert_redirected_to summarycommitments_path
  end
end
