# /spec/features/viewing_lists_spec.rb

require 'spec_helper'

describe "integration tests for viewing lists" do

  before(:each) do
    @user = User.create(uid: '12345', provider: 'twitter')
    @list = List.create(name: "gazebo", user: @user)
  end

  it "should show the user's lists" do
    visit root_path
    click_link "Sign in with Twitter"

    page.should have_content(@list.name)
  end

  it "should show the user's name" do
    visit root_path
    click_link "Sign in with Twitter"
    page.should have_content(@user.name)
  end
end
