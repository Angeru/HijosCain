class SessionsController < ApplicationController
  skip_before_action :authenticate, only: [:new, :create]

  def new
  end

  def create
    user = Member.find_by(user_name: params[:username])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:last_active_at] = Time.now.to_i
      flash[:success] = "Login successful!"
      redirect_to root_path
    else
      flash[:error] = "Invalid email or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Logged out successfully!"
    redirect_to root_path
  end
end