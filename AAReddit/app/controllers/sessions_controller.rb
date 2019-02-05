class SessionsController < ApplicationController
  before_action :require_logout, except: :destroy
  before_action :require_login, only: :destroy
  
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if @user
      login!(@user)
      redirect_to subs_url #Check this later
    else
      flash.now[:errors] = ["Invalid credentials!"]
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

end
