# /spec/features/sign_in_spec.rb

require 'spec_helper'

describe "integration tests for sign in" do

  it "should show link to 'Sign in to Twitter' on the homepage" do
    visit root_path
    expect(page).to have_content "Sign in to Twitter"
  end
  
end