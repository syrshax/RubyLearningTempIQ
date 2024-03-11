class BlogPostsController < ApplicationController

    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_blog_posts, except: [:index, :new, :create]
    def index
        @blog_posts = BlogPost.all
        @blog_posts_banner = BlogPost.all
    end

    def show
    rescue ActiveRecord::RecordNotFound
        redirect_to root_path
    end

    def new
        @blog_post = BlogPost.new
    end

    def create
        @blog_post = BlogPost.new(blog_posts_params)
        if @blog_post.save
            redirect_to @blog_post
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
    rescue ActiveRecord::RecordNotFound
        redirect_to root_path
    end




    def update 
        if @blog_post.update(blog_posts_params)
            redirect_to @blog_post
        else
            render :edit, status: :unprocessable_entity
        end
    end
    
    def destroy
        @blog_post = BlogPost.find(params[:id])
        @blog_post.destroy
        redirect_to root_path
    end


    private
    def blog_posts_params
        params.require(:blog_post).permit(:title, :body)
    end

    def set_blog_posts
        @blog_post = BlogPost.find(params[:id])
        rescue ActiveRecord::RecordNotFound
            redirect_to root_path
    end


end
