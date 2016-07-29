class PostsController < ApplicationController
  before_action :find_post, except: %w[index new create]
  layout "survey"
  
  def index
    @posts = Post.all
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to edit_post_path(@post)
    else
      render 'new'
    end
  end
  
  def show;end
  
  def edit;end
  
  def update
    if @post.update_attributes(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end
  
  def destroy
    @post.destroy
    redirect_to :new  
  end
  
  protected
  
  def post_params
    params.require(:post).permit(:title, :video_attachment, :video_link, :photo_attachment, :photo_link, :description)
  end
  
  def find_post
    @post = Post.friendly.find(params[:id])
  end
  
  
end
