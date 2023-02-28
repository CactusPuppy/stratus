class SessionsController < ApplicationController
  def create
    @user = User.find_by_username(params[:username])

    if (@user && @user.authenticate(params[:password]))
      session[:user_id] = @user.id
      redirect_to role_requests_path
      return
    end

    flash[:alert] = "Incorrect username or password"
    redirect_to new_session_path
  end

  def destroy
    reset_session
    redirect_to new_session_path
  end
end
