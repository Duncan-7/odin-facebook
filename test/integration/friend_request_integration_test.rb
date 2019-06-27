require 'test_helper'

class FriendRequestIntegrationTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    getusers
    @duncan_willis = friend_requests(:duncan_willis)
    
  end

  test 'send a friend request' do
    sign_in(@duncan)
    assert_difference '@cordelia.received_requests.count', 1 do
      post friend_requests_path, params: {receiver_id: @cordelia.id }
    end
    assert_response :redirect
  end

  test 'destroy a friend request if logged in as sender' do
    sign_in(@duncan)
    assert_difference '@duncan.sent_requests.count', -1 do
      delete friend_request_path(@duncan_willis), params: {receiver_id: @willis.id}
    end
    assert_response :redirect
  end

  test 'destroy a friend request if logged in as receiver' do
    sign_in(@willis)
    assert_difference '@duncan.sent_requests.count', -1 do
      delete friend_request_path(@duncan_willis), params: {sender_id: @duncan.id}
    end
    assert_response :redirect
  end

  test "don't destroy friend request if not logged in as sender or receiver" do
    sign_in(@cordelia)
    assert_difference '@duncan.sent_requests.count', 0 do
      delete friend_request_path(@duncan_willis), params: {sender_id: @duncan.id}
    end
    assert_response :redirect
  end

  test "friend request should be destroyed after friendship created" do
    sign_in(@willis)
    assert_difference '@duncan.sent_requests.count', -1 do
      post friendships_path, params: {sender_id: @duncan.id }
    end
    assert_response :redirect
  end

end
