class FriendshipsController < ApplicationController
  before_action :logged_in_user
  
  def create
    friend = User.find_by(id: params[:sender_id])
    if request = FriendRequest.find_by(sender_id: friend.id, receiver_id: current_user.id)
      friendship = current_user.friendships.build(friend_id: friend.id)
      if friendship.save
        request.destroy
        flash[:notice] = "You are now friends with #{friend.name}"
        redirect_back(fallback_location: root_path)
      else
        flash[:alert] = "Something went wrong"
      end
    else
      flash[:alert] = "You haven't sent this person a friend request yet. Send one now!"
      redirect_back(fallback_location: root_path)
    end
  end
  
  def destroy
    if friendship = current_user.friendships.find_by(friend_id: params[:friend_id])
      friendship.destroy
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
