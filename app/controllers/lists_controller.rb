class ListsController < ApplicationController

  def index
    # @topics = Topic.all
    # @topics = Topic.page(params[:page]).per(10)
    # @lists = List.visible_to(current_user).page(params[:page]).per(10)

    # redirect_to(root_path, :alert => "You need to be signed in to view ToDo Lists.") unless user_signed_in?
     

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

    if current_user
      @list = current_user.lists.build(new_list_params)
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

  end

  def update

  end

  def destroy

  end

  private

  def new_list_params
    # Params has to have a 'list' param, or it should return an error.
    params.require(:list).permit(:name)
  end
end
