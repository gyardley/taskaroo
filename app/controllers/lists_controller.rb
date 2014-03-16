class ListsController < ApplicationController

  before_filter :authenticate_user
  before_filter :get_list, only: [:show, :edit, :destroy]

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
  end

  def edit
    @list = current_user.lists.find(params[:id])
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

    if @list.destroy
      flash[:notice] = "#{@list.name} was deleted successfully."
      redirect_to lists_path
    else
      flash[:error] = "There was an error deleting the list."
      redirect_to lists_path
    end
  end

  private

  def get_list
      @list = current_user.lists.find(params[:id])
  end

  def editable_list_params
    # Params has to have a 'list' param, or it should return an error.
    params.require(:list).permit(:name)
  end
end
