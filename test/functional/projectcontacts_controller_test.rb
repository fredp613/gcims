require 'test_helper'

class ProjectcontactsControllerTest < ActionController::TestCase
  setup do
    @projectcontact = projectcontacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projectcontacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create projectcontact" do
    assert_difference('Projectcontact.count') do
      post :create, projectcontact: {  }
    end

    assert_redirected_to projectcontact_path(assigns(:projectcontact))
  end

  test "should show projectcontact" do
    get :show, id: @projectcontact
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @projectcontact
    assert_response :success
  end

  test "should update projectcontact" do
    put :update, id: @projectcontact, projectcontact: {  }
    assert_redirected_to projectcontact_path(assigns(:projectcontact))
  end

  test "should destroy projectcontact" do
    assert_difference('Projectcontact.count', -1) do
      delete :destroy, id: @projectcontact
    end

    assert_redirected_to projectcontacts_path
  end
end
