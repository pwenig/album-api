class AlbumsController < ApplicationController

  before_action :get_artist
  before_action :get_album, only: [:show, :update, :destroy]

  def index 
    render json: @albums, status: 200
  end

  def show
    render json: @album, status: 200
  end

  def create
    @album = @artist.albums.create!(permitted_params)
    render json: @album, status: 201
  end

  def update
    @album.update(permitted_params)
    head :no_content
  end 

  def destroy
    @album.destroy
    head :no_content
  end 


  private

  def get_artist
    @artist = Artist.find(params[:artist_id])
    if @artist
      @albums = @artist.albums
    else
      @albums = []
    end
  end 
  
  def get_album
    @album = Album.find(params[:id])
  end

  def permitted_params
    params.permit(:album, :genre, :year)
  end


end
