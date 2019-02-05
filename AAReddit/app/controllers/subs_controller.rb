class SubsController < ApplicationController
  before_action :require_login
  before_action :is_sub_owner?, only: :edit

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end
  
  def index
    @subs = Sub.all
    render :index
  end 
  
  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.moderator_id == current_user.id && @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash[:errors] = ["You cannot edit this sub"]
      redirect_to sub_url(@sub)
    end
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
  
  def is_sub_owner?
    @sub = Sub.find(params[:id])
    flash[:errors] = ["You cannot edit this sub"]
    redirect_to sub_url(@sub) unless current_user.id == @sub.moderator_id
  end
end
