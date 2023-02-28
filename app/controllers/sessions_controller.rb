class SessionsController < ApplicationController
  def create
    @user = User.find_by_username(params[:username])

    if (@user && @user.authenticate(params[:password]))
      redirect_to new_role_request_path
    end
  end
end
