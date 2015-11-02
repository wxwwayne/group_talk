require 'rails_helper'

describe GroupsController do
  let(:user) { create(:user) }
  let(:group) { create(:group, user: user) }
  let(:other_user) { create(:user) }
  let(:other_group) { create(:group, user: other_user) }
  before (:each) { sign_in user }

  describe "GET #NEW" do
    it "assigns a new group" do
      get :new
      expect(assigns(:group)).to be_a_new(Group)
    end
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #CREATE" do
    it "changes the database" do
      expect{ post :create, group: attributes_for(:group) }.to change(Group, :count).by(1)
    end

    it "redirects to root" do
      post :create, group: attributes_for(:group)
      expect(response).to redirect_to groups_path
    end
  end

  describe "GET #EDIT" do
    it "assigns to_be_editted user" do
      group
      get :edit, id: group
      expect(assigns(:group)).to eq group
    end
  end

  describe "PATCH #UPDATE" do
    it "changes the database" do
      patch :update, id: group, group: attributes_for(:group, title: "New title")
      expect(group.reload.title).to eq("New title")
    end
  end

  describe "DELETE #DESTROY" do
    it "changes the database" do
      group
      expect{ delete :destroy, id: group }.to change(Group, :count).by(-1)
    end
  end

  describe "POST #JOIN" do
    it "changes the database" do
      expect{ post :join, id: other_group }.to change(GroupUser, :count).by(1)
    end
  end

  describe "POST #QUIT" do
    before :each do
      user.join_in(group)
    end
    it "changes the database" do
      expect{ post :quit, id: group }.to change(GroupUser, :count).by(-1)
    end
  end
end
