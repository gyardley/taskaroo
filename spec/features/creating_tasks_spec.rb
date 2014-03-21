# spec/features/creating_tasks_spec.rb

require 'spec_helper'

describe "integration tests for creating Tasks" do

  before(:each) do

    @user = users(:user_1)
    @list = @user.lists.first

    visit root_path
    sign_in_with_twitter
  end

  # esdy: I want to add tests, and functionality, so that
  # when the user is not signed in, the 'new task' button
  # doesn't appear in the nav bar.

  it "shows a link to create a New Task in the nav bar" do
    page.should have_link("", { href: new_task_path } )
  end

  it "shows a link to create a New Task on the Tasks Index page" do
    visit tasks_path

    page.should have_link("New Task", { href: new_task_path } )
  end

  it "shows a link to create a New Task on each List page" do
    visit lists_path
    click_link "#{@list.name}"

    page.should have_link("New Task", { href: new_task_path } )
  end

  it "creates a Task and returns to the Tasks index page if input is valid" do
    visit new_task_path

    page.should have_content("New Task")
    page.should have_content("What are you going to do?")
    page.should have_field("Task description")
    page.should have_content("Put it on a list")
    page.should have_button("Create")

    fill_in "Task description", with: "Here is a new task"
    click_button "Create"

    page.should have_content("Here is a new task")
    page.should have_content("Task saved.")
    page.should have_content("All Tasks")
    page.should_not have_content("What are you going to do?")
  end

  # esdy: I should come back and implement this task if I want this feature.
  # it "loads form with current List pre-selected if accessed from List page" do
    # visit lists_path
    # click_link "#{@list.name}"
    # click_link "New Task"

    # page.should have_select("#{@list.name}")    # List should be pre-selected

    # click_button "Create"
    # page.should have_content("#{@list.name}")
  # end

  it "doesn't create a task if input is invalid" do
    visit new_task_path
    click_button "Create"
    
    page.should have_content("can't be blank")
    page.should_not have_content("Task saved.")
    page.should have_content("New Task")
    page.should have_field("Task description")
  end

end