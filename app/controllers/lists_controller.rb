class ListsController < ApplicationController

  # before_filter :authenticate_user!
  # before_filter :get_list, only: [:destory]

  before_filter :authenticate_user

  def index
    @lists = current_user.lists
  end

  def new
    @list = List.new 
  end

  def create
    @list = current_user.lists.build(editable_list_params)
    if @list.save
      redirect_to(list_path(@list), :notice => "List saved.")
    else
      flash[:error] = "There was an error saving the list. Please try again."
      render "new"
    end
  end

  def show
    @list = current_user.lists.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to(root_path, :alert => "List not found.")
  end

  def edit
    @list = current_user.lists.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to(root_path, :alert => "List not found.") 
  end

  def update
    @list = List.find(params[:id])

    if @list.update_attributes(editable_list_params)
      redirect_to(list_path(@list), :notice => "List saved.")
    else
      flash[:error] = "There was an error saving the list. Please try again."
      render "edit"
    end
  end

  def destroy
    @list = current_user.lists.find(params[:id])
    name = @list.name

    if @list.destroy
      flash[:notice] = "#{name} was deleted successfully."
      redirect_to lists_path
    else
      flash[:error] = "There was an error deleting the list."
      redirect_to lists_path
    end

  rescue ActiveRecord::RecordNotFound

    flash[:error] = "There was an error deleting the list."
    redirect_to lists_path
  end

  private

  def editable_list_params
    # Params has to have a 'list' param, or it should return an error.
    params.require(:list).permit(:name)
  end

  def authenticate_user
    unless current_user
      alert_message = case request.symbolized_path_parameters[:action]
      when "index"
        "You need to be signed in to view ToDo Lists."
      when "new"
        "You need to be signed in to create ToDo Lists."
      when "create"
        "You need to sign in to create Lists."
      when "show"
        "You need to be signed in to view ToDo Lists."
      when "edit"
        "Sign in to edit Lists."
      when "update"
        "Sign in to edit Lists."
      when "destroy"
        "Sign in to delete Lists."
      end

      redirect_to root_path, alert: alert_message
    end
  end
end
