class PostsController < ApplicationController
  before_action :require_login
  before_action :is_post_owner?, only: [:edit, :update]
  
  def new
    @post = Post.new
    render :new
  end
  
  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id

    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end
  
  def show
    @post = Post.find(params[:id])
    render :show
  end
  
  def edit
    @post = Post.find(params[:id])
    render :edit
  end
  
  def update
     @post = Post.find(params[:id])

    if @post.author_id == current_user.id && @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash[:errors] = ["You cannot edit this post"]
      redirect_to post_url(@post)
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
  
    if @post.author_id == current_user.id
      @post.delete!
      redirect_to sub_url(@post.sub_id)
    else
      flash.now[:errors] = ["You cannot delete this post"]
      render :show
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
  
  def is_post_owner?
    @post = Post.find(params[:id])
    @post.author_id == current_user.id
  end
end
