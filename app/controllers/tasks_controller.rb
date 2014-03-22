class TasksController < ApplicationController

  before_filter :authenticate_user
  before_filter :get_task, only: [:edit, :destroy]
  # before_filter :get_tasks_from_twitter, only: [:index]
  # before_filter :get_task, only: [:show, :edit, :destroy]

  def index
    @tasks = current_user.tasks
  end

  def new
    @task = Task.new
    @lists = current_user.lists
  end

  def create
    @task = Task.new(editable_task_params)
    if @task.save
      redirect_to(tasks_path, :notice => "Task saved.")
    else
      flash[:error] = "There was an error saving the task. Please try again."
      @lists = current_user.lists
      render "new"
    end
  end

  def edit
    @lists = current_user.lists
  end

  def update
    @task = Task.find(params[:id])

    if @task.update_attributes(editable_task_params)
      redirect_to(tasks_path, :notice => "Task saved.")
    else
      flash[:error] = "There was an error saving the task. Please try again."
      @lists = current_user.lists
      render "edit"
    end
  end

  def destroy
    if @task.destroy
      flash[:notice] = "#{@task.description} was deleted successfully."
    # else
    #   flash[:error] = "There was an error deleting the list."
    end
    redirect_to tasks_path
  end

  private

  def get_task
    @task = current_user.tasks.find(params[:id])
  end

  def editable_task_params
    params.require(:task).permit(:description, :list_id)
  end
end
