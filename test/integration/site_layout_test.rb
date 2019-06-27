require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:duncan)
    sign_in(@user)
  end

  test "need to be logged in" do
    sign_out(@user)
    get root_path
    follow_redirect!
    assert_template 'devise/sessions/new'
  end

  test "layout links" do
    get root_path
    assert_template 'users/index'
    assert_select "a[href=?]", user_path(@user)
    
    assert_select "a[href=?]", destroy_user_session_path
  end
end
