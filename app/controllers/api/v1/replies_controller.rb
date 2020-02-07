class Api::V1::RepliesController < ApplicationController
  before_action :set_reply, only: [:show, :update, :destroy]

  # GET /replies
  def index
    # byebug
    @replies = Reply.all.where("comment_id=#{params[:comment_id]}")

    render json: @replies
  end

  # GET /replies/1
  def show
    render json: @reply
  end

  # POST /replies
  def create
    @reply = Reply.new(reply_params)
# byebug
    if @reply.save
# byebug
      render json: @reply, status: 200 #@reply, status: :created, location: @reply
    else
      render json: {message: "Error"} #@reply.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /replies/1
  def update
    if @reply.update(reply_params)
      render json: @reply
    else
      render json: @reply.errors, status: :unprocessable_entity
    end
  end

  # DELETE /replies/1
  def destroy
    @reply.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reply
      @reply = Reply.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def reply_params
      params.require(:reply).permit(:content, :user_id, :comment_id)
    end
end
