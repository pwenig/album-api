class AlbumsController < ApplicationController

  include SortCollection

  before_action :get_album, only: [:show, :update, :destroy]

  def index 
    @albums = Album.all
    render json: @albums, status: 200
  end

  def show
    render json: @album, status: 200
  end

  def create
    @artist = Artist.find(params[:artist_id])
    if @artist
      @album = @artist.albums.create!(permitted_params)
      render json: @album, status: 201
    else
      render status: 404
    end
  end

  def update
    @album.update(permitted_params)
    head :no_content
  end 

  def destroy
    @album.destroy
    head :no_content
  end

  # Returns a sorted object of genres and the number of albums in each genre.
  def genre_ranking
    ranked_albums = SortCollection.sort_albums('genre')
    render json: ranked_albums.sort_by(&:last).reverse.to_h, status: 200
  end 

  # Returns a sorted object of the top five years with the most number of albums.
  def year_ranking
    ranked_albums = SortCollection.sort_albums('year')
    render json: ranked_albums.sort_by(&:last).reverse[0...5].to_h, status: 200
  end 

  private

  def get_album
    @album = Album.find(params[:id])
  end

  def permitted_params
    params.permit(:album, :genre, :year)
  end

end
