# /spec/features/sign_in_spec.rb

require 'spec_helper'

describe "integration tests for sign in" do

  before(:each) do
    @user = User.create(uid: '12345', provider: 'twitter', nickname: 'eshizzle')
  end

  it "should show link to 'Sign in with Twitter' on the homepage" do
    visit root_path
    expect(page).to have_content "Sign in with Twitter"
  end

  it "should show 'Signed in as @nickname' when 'Sign in with Twitter' link is clicked" do
    visit root_path
    click_link "Sign in with Twitter"
    expect(page).to have_content "Signed in as @#{@user.nickname}"
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