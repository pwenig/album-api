class AlbumsController < ApplicationController

  before_action :get_artist, except: [:genre]
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

  def genre
    albums = Album.all.sort_by { |k| k.genre}
    sorted_albums = []
    ranked = {}
    # New array of unique genre names
    all_genres = albums.map{|f| f.genre}.uniq
    # Iterate through the all_genres array and select the albums that match. Push them into a new array of sorted_albums
    all_genres.each do |g|
      sorted_albums.push(albums.select{ |a| a.genre == g })
    end
    # Iterate through the sorted_albums and create a hash of the genre and the length
    sorted_albums.each do |a|
      ranked[a.first.genre] = a.length
    end
    @genre_ranked = ranked.sort_by(&:last).reverse.to_h
    render json: @genre_ranked, status: 200
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
