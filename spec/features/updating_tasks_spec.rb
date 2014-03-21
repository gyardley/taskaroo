# spec/features/updating_tasks_spec.rb

# spec/features/updating_lists_spec.rb

require 'spec_helper'

describe "integration tests for updating tasks" do

  before(:each) do

    @user = users(:user_1)
    @list = @user.lists.first
    @tasks = @list.tasks

    visit root_path
    sign_in_with_twitter
    visit tasks_path

    find("tr#row-#{@tasks.first.id}").click_link("Edit", { href: "/tasks/#{@tasks.first.id}/edit" })
  end

  it "updates the list if input is valid" do
    page.should have_content("Edit Task")
    page.should have_content("What are you going to do?")
    find_field('Task description').value.should eq @tasks.first.description
    page.should have_content("Put it on a list")
    page.should have_button("Update")

    fill_in "Task description", with: "edited task name"
    click_button "Update"
    
    page.should have_content("edited task name")
    page.should have_content("Task saved.")
    page.should have_content("All Tasks")
    page.should_not have_content("What are you going to do?")
  end

  it "doesn't update the task if input is invalid" do
    
    fill_in "Task description", with: ""
    click_button "Update"
    
    page.should have_content("can't be blank")
    page.should_not have_content("Task saved.")
    page.should have_content("Edit Task")
    page.should have_content("What are you going to do?")
  end

end