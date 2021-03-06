class PostsController < ApplicationController
  before_action :logged_in_user
  
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "Post created"
      redirect_to posts_path
    else
      render 'new'
    end
  end
  
  def show
    @post = Post.find(params[:id])
    
    @comments = @post.comments
    @comment = @post.comments.build
    @likes = @post.likes
  end

 

  def index
    @user_posts = current_user.posts
    @friend_posts = current_user.friends.each_with_object([]) { |friend, results| results << friend.posts }
  
    @feed = [@user_posts, @friend_posts].flatten.sort_by { |post| post.created_at }.reverse
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:notice] = "Edit successful"
      redirect_to posts_path
    else
      render 'edit'
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    flash[:notice] = "Post deleted"
    redirect_to posts_path
  end

  private
    def post_params
      params.require(:post).permit(:content, :image)
    end
end
