# /spec/features/sign_in_spec.rb

require 'spec_helper'

describe "integration tests for sign in" do

  it "should show link to 'Sign in to Twitter' on the homepage" do
    visit root_path
    expect(page).to have_content "Sign in to Twitter"
  end

  it "should show 'Signed in' when 'Sign in to Twitter' link is clicked" do
    visit root_path
    click_link "Sign in to Twitter"
    expect(page).to have_content "Signed in"
    expect(page).to have_no_content "Sign in to Twitter"
  end
  
end