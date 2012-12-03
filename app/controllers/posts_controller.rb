class PostsController < ApplicationController

  def show
    @post = current_site.posts.find(params[:id])
  end

  def create
	  @post = current_user.posts.new(params[:post])
	  @post.page = Page.find(params[:page_id])
	  @site = @post.page.site 

	  if @post.save
	    flash[:notice] = 'Post was successfully created.'
	    redirect_to( page_url(@post.page, subdomain: @site.subdomain) )
	  else
	    flash[:error] = 'Post could not be created.'
	    render :template => 'sites/show'
	  end
	end

	def edit 
		@post = Post.find(params[:id])
		@page = @post.page
		@site = @post.page.site
	end

	def update
		@post = Post.find(params[:id])

		respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
	end

	def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to page_url(@post.page, subdomain: @post.page.site.subdomain), notice: "Post deleted." }
      format.json { head :no_content }
    end
  end

end
