class PostsController < ApplicationController
  before_action :find_group
  before_action :find_post, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  def new
    @post = @group.posts.new
  end
  def create
    @post = @group.posts.build(post_params)
    if @post.save
      redirect_to group_path(@group)
      flash[:success] = "Post create successful!"
    else
      render 'new'
    end
  end
  def edit
  end
  def update
    if @post.update(post_params)
      redirect_to group_path(@group)
      flash[:success] = "Post update successful!"
    else
      render 'edit'
    end
  end
  def destroy
    @post.destroy
    redirect_to group_path(@group)
    flash[:danger] = "Post deleted!"
  end

  private
  def post_params
    params.require(:post).permit(:content)
  end

  def find_group
    @group = Group.find(params[:group_id])
  end

  def find_post
    @post = @group.posts.find(params[:id])
  end
end
