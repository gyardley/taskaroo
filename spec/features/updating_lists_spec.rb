# spec/features/updating_lists_spec.rb

require 'spec_helper'

describe "integration tests for creating lists" do

  before(:each) do

    @user = users(:user_1)
    @list = @user.lists.first

    visit root_path
    click_link "Sign in with Twitter"
    click_link "#{@list.name}"
    click_link "Edit"
  end

  it "updates the list if input is valid" do

    page.should have_content("Edit List")
    page.should have_content("List name")
    find_field('List name').value.should eq @list.name
    page.should have_button("Update")
    fill_in "List name", with: "edited list name"
    # click_button "Update"
    
    # page.should have_content("edited list name")
    # page.should have_content("List saved.")
    # page.should_not have_content("List name")
  end

  # it "doesn't update the list if input is invalid" do
    
  #   click_button "Create"
    
  #   page.should have_content("can't be blank")
  #   page.should_not have_content("List saved.")
  #   page.should have_content("New List")
  #   page.should have_content("List name")
  # end

end