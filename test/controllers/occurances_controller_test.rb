require 'test_helper'

class OccurancesControllerTest < ActionController::TestCase
  setup do
    @occurance = occurances(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:occurances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create occurance" do
    assert_difference('Occurance.count') do
      post :create, occurance: { comment: @occurance.comment, done: @occurance.done, item_id: @occurance.item_id, name: @occurance.name }
    end

    assert_redirected_to occurance_path(assigns(:occurance))
  end

  test "should show occurance" do
    get :show, id: @occurance
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @occurance
    assert_response :success
  end

  test "should update occurance" do
    patch :update, id: @occurance, occurance: { comment: @occurance.comment, done: @occurance.done, item_id: @occurance.item_id, name: @occurance.name }
    assert_redirected_to occurance_path(assigns(:occurance))
  end

  test "should destroy occurance" do
    assert_difference('Occurance.count', -1) do
      delete :destroy, id: @occurance
    end

    assert_redirected_to occurances_path
  end
end
