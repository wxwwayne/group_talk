require 'rails_helper'
describe "Routes" do
  describe "UsersController" do
    it "routes get new user" do
      expect({ :get => "/users/sign_up" }).to route_to(:controller => 'devise/registrations',
                                                       :action => 'new')
    end

    it "routes post create user" do
      expect({ :post => '/users' }).to route_to(:controller => 'devise/registrations',
                                                :action => 'create')
    end

    it "routes get edit user" do
      expect({ :get => '/users/edit' }).to route_to(controller: 'devise/registrations',
                                                    action:'edit')
    end

    it "routes delete destroy user" do
      expect({ delete: '/users' }).to route_to(controller: 'devise/registrations',
                                               action: 'destroy')
    end
  end

  describe "SessionController" do
    it "routes get new session" do
      expect({ get: "/users/sign_in" }).to route_to(controller: 'devise/sessions',
                                                    action: 'new')
    end
  end

  describe "GroupsController" do
    it "routes get new group" do
      expect({ get: "/groups/new" }).to route_to(controller: 'groups',
                                                 action: 'new')
    end

    it "routes get root" do
      expect({ get: "/" }).to route_to(controller: 'groups',
                                       action: 'index')
    end

    it "routes post join group" do
      expect({ post: "/groups/1/join" }).to route_to(controller: 'groups',
                                                     id: '1',
                                                     action: 'join')
    end
  end

  describe "PostsController" do
    it "routes get new post" do
      expect({ get: "/groups/1/posts/new" }).to route_to(controller: 'posts',
                                                         group_id: '1',
                                                         action: 'new')
    end

    it "routes get edit post" do
      expect({ get: "/groups/1/posts/1/edit" }).to route_to(controller: 'posts',
                                                            group_id: '1',
                                                            action: 'edit',
                                                            id: '1')
    end
  end

  describe "AccountGroupsController" do
    it "routes get account group index" do
      expect({ get: "/account/groups" }).to route_to(controller: 'account/groups',
                                                     action: 'index')
    end
  end

  describe "AccountPostsController" do
    it "routes get account post index" do
      expect({ get: "/account/posts" }).to route_to(controller: 'account/posts',
                                                    action: 'index')
    end
  end
end
