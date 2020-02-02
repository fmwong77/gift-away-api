class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  # GET /posts
  def index
    @posts = Post.all
    render json: @posts.with_attached_image
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create
    # puts post_params[:title]
    #   puts post_params[:description]
    #   puts post_params[:latitude]
    #   puts post_params[:longitude]
    #   puts post_params[:user_id]
    #   puts post_params[:category_id]
    #   puts post_params[:images]
      
    @post = Post.new(post_params)
    if @post.save
      render json: @post#, status: :created, location: @post
    else
      render json: {message: "Error"} #@post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    byebug
    # post = Post.find(params[:id])
    @post.update(image: params[:image])
    image_url = rails_blob_path(@post.image)
    # if @post.update(params)
      render json: {post: @post, image_url: image_url}
    # else
    #   render json: {message: "Error"} #@post.errors, status: :unprocessable_entity
    # end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:title, :description, :latitude, :longitude, :user_id, :category_id, :image)
    end
end
