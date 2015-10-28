class GroupsController < ApplicationController
  before_action :find_group, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @groups = Group.all
  end

  def show
    @posts = @group.posts
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.create(group_params)

    if @group.save
      redirect_to groups_url
    else
      render :new
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_url
    flash[:danger] = "Group has been deleted!"
  end

  def update
    if @group.update(group_params)
      redirect_to groups_url
      flash[:success] = "Group update successful!"
    else
      render 'edit'
    end
  end

  def edit
  end

  private
  def group_params
    params.require(:group).permit(:title, :description)
  end

  def find_group
    @group = Group.find(params[:id])
  end

end
