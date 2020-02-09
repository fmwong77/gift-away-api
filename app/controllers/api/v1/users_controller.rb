gem 'bcrypt'

class Api::V1::UsersController < ApplicationController
  wrap_parameters :user, include: [:username, :password, :password_confirmation]
  skip_before_action :authorized, only: [:create]
  before_action :set_user, only: [:show, :update, :destroy, :update_password]

  # GET /users
  def index
    @users = User.find(params[:user_id])

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  def profile
    render json: { user: UserSerializer.new(current_user) }, status: :accepted
  end

  # POST /users
  def create
    @user = User.create(user_params)
    if @user.valid?
      @token = encode_token(user_id: @user.id)
      # byebug
      render json: { user: UserSerializer.new(@user), jwt: @token }, status: :created
    else
      render json: { error: 'failed to create user' }, status: :not_acceptable
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      # byebug
      render json: @user
    else
      render json: {message: "Error"} #@user.errors, status: :unprocessable_entity
    end
  end

  # def update_password
  # end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      puts "=============="
      puts params.inspect

      params.require(:user).permit(:username, :password, :password_confirmation)
    end
end
