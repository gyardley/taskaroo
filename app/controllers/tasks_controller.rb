class TasksController < ApplicationController

  before_filter :authenticate_user

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
      render "new"
    end
  end

  private

  # def get_list
  #   @list = current_user.lists.find(params[:id])
  # end

  def editable_task_params
    params.require(:task).permit(:description, :list_id)
  end
end
