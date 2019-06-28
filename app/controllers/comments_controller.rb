class CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:notice] = "Comment created"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "Error"
      redirect_back(fallback_location: root_path)
    end
  end
  
  def destroy
    Comment.find(params[:id]).destroy
    flash[:notice] = "Comment deleted"
    redirect_back(fallback_location: root_path)
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :user_id)
    end
end
