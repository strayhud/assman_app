class AlbumsController < ApplicationController
  attr_accessor :current_photo
  
  def initialize
    @current_photo=1
  end
  
  def index
    @albums = Album.all
  end
  
  def show
    @album = Album.find(params[:id], :include => :assets)
    @preview_photo = @album.assets.find(@current_photo)
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
  
  def get_photo
    direction=params[:arrowbutton]
    if (direction=='left') then
      @current_photo = @current_photo-1
    else
      @current_photo = @current_photo+1
    end
    puts "CURRENT_PHOTO=#{@current_photo}"
    @album = Album.find(params[:album_id], :include => :assets)
    @preview_photo = @album.assets.find(@current_photo)
    respond_to do |format|
      format.js
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
