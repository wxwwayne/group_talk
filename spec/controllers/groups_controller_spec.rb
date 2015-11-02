require 'rails_helper'

describe GroupsController do
  # before :each do
  #   @user = create(:user)
  #   sign_in @user
  # end
  let(:user) { create(:user) }
  let(:group) { create(:group, user: user) }
  let(:other_user) { create(:user) }
  let(:other_group) { create(:group, user: other_user) }
  describe "GET #NEW" do
    before (:each) { sign_in user }
    it "assigns a new group" do
      get :new
      expect(assigns(:group)).to be_a_new(Group)
    end
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "GET #EDIT" do
    before(:each) { sign_in user }

    it "assigns to_be_editted user" do
      get :edit, id: group
      expect(assigns(:group)).to eq group
    end
  end

  describe "PATCH #UPDATE" do
    before(:each) { sign_in user }
    it "changes the database" do
      patch :update, id: group, group: attributes_for(:group, title: "New title")
      expect(group.reload.title).to eq("New title")
    end
  end

  describe "POST #JOIN" do
    before(:each) { sign_in user }
    it "changes the database" do
      expect{ post :join, id: other_group }.to change(GroupUser, :count).by(1)
    end
  end
  describe "POST #QUIT" do
    before :each do
      sign_in user
      user.join_in(group)
    end
    it "changes the database" do
      expect{ post :quit, id: group }.to change(GroupUser, :count).by(-1)
    end
  end
end
