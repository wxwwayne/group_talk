class PostsController < ApplicationController
  before_action :find_group
  before_action :find_post, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :membership_check, only:[:new, :create]
  def new
    @post = @group.posts.new
  end
  def create
    @post = @group.posts.build(post_params)
    @post.user = current_user
    if @post.save
      redirect_to group_path(@group)
      flash[:success] = "Post create successful!"
    else
      render 'new'
    end
  end
  def edit
    # @post = current_user.posts.find(params[:id])
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
    @post = current_user.posts.find_by(id=params[:id])
    if !@post
      redirect_to group_path(@group)
      flash[:danger] = "You cannot modify posts which belong to others!"
    end
  end
  def membership_check
    if !current_user.is_member_of?(@group)
      redirect_to group_path(@group)
      flash[:warning] = "You cannot post in this group if you are not a member!"
    end
  end
end
