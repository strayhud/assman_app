class AlbumsController < ApplicationController
  attr_accessor :current_photo
  
  def initialize
    @page_icon = "bbutton-photos.jpg"
    @current_photo=1
  end
  
  def index
    @page_title = "Photos"
    @albums = Album.all
  end
  
  def show
    @album = Album.find(params[:id], :include => :assets)
    @page_title = "Photos - " + @album.name;    
  end
  
  def new
    @album = Album.new
  end
  
  def create
    @album = Album.new(params[:album])
    if @album.save
      flash[:notice] = "Successfully created album."
      redirect_to @album
    else
      render :action => 'new'
    end
  end
  
  def edit
    @album = Album.find(params[:id])
  end
  
  def update
    @album = Album.find(params[:id])
    if @album.update_attributes(params[:album])
      flash[:notice] = "Successfully updated album."
      redirect_to @album
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    flash[:notice] = "Successfully destroyed album."
    redirect_to albums_url
  end
end
