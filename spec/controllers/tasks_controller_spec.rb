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
  end

end
