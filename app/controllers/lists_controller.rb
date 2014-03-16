class ListsController < ApplicationController

  def index
    if current_user
      # @lists = List.where(user_id: current_user.id)
      @lists = current_user.lists
    else
      redirect_to(root_path, :alert => "You need to be signed in to view ToDo Lists.")
    end
  end

  def new

    if current_user
      @list = List.new
    else
      redirect_to(root_path, :alert => "You need to be signed in to create ToDo Lists.")
    end    
  end

  def create
    logger.info "In create method"
    if current_user
      @list = current_user.lists.build(editable_list_params)
      if @list.save
        redirect_to(list_path(@list), :notice => "List saved.")
      else
        flash[:error] = "There was an error saving the list. Please try again."
        render "new"
      end
    else
      redirect_to(root_path, :alert => "You need to sign in to create Lists.")
    end
  end

  def show
    if current_user
      @list = current_user.lists.find(params[:id])
    else
      redirect_to(root_path, :alert => "You need to be signed in to view ToDo Lists.")
    end

  rescue ActiveRecord::RecordNotFound

    redirect_to(root_path, :alert => "List not found.")
  end

  def edit

    if current_user
      @list = current_user.lists.find(params[:id])
      # @list = List.find(params[:id])    # esdy: Why doesn't this work?
    else
      redirect_to(root_path, :alert => "Sign in to edit Lists.")
    end

  rescue ActiveRecord::RecordNotFound

    redirect_to(root_path, :alert => "List not found.") 
  end

  def update
    logger.info "In update method"
    @list = List.find(params[:id])

    if current_user
      if @list.update_attributes(editable_list_params)
        redirect_to(list_path(@list), :notice => "List saved.")
      else
        flash[:error] = "There was an error saving the list. Please try again."
        render "edit"
      end
    else
      redirect_to(root_path, :alert => "Sign in to edit Lists.")
    end
  end

  def destroy
    
    if current_user
      # @list = List.find(params[:id])
      @list = current_user.lists.find(params[:id])
      name = @list.name
      if @list.destroy
        flash[:notice] = "#{name} was deleted successfully."
        redirect_to lists_path
      else
        flash[:error] = "There was an error deleting the list."
        redirect_to lists_path
      end
    else
      redirect_to(root_path, :alert => "Sign in to delete Lists.")
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
end
