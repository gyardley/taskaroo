# spec/features/destroying_tasks_spec.rb

require 'spec_helper'

describe "integration tests for destroying tasks" do

  before(:each) do
    @user = users(:user_1)
    @list = @user.lists.first
    @task = @list.tasks.first
    visit root_path
    click_link "Sign in with Twitter"
  end

  it "destroys a task if input is valid" do

    visit tasks_path
    page.should have_css("tr#row-#{@task.id}")
    find("tr#row-#{@task.id}").click_link("Delete", { href: "/tasks/#{@task.id}" })
        
    page.should have_content("All Tasks")
    page.should have_content("#{@task.description} was deleted successfully.")
    page.should_not have_css("tr#row-#{@task.id}")
  end
end
