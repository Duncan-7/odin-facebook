class UsersController < ApplicationController
  before_action :logged_in_user

  def index
  end

  def show
    @user = User.find(params[:id])
  end

end
