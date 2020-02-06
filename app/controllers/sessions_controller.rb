class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username]).try(:authenticate, params[:password])
    if user
      session[:user_id] = user.id

      render json: {user: user}
    else
      render json: {status: 401}
    end
  end

  def destroy
    reset_session
      render json: {status: 200}
  end
end