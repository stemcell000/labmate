require 'test_helper'

class ItemAttachmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item_attachment = item_attachments(:one)
  end

  test "should get index" do
    get item_attachments_url
    assert_response :success
  end

  test "should get new" do
    get new_item_attachment_url
    assert_response :success
  end

  test "should create item_attachment" do
    assert_difference('ItemAttachment.count') do
      post item_attachments_url, params: { item_attachment: {  } }
    end

    assert_redirected_to item_attachment_url(ItemAttachment.last)
  end

  test "should show item_attachment" do
    get item_attachment_url(@item_attachment)
    assert_response :success
  end

  test "should get edit" do
    get edit_item_attachment_url(@item_attachment)
    assert_response :success
  end

  test "should update item_attachment" do
    patch item_attachment_url(@item_attachment), params: { item_attachment: {  } }
    assert_redirected_to item_attachment_url(@item_attachment)
  end

  test "should destroy item_attachment" do
    assert_difference('ItemAttachment.count', -1) do
      delete item_attachment_url(@item_attachment)
    end

    assert_redirected_to item_attachments_url
  end
end
