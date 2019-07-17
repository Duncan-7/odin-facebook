class FriendRequestsController < ApplicationController
  before_action :logged_in_user
  
  def create
    user = User.find(params[:receiver_id])
    friend_request = current_user.sent_requests.build(receiver_id: user.id)
    if friend_request.save
      flash[:notice] = "Friend request sent"
      redirect_back(fallback_location: root_path)
    else
      flash[:notice] = "Friend request could not be sent"
      redirect_back(fallback_location: root_path)
    end
  end
  
  def destroy
    if request = FriendRequest.find_by(sender_id: params[:sender_id], receiver_id: current_user.id) ||
      FriendRequest.find_by(sender_id: current_user.id, receiver_id: params[:receiver_id])
      request.destroy
      flash[:notice] = "Friend request cancelled"
      redirect_back(fallback_location: root_path)
    else
      flash[:notice] = "Friend request could not be found"
      redirect_back(fallback_location: root_path)
    end
  end
end
