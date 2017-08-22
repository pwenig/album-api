class ArtistsController < ApplicationController

  before_action :find_artist, only:[:show, :update, :destroy]

  def index
    @artists = Artist.all 
    render json: @artists, status: 200
  end

  def show
    # Include the artist album's
   render :json => @artist, :include => :albums, status: 200 
  end 

  def create
    @artist = Artist.create(permitted_params)
    if @artist.save
      render json: @artist, status: 201
    else
      render json: {errors: 'Validation error', status: 422}, status: 422
    end
  end

  def update
    @artist.update(permitted_params)
    # return response only
    head :no_content
  end

  def destroy 
    @artist.destroy
    # return response only
    head :no_content
  end 


  private

  def find_artist
    @artist = Artist.find(params[:id])
  end

  def permitted_params
    params.permit(:name)
  end 


end
