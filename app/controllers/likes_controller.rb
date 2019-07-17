class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    post = Post.find(params[:post_id])
    @like = post.likes.build
    @like.user_id = current_user.id
    if @like.save
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "Something went wrong"
      redirect_back(fallback_location: root_path)
    end
  end
  
  def destroy
    Like.find_by(post_id: params[:post_id], user_id: current_user.id).destroy
    redirect_back(fallback_location: root_path)
  end
end
