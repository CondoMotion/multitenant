class PagesController < ApplicationController
  before_filter :authenticate_user!, except: :show

  def sort
    params[:page].each_with_index do |id, index|
      Page.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    if params[:id]
      @page = current_site.pages.find(params[:id])
    else
      @page = current_site.pages.first()
    end
    @post = Post.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = current_site.pages.find(params[:id])
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = current_site.pages.new(params[:page])
    @site = @page.site

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.json

  def update
  @page = current_site.pages.find(params[:id])
  @site = @page.site

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to(@page, :notice => 'Page was successfully updated.') }
        format.json { respond_with_bip(@page) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@page) }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = current_site.pages.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to edit_site_url }
      format.json { head :no_content }
    end
  end
end
