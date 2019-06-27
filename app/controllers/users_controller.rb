class UsersController < ApplicationController
  before_action :logged_in_user

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @requests = FriendRequest.find_by(receiver_id: @user.id)
  end

end
