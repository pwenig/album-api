require 'rails_helper'

RSpec.describe 'Ablums API', type: :request do

  # Create an artist
  let!(:artists) { create_list(:artist, 1) }
  # Set an artist_id 
  let(:artist_id) { artists.first.id }

  # Create a list of albums
  let!(:albums) {create_list(:album, 3, artist_id: artist_id) }
  let(:album_id) { albums.first.id }

  describe 'GET /artists/:artist_id/albums' do

    before { get "/artists/#{artist_id}/albums"}

    it 'returns all of the artist albums' do
      expect(json.length).to eq(3)

    end 

  end 

  describe 'GET /artists/:artist_id/albums/:id' do

    before { get "/artists/#{artist_id}/albums/#{album_id}" }

    it 'returns the album' do
      expect( json ).not_to be_empty
    end 

  end 

  describe 'POST /artists/:artist_id/albums' do

    # Set the params
    let(:create_params) { {album: 'Born in the USA', genre: 'Rock', year: '1984'} }

    before { post "/artists/#{artist_id}/albums", params: create_params }

    it 'creates an album' do
      expect(json['album']).to eq('Born in the USA')
    end 

  end 

  describe 'PUT /artists/:artist_id/albums/:id' do

    # Set the updated params
    let(:updated_params) { {album: 'Nebrasks' } }

    before { put "/artists/#{artist_id}/albums/#{album_id}" }

    it 'returns a successful response code' do
      expect(response).to have_http_status(204)
    end 

  end 

  describe 'DELETE /artists/:artist_id/albums/:id' do

    before { delete "/artists/#{artist_id}/albums/#{album_id}" }

    it 'returns a successful response code' do
      expect(response).to have_http_status(204)
    end 

  end 

end

