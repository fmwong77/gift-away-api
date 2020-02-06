class Api::V1::CommentsController < ApplicationController
  before_action :set_comment, only: [ :show, :update, :destroy]
  skip_before_action :authorized, only: [:index]

  # GET /comments
  def index
    # byebug
    @comments = Comment.all.where("post_id=#{params[:post_id]}")

    render json: @comments
  end

  # GET /comments/1
  def show
    byebug
    # @comments = Comment.all.find_by(post_id: params[:post_id])

    render json: @comment
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
# byebug
    if @comment.save
      @comments = Comment.all.where("post_id=#{params[:post_id]}")
      # byebug
      render json: @comment, status: 200
    else
      render json: {message: "Error"} #@comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:content, :user_id, :post_id)
    end
end
