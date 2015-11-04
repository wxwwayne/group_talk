class Api::V1::GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  skip_before_action :verify_authenticity_token
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
      current_user.join_in(@group)
      redirect_to api_v1_groups_url
    else
      render :new
    end
  end

  def destroy
    @group = current_user.groups.find(params[:id])
    @group.destroy
    redirect_to api_v1_groups_url
    flash[:danger] = "Group has been deleted!"
  end

  def update
    @group = current_user.groups.find(params[:id])
    if @group.update(group_params)
      redirect_to api_v1_groups_url
      flash[:success] = "Group update successful!"
    else
      render 'edit'
    end
  end

  def edit
    @group = current_user.groups.find(params[:id])
  end

  def join
    @group = Group.find(params[:id])
    if !current_user.is_member_of?(@group)
      current_user.join_in(@group)
      flash[:success] = "You have successfully joined the group!"
    else
      flash[:warning] = "You are already a member!"
    end
    redirect_to api_v1_group_url(@group)
  end

  def quit
    @group = Group.find(params[:id])
    if current_user.is_member_of?(@group)
      current_user.quit_from(@group)
      flash[:success] = "You have successfully quitted the group!"
    else
      flash[:warning] = "You are not yet a member!"
    end
    redirect_to api_v1_group_url(@group)
  end

  private
  def group_params
    params.require(:group).permit(:title, :description)
  end

end
