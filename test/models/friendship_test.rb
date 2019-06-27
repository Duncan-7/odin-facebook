require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers

  def setup
    getusers
    @duncan_cordelia = friendships(:duncan_cordelia)
    @cordelia_duncan = friendships(:cordelia_duncan)
  end

  test 'both sides of a friendship get created properly' do
    @duncan.friendships.create(friend_id: @willis.id)
    assert @duncan.friends.include?(@willis)
    assert @willis.friends.include?(@duncan)
  end

  test 'both sides of a friendship get destroyed properly' do
    friendship = @duncan.friendships.find_by(friend_id: @cordelia.id)
    friendship.destroy
    assert_not @duncan.friends.include?(@cordelia)
    assert_not @cordelia.friends.include?(@duncan)
  end
end