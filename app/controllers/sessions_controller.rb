class SessionsController < ApplicationController
  def new
  end

  def create
    session_params = params.require(:sessions).permit!
    user = User.find_by(username: session_params[:username])

    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      flash["notice"] = "Logged in successfully!"
      redirect_to root_path
    else
      flash["error"] = "Username or password is not correct."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash["notice"] = "Logged out successfully!"
    redirect_to root_path
  end
end