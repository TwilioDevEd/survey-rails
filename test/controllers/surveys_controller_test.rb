require 'test_helper'

class SurveysControllerTest < ActionController::TestCase
  setup do
    @survey = surveys(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:surveys)
  end

  test "should get new survey questions" do
    get :import
    assert_response 302 # redirect to home page
  end

  test "should serve up TwiMl at connect_call" do
    get :connect_call, :From => "15556505813"
    assert_response :success
  end
end
