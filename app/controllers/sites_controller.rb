class SitesController < ApplicationController 
  before_filter :authenticate_user!, except: :show 

  def add_residents

  end
  def add_managers

  end
  # GET /sites
  # GET /sites.json
  def index
    @sites = Site.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sites }
    end
  end

  # GET /sites/new
  # GET /sites/new.json
  def new
    @site = Site.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @site }
    end
  end

  # GET /sites/1/edit
  def edit
    @site = Site.find_by_subdomain!(request.subdomain)
    @page = Page.new
    @page.site = @site

  end

  # POST /sites
  # POST /sites.json
  # TODO: maybe creating a new site should redirect back to dashboard instead?
  def create
    @site = current_user.sites.build(params[:site])

    respond_to do |format|
      if @site.save
        format.html { redirect_to root_url(subdomain: @site.subdomain), notice: 'Site was successfully created.' }
        format.json { render json: @site, status: :created, location: @site }
      else
        format.html { render action: "new" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sites/1
  # PUT /sites/1.json
  def update
    @site = Site.find(params[:id])

    respond_to do |format|
      if @site.update_attributes(params[:site])
        if params[:site][:manager_ids]
          format.html { redirect_to sites_url(subdomain: "www"), notice: 'Site was successfully updated.' }
        else
         format.html { redirect_to edit_site_url(subdomain: @site.subdomain), notice: 'Site was successfully updated.' }
        end
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @site = Site.find(params[:id])
    @site.destroy

    respond_to do |format|
      format.html { redirect_to sites_url }
      format.json { head :no_content }
    end
  end

end
