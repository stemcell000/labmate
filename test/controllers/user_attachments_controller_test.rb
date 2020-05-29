require 'test_helper'

class UserAttachmentsControllerTest < ActionController::TestCase
  setup do
    @user_attachment = user_attachments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_attachments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_attachment" do
    assert_difference('UserAttachment.count') do
      post :create, user_attachment: {  }
    end

    assert_redirected_to user_attachment_path(assigns(:user_attachment))
  end

  test "should show user_attachment" do
    get :show, id: @user_attachment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_attachment
    assert_response :success
  end

  test "should update user_attachment" do
    patch :update, id: @user_attachment, user_attachment: {  }
    assert_redirected_to user_attachment_path(assigns(:user_attachment))
  end

  test "should destroy user_attachment" do
    assert_difference('UserAttachment.count', -1) do
      delete :destroy, id: @user_attachment
    end

    assert_redirected_to user_attachments_path
  end
end
