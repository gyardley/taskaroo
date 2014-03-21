# /spec/features/sign_in_spec.rb

require 'spec_helper'

describe "integration tests for sign in" do

  before(:each) do
    @user = users(:user_1)
  end

  it "should show two links to 'Sign in with Twitter' on the homepage" do
    visit root_path
    expect(page).to have_content "Sign in with Twitter"
    find(".pull-right li").should have_link "Sign in with Twitter"
    find_link("")[:href].should eql user_omniauth_authorize_path(:twitter)
    find("#twitter-button")[:alt].should eql "Sign in with Twitter"
  end

  it "should show 'Signed in as @nickname' when 'Sign in with Twitter' link is clicked" do
    visit root_path
    sign_in_with_twitter
    expect(page).to have_content "Signed in as @#{@user.nickname}"
    expect(page).to have_no_content "Sign in with Twitter"
  end

  it "should show 'Signed in as @nickname' when 'Sign in with Twitter' image is clicked" do
    visit root_path
    click_link ""
    expect(page).to have_content "Signed in as @#{@user.nickname}"
    expect(page).to have_no_content "Sign in with Twitter"
  end

  it "should show 'Sign in with Twitter' when 'Sign out' link is clicked" do
    visit root_path
    sign_in_with_twitter
    click_link "Sign out"
    expect(page).to have_content "Sign in with Twitter"
    expect(page).to have_no_content "Signed in"
  end
  
end