class SessionsController < ApplicationController

  def new
  end

  def create
    if user = User.authenticate_with_credentials(params[:session][:email],
                                                params[:session][:password])
      session[:user_id] = user.id
      redirect_to products_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
  
end
