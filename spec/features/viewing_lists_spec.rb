# /spec/features/viewing_lists_spec.rb

require 'spec_helper'

describe "integration tests for viewing lists" do

  before(:each) do
    @user = users(:user_1)
    @list = @user.lists.first
  end

  it "shows the user's lists" do
    visit root_path
    click_link "Sign in with Twitter"

    page.should have_content(@list.name)
  end

  it "shows the individual List page when the user clicks the name of that List" do
    visit root_path
    click_link "Sign in with Twitter"
    click_link "#{@list.name}"

    page.should have_content(@list.name)
    page.should have_link("Edit")
  end
end
