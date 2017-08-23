class AlbumsController < ApplicationController

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
    ranked_albums = sorted_albums('genre')
    render json: ranked_albums.sort_by(&:last).reverse.to_h, status: 200
  end 

  # Returns a sorted object of the top five years with the most number of albums.
  def year_ranking
    ranked_albums = sorted_albums('year')
    render json: ranked_albums.sort_by(&:last).reverse[0...5].to_h, status: 200
    
  end 

  private

  def get_album
    @album = Album.find(params[:id])
  end

  def permitted_params
    params.permit(:album, :genre, :year)
  end

  # Sorts albums by attribute
  def sorted_albums(sort_attr)
    sorted_albums = []
    ranked = {}

    # Get all of the albums and sort them by the sort_attr
    albums = Album.all.sort_by { |k| k["#{sort_attr}"]}

    # Create an array of unique attribute keys
    attribute_keys = albums.map{ |f| f["#{sort_attr}"] }.uniq

    # Iterate through each of the attribute_keys and select the albums that match the attribute
    # Create an array of arrays
    attribute_keys.each do |y|
      sorted_albums.push(albums.select{ |a| a["#{sort_attr}"] == y })
    end 

    # Iterate through sorted_albums and create key/value pairs
    # of sort_attr and the number in each sort_attr (ie "1958"=>1, "Alternative"=>24 )
    sorted_albums.each do |a|
      ranked[a.first["#{sort_attr}"]] = a.length
    end
   
    ranked
  end 

end
