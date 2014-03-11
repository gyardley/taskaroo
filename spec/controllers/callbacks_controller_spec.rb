# callbacks_controller_spec

require 'spec_helper'

describe CallbacksController do

  describe "#twitter" do

    it "redirects to lists page if sign-in successful" do
      request.env["devise.mapping"] = Devise.mappings[:user] 
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
      
      get :twitter
      response.should redirect_to lists_path
    end
  end
end