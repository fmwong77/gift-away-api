require 'test_helper'

class RepliesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reply = replies(:one)
  end

  test "should get index" do
    get replies_url, as: :json
    assert_response :success
  end

  test "should create reply" do
    assert_difference('Reply.count') do
      post replies_url, params: { reply: { comment_id: @reply.comment_id, content: @reply.content, user_id: @reply.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show reply" do
    get reply_url(@reply), as: :json
    assert_response :success
  end

  test "should update reply" do
    patch reply_url(@reply), params: { reply: { comment_id: @reply.comment_id, content: @reply.content, user_id: @reply.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy reply" do
    assert_difference('Reply.count', -1) do
      delete reply_url(@reply), as: :json
    end

    assert_response 204
  end
end
