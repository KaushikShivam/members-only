class SessionsController < ApplicationController
  def new

  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      log_in @user      
      redirect_to @user
    else
      flash.now[:error] = "Wrong email/password"
      render 'new'
    end
  end

  def destroy
    log_out current_user
    redirect_to login_path
  end
end
