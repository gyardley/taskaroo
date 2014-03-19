# spec/features/viewing_tasks_spec.rb

require 'spec_helper'

describe "integration tests for viewing lists" do

  before(:each) do
    @user = users(:user_1)
    @list = @user.lists.first
    @tasks = @list.tasks

    visit root_path
    click_link "Sign in with Twitter"
  end

  it "should show link to see all tasks on the homepage" do
    expect(page).to have_link "Tasks"
  end

  it "should show the user's tasks when they click the 'Tasks' link" do
    click_link "Tasks"

    page.should have_content(@tasks.first.description)
  end

  it "should show an edit and delete button for each Task" do
    click_link "Tasks"

    find("tr#row-#{@tasks.first.id}") do
      should have_link("Edit", { href: "/tasks/#{@tasks.first.id}/edit" } )
      should have_link("Delete", { href: "/tasks/#{@tasks.first.id}" } )
    end
  end
end