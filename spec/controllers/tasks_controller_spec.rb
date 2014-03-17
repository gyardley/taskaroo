require 'spec_helper'

describe TasksController do

  describe "#index" do

    context "while signed out" do

      it "redirects to welcome page" do
        get :index
        response.should redirect_to root_path
        flash[:alert].should eql "You need to be signed in to view Tasks."
      end
    end

    context "while signed in" do

      before(:each) do
        @user = users(:user_1)
        sign_in @user
      end

      it "returns a page" do
        get :index
        response.should be_success
      end

      it "contains all of the user's tasks" do
        get :index
        assigns["tasks"].should =~ lists(:list_1).tasks
      end

      # esdy: I think I can get rid of this test.
      it "doesn't show other users' tasks" do
        new_user = User.create(uid: '2468', provider: 'twitter', nickname: 'plizzle')
        sign_in new_user

        get :index
        assigns["tasks"].count.should eql 0
      end
    end
  end
end
