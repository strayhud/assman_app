class AssetsController < ApplicationController
  def index
    @assets = Asset.all
  end
  
  def show
    @asset = Asset.find(params[:id], :include => :album)
    @total_assets = Asset.find(:all, :conditions => { :album_id => @asset.album.id})
  end
  
  def new
    @asset = Asset.new
  end
  
  def create
    newparams = coerce(params) 
    @asset = Asset.new(newparams[:asset])
    if @asset.save
      flash[:notice] = "Successfully created asset."
      respond_to do |format| 
        format.html {redirect_to @asset.album} 
        format.json { render :json => { :result => 'success', :asset => asset_path(@asset) } }
      end
    else
      render :action => 'new'
    end
  end
  
  def edit
    @asset = Asset.find(params[:id])
  end
  
  def update
    @asset = Asset.find(params[:id])
    if @asset.update_attributes(params[:asset])
      flash[:notice] = "Successfully updated asset."
      redirect_to @asset
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @asset = Asset.find(params[:id])
    @asset.destroy
    flash[:notice] = "Successfully destroyed asset."
    redirect_to assets_url
  end

private
  def coerce(params)
    if params[:asset].nil? 
      h = Hash.new 
      h[:asset] = Hash.new 
      h[:asset][:album_id] = params[:album_id] 
      h[:asset][:photo] = params[:Filedata] 
      h[:asset][:photo].content_type = MIME::Types.type_for(h[:asset][:photo].original_filename).to_s
      h
    else 
      params
    end 
  end

  
end
