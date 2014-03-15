# spec/features/creating_lists_spec.rb

require 'spec_helper'

describe "integration tests for creating lists" do

  before(:each) do

    @user = users(:user_1)

    visit root_path
    click_link "Sign in with Twitter"
    visit new_list_path
  end

  it "creates a list if input is valid" do

    page.should have_content("New List")
    page.should have_content("List name")
    page.should have_button("Create")
    fill_in "List name", with: "gazebo"
    click_button "Create"
    
    page.should have_content("gazebo")
    page.should have_content("List saved.")
    page.should_not have_content("List name")
  end

  it "doesn't create a list if input is invalid" do
    
    click_button "Create"
    
    page.should have_content("can't be blank")
    page.should_not have_content("List saved.")
    page.should have_content("New List")
    page.should have_content("List name")
  end

end