# spec/features/destroying_lists_spec.rb

require 'spec_helper'

describe "integration tests for destroying lists" do

  before(:each) do
    @user = users(:user_1)
    @list = @user.lists.first
    visit root_path
    click_link "Sign in with Twitter"
  end

  it "destroys a list if input is valid" do

    name = @list.name
    click_link "#{@list.name}"
    click_link "Delete"
    
    page.should have_content("All ToDo Lists")
    page.should have_content("#{name} was deleted successfully.")
    page.should_not have_link("Edit")
    page.should_not have_link("Delete")
  end
end
