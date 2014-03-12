# /spec/features/sign_in_spec.rb

require 'spec_helper'

describe "integration tests for sign in" do

  it "should show link to 'Sign in with Twitter' on the homepage" do
    visit root_path
    expect(page).to have_content "Sign in with Twitter"
  end

  it "should show 'Signed in' when 'Sign in with Twitter' link is clicked" do
    visit root_path
    click_link "Sign in with Twitter"
    expect(page).to have_content "Signed in"
    expect(page).to have_no_content "Sign in with Twitter"
  end

  it "should show 'Sign in with Twitter' when 'Sign out' link is clicked" do
    visit root_path
    click_link "Sign in with Twitter"
    click_link "Sign out"
    expect(page).to have_content "Sign in with Twitter"
    expect(page).to have_no_content "Signed in"
  end
  
end