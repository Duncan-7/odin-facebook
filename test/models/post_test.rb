require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:duncan)
    @post = @user.posts.build(content: "Lorem ipsum")
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "user id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test "content should be present" do
    @post.content = "   "
    assert_not @post.valid?
  end

  test "content should be at most 500 characters" do
    @post.content = "a" * 501
    assert_not @post.valid?
  end
end
