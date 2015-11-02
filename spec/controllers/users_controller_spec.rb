require 'rails_helper'

describe Devise::RegistrationsController do
  before (:each) { @request.env["devise.mapping"] = Devise.mappings[:user] }
  describe "GET #NEW" do
    it "it assigns a new user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
    it "renders new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #CREATE" do
    context 'valid attribute' do
      it "changes user_count in database" do
        expect{ post :create, user: attributes_for(:user) }.to change(User, :count).by(1)
      end
      it "redirects to root" do
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to root_path
      end
    end
    context 'invalid attribute' do
      it "do not change database if no email" do
        expect{ post :create, user: attributes_for(:user, email: nil) }.to change(User, :count).by(0)
      end
      it "do not change database if no password" do
        expect{ post :create, user: attributes_for(:user, password: nil) }.to change(User, :count).by(0)
      end
      it "rerender the :new template" do
        post :create, user: attributes_for(:user, email: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe "GET #EDIT" do
    before :each do
      @user = create(:user)
      sign_in @user
    end

    it "renders :edit page" do
      get :edit, id: @user
      expect(response).to render_template :edit
    end
    it "assigns to_be_editted user to the user" do
      get :edit, id: @user
      expect(assigns(:user)).to eq @user
    end
  end

  describe "PATCH #UPDATE" do
    before :each do
      @user = create(:user)
      @old_email = @user.email
      sign_in @user
    end
    context 'valid attributes' do
      it "updates user attributes" do
        patch :update, user: attributes_for(:update_user)
        expect(@user.reload.email).not_to eq(@old_email)
      end
      it "redirects to root" do
        patch :update, user: attributes_for(:update_user)
        expect(response).to redirect_to root_path
      end
    end
  end
  describe "DELETE #DESTROY" do
    before :each do
      @user = create(:user)
      sign_in @user
    end
    it "changes database" do
      expect{ delete :destroy }.to change(User, :count).by(-1)
    end
    it "redirects to root" do
      delete :destroy
      expect(response).to redirect_to root_path
    end
  end
end
