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

      it "contains at least one of the user's lists" do
        new_list = @user.lists.first

        get :index
        assigns["lists"].first.should eql new_list
      end

      it "contains multiple of the user's lists if present" do
        new_list = List.create(name: "gazebo2", user: @user)

        get :index
        assigns["lists"].count.should eql 2
      end

      # esdy: I think I can get rid of this test.
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
        @tasks = @list.tasks
      end

      it "returns a page" do
        get :show, id: @list
        response.should be_success
      end

      it "has the right list and tasks as a variables" do

        get :show, id: @list
        assigns["list"].should eql @list
        assigns["tasks"].should =~ @tasks
      end

      it "redirects to lists page if I request a list that's not mine" do
        user2 = users(:user_2)
        list2 = user2.lists.first

        get :show, id: list2

        response.should redirect_to lists_path
        flash[:error].should eql "List not found."
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

      it "creates an object and redirects to the newly created list page if fed a valid list" do
        
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

      it "redirects to lists page if I request a list that's not mine" do

        user2 = users(:user_2)
        list2 = user2.lists.first

        get :edit, id: list2

        response.should redirect_to lists_path
        flash[:error].should eql "List not found."
      end
    end
  end

  describe "#update" do

    before(:each) do
      @user = users(:user_1)
      @list = @user.lists.first
    end

    context "while signed out" do

      it "redirects to welcome page" do
        put :update, id: @list
        response.should redirect_to root_path
        flash[:alert].should eql "Sign in to edit Lists."
      end
    end

    context "while signed in" do

      before(:each) do
        sign_in @user
      end

      it "updates the object and redirects to the list page if fed a valid list" do
        
        count = List.count

        put :update, id: @list, list: { name: "updated gazebo" }
        list = List.find @list.id

        list.name.should eql "updated gazebo"
        count.should eql List.count
        list.should be_valid
        list.user.should eql @user
        response.should redirect_to list_path(list)
        flash[:notice].should eql "List saved."
      end

      it "renders the 'edit' template and has errors if fed an invalid object" do
        
        count = List.count

        put :update, id: @list, list: { name: "" }
        list = List.find @list.id

        list.name.should eql "gazebo"
        count.should eql List.count
        assigns["list"].should_not be_nil
        assigns["list"].errors.should_not be_nil
        assigns["list"].errors["name"].first.should eql "can't be blank"
        response.should render_template("lists/edit")
        flash[:error].should eql "There was an error saving the list. Please try again."
      end
    end
  end

  describe "#destroy" do

    before(:each) do
      @user = users(:user_1)
      @list = @user.lists.first
    end

    context "while signed out" do

      it "redirects to welcome page" do
        delete :destroy, id: @list
        response.should redirect_to root_path
        flash[:alert].should eql "Sign in to delete Lists."
      end
    end

    context "while signed in" do

      before(:each) do
        sign_in @user
      end

      it "deletes the object and redirects to the lists page if deleting a valid list" do
        count = List.count
        name = @list.name
        delete :destroy, id: @list

        list = List.find_by id: @list.id
        
        # expect{ List.find @list.id }.to raise_error(ActiveRecord::RecordNotFound)

        list.should be_nil
        (count - 1).should eql List.count
        response.should redirect_to lists_path
        flash[:notice].should eql "#{name} was deleted successfully."
      end

      it "redirects to the welcome page if attempting to delete a list that doesn't exist" do

        count = List.count
        
        delete :destroy, id: 3004

        count.should eql List.count
        response.should redirect_to lists_path
        flash[:error].should eql "There was an error deleting the list."
      end

      it "redirects to the welcome page if I attempt to delete a list that's not mine" do
        list2 = lists(:list_2)
        count = List.count

        delete :destroy, id: list2.id

        count.should eql List.count
        response.should redirect_to lists_path
        flash[:error].should eql "There was an error deleting the list."
      end

    end

  end
end
