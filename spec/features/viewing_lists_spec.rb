# /spec/features/viewing_lists_spec.rb

require 'spec_helper'

describe "integration tests for viewing lists" do

  before(:each) do
    @user = users(:user_1)
    @list = @user.lists.first
    @tasks = @list.tasks
  end

  it "should show link to see all lists on the homepage" do
    visit root_path
    sign_in_with_twitter
    
    expect(page).to have_link "Lists"
  end

  it "shows the user's lists" do
    visit root_path
    sign_in_with_twitter

    page.should have_content(@list.name)
  end

  it "shows the individual List page and its tasks when the user clicks the name of that List" do
    visit root_path
    sign_in_with_twitter
    click_link "#{@list.name}"

    page.should have_content(@list.name)
    page.should have_content(@tasks.first.description)
    page.should have_link("Edit")
    page.should have_link("Delete")
  end
end
