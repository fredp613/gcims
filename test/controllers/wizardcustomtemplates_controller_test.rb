require 'test_helper'

class WizardcustomtemplatesControllerTest < ActionController::TestCase
  setup do
    @wizardcustomtemplate = wizardcustomtemplates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wizardcustomtemplates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wizardcustomtemplate" do
    assert_difference('Wizardcustomtemplate.count') do
      post :create, wizardcustomtemplate: { customtemplate_id: @wizardcustomtemplate.customtemplate_id, user_id: @wizardcustomtemplate.user_id, wizard_id: @wizardcustomtemplate.wizard_id }
    end

    assert_redirected_to wizardcustomtemplate_path(assigns(:wizardcustomtemplate))
  end

  test "should show wizardcustomtemplate" do
    get :show, id: @wizardcustomtemplate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wizardcustomtemplate
    assert_response :success
  end

  test "should update wizardcustomtemplate" do
    patch :update, id: @wizardcustomtemplate, wizardcustomtemplate: { customtemplate_id: @wizardcustomtemplate.customtemplate_id, user_id: @wizardcustomtemplate.user_id, wizard_id: @wizardcustomtemplate.wizard_id }
    assert_redirected_to wizardcustomtemplate_path(assigns(:wizardcustomtemplate))
  end

  test "should destroy wizardcustomtemplate" do
    assert_difference('Wizardcustomtemplate.count', -1) do
      delete :destroy, id: @wizardcustomtemplate
    end

    assert_redirected_to wizardcustomtemplates_path
  end
end
