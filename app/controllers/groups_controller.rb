class GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts
  end

  def new
    @group = current_user.groups.new
  end

  def create
    @group = current_user.groups.create(group_params)

    if @group.save
      redirect_to groups_url
    else
      render :new
    end
  end

  def destroy
    @group = current_user.groups.find(params[:id])
    @group.destroy
    redirect_to groups_url
    flash[:danger] = "Group has been deleted!"
  end

  def update
    @group = current_user.groups.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_url
      flash[:success] = "Group update successful!"
    else
      render 'edit'
    end
  end

  def edit
    @group = current_user.groups.find(params[:id])
  end

  private
  def group_params
    params.require(:group).permit(:title, :description)
  end

end
