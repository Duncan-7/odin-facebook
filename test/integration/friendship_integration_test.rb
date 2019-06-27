require 'test_helper'

class FriendshipIntegrationTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    getusers
    @duncan_cordelia = friendships(:duncan_cordelia)
    @cordelia_duncan = friendships(:cordelia_duncan)
  end

  test "friendship not created if request receiver not logged in" do
    
    assert_difference '@willis.friends.count', 0 do
      post friendships_path, params: {sender_id: @duncan.id }
    end
  end

  test "create friendship succeeds after sending friend request" do
    sign_in(@willis)
    assert_difference '@willis.friends.count', 1 do
      post friendships_path, params: {sender_id: @duncan.id }
    end
    
    assert_response :redirect
  end

  test "other side of friendship also created" do
    sign_in(@willis)
    assert_difference '@duncan.friends.count', 1 do
      post friendships_path, params: {sender_id: @duncan.id }
    end
    assert_response :redirect
  end

  test "create friendship fails without friend request" do
    sign_in(@barbara)
    assert_difference '@barbara.friends.count', 0 do
      post friendships_path, params: {sender_id: @duncan.id }
    end
    assert_response :redirect
  end

  test "friendship properly destroyed when logged in as one of the friends" do
    sign_in(@duncan)
    assert_difference '@duncan.friends.count', -1 do
      delete friendship_path(@duncan_cordelia), params: {friend_id: @cordelia.id}
    end
  end

  test "friendship not destroyed when not logged in as one of the friends" do
    sign_in(@willis)
    assert_difference '@duncan.friends.count', 0 do
      delete friendship_path(@duncan_cordelia), params: {friend_id: @cordelia.id}
    end
  end

end
