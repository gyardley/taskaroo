require 'spec_helper'

describe ListsController do

  describe "#index" do

    context "while signed out" do

      it "redirects to welcome page" do
        get :index
        response.should redirect_to root_path
        flash[:alert].should eql "You need to be signed in to view ToDo Lists."
      end
    end

    context "while signed in" do

      # API incompatibility between Devise and RSpec 2.14.1 doesn't let you use before(:all) here.
      before(:each) do
        @user = users(:user_1)
        sign_in @user
      end

      it "returns a page" do
        get :index
        response.should be_success
      end

      it "contains at least one of the user's list" do
        new_list = @user.lists.first

        get :index
        assigns["lists"].first.should eql new_list
      end

      it "contains multiple of the user's lists if present" do
        new_list = List.create(name: "gazebo2", user: @user)

        get :index
        assigns["lists"].count.should eql 2
      end

      it "doesn't show lists for other users" do
        new_user = User.create(uid: '2468', provider: 'twitter', nickname: 'plizzle')
        sign_in new_user

        get :index
        assigns["lists"].count.should eql 0
      end
    end
  end

  describe "#show" do

    before(:each) do
      @user = users(:user_1)
      @list = @user.lists.first
    end

    context "while signed out" do

      it "redirects to welcome page" do
        get :show, id: @list
        response.should redirect_to root_path
        flash[:alert].should eql "You need to be signed in to view ToDo Lists."
      end
    end

    context "while signed in" do

      before(:each) do
        sign_in @user
      end

      it "returns a page" do
        get :show, id: @list
        response.should be_success
      end

      it "has the right list as a variable" do

        get :show, id: @list
        assigns["list"].should eql @list
      end

      it "redirects to welcome page if I request a list that's not mine" do
        user2 = users(:user_2)
        list2 = user2.lists.first

        get :show, id: list2

        response.should redirect_to root_path
        flash[:alert].should eql "List not found."
      end
    end
  end

  describe "#new" do

    context "while signed out" do

      it "redirects to welcome page" do
        get :new
        response.should redirect_to root_path
        flash[:alert].should eql "You need to be signed in to create ToDo Lists."
      end
    end

    context "while signed in" do

      before(:each) do
        @user = users(:user_1)
        sign_in @user
      end

      it "returns a page" do
        get :new
        response.should be_success
      end

      it "has a new list as a variable" do

        get :new
        assigns["list"].should_not be_valid
        assigns["list"].should_not be_nil
      end
    end
  end

  describe "#create" do

    context "while signed out" do

      it "redirects to welcome page" do
        post :create
        response.should redirect_to root_path
        flash[:alert].should eql "You need to sign in to create Lists."
      end
    end

    context "while signed in" do

      before(:each) do
        @user = users(:user_1)
        sign_in @user
      end

      it "creates an object and redirects to the new list page if fed a valid list" do
        
        post :create, list: { name: "new gazebo" }
        list = List.find_by name: "new gazebo"

        list.should be_valid
        list.user.should eql @user
        response.should redirect_to list_path(list)
        flash[:notice].should eql "List saved."
      end

      it "renders the 'new' template and has errors if fed an invalid object" do
        
        count = List.count
        post :create, list: { name: "" }

        count.should eql List.count
        assigns["list"].should_not be_nil
        assigns["list"].errors.should_not be_nil
        assigns["list"].errors["name"].first.should eql "can't be blank"
        response.should render_template("lists/new")
        flash[:error].should eql "There was an error saving the list. Please try again."
      end
    end
  end

  describe "#edit" do

    before(:each) do
      @user = users(:user_1)
      @list = @user.lists.first
    end

    context "while signed out" do

      it "redirects to welcome page" do

        get :edit, id: @list
        response.should redirect_to root_path
        flash[:alert].should eql "Sign in to edit Lists."
      end
    end

    context "while signed in" do

      before(:each) do
        sign_in @user
      end

      it "returns a page" do

        get :edit, id: @list
        response.should be_success
      end

      it "has the right list as a variable" do

        get :edit, id: @list
        assigns["list"].should eql @list
      end

      it "redirects to welcome page if I request a list that's not mine" do

        user2 = users(:user_2)
        list2 = user2.lists.first

        get :edit, id: list2

        response.should redirect_to root_path
        flash[:alert].should eql "List not found."
      end
    end
  end
end
