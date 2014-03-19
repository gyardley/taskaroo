# spec/features/creating_tasks_spec.rb

require 'spec_helper'

describe "integration tests for creating Tasks" do

  before(:each) do

    @user = users(:user_1)
    @list = @user.lists.first

    visit root_path
    click_link "Sign in with Twitter"
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

  it "creates a Task and returns to the List page if accessed from List page and input is valid" do
    visit lists_path
    click_link "#{@list.name}"
    click_link "New Task"

    page.should have_content("New Task")
    # page.should have_content("Task description")
    # find_field('What are you going to do?').value.should eq 'Task description'
    page.should have_field("What are you going to do?")
    # page.should have_select("#{@list.name}")        # List should be pre-selected
    page.should have_button("Create")

    fill_in "Task description", with: "Here is a new task"
    click_button "Create"

    page.should have_content("Here is a new task")
    page.should have_content("Task saved.")
    page.should have_content("#{@list.name}")
    page.should_not have_content("Task description")
  end

  # it "creates a list if input is valid" do

  #   page.should have_content("New List")
  #   page.should have_content("List name")
  #   page.should have_button("Create")
  #   fill_in "List name", with: "gazebo"
  #   click_button "Create"
    
  #   page.should have_content("gazebo")
  #   page.should have_content("List saved.")
  #   page.should_not have_content("List name")
  # end

  # it "doesn't create a list if input is invalid" do
    
  #   click_button "Create"
    
  #   page.should have_content("can't be blank")
  #   page.should_not have_content("List saved.")
  #   page.should have_content("New List")
  #   page.should have_content("List name")
  # end

end