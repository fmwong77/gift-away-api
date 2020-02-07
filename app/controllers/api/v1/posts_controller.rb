class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]
  skip_before_action :authorized, only: [:index]

  # GET /posts
  def index
    # @posts = Post.all
    # if params[:category_id == 0]
    #   byebug
      params[:type] == "view" ? @posts = Post.all.where("user_id<>#{params[:user_id]}") : @posts = Post.all.where("user_id=#{params[:user_id]}")
    # else
    #   byebug
    #   params[:type] == "view" ? @posts = Post.all.where("user_id<>#{params[:user_id]} and category_id=#{params[:category_id]}") : @posts = Post.all.where("user_id=#{params[:user_id]} and category_id=#{params[:category_id]}")
    # end
    # byebug
    render json: @posts
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post#, status: :created, location: @post
    else
      render json: {message: "Error"} #@post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    # @post = Post.find(params[:id])
    if (@post && params[:info] != "post")
      # byebug
      @post.image.purge
      @post.update(image: params[:image])
      image_url = rails_blob_path(@post.image)
      render json: {post: @post, image_url: image_url}
    else
      # byebug
      @post.update(post_params)
      if @post.update(post_params)
        render json: @post
      else
        render json: {message: "Error"} #@post.errors, status: :unprocessable_entity
      end
    end
    
    # if @post.update(params)
      # render json: {post: @post, image_url: image_url}
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
      # byebug
      params.require(:post).permit(:title, :description, :latitude, :longitude, :user_id, :category_id, :image)
    end
end
