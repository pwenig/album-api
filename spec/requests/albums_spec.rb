require 'rails_helper'

RSpec.describe 'Albums API', type: :request do

  # Create an artist
  let!(:artists) { create_list(:artist, 1) }
  # Set an artist_id 
  let(:artist_id) { artists.first.id }

  # Create a list of albums
  let!(:albums) {create_list(:album, 3, artist_id: artist_id) }
  let(:album_id) { albums.first.id }

  describe 'GET /albums' do

    before { get '/albums'}

    it 'returns all of the albums' do
      expect(json).to_not be_empty
      expect(json.length).to eq(3)
    end 

  end 


  describe 'GET /artists/:artist_id' do

    before { get "/artists/#{artist_id}"}

    it 'returns all of the artist albums' do
      expect( json['albums'].length).to eq(3)
      expect(json['albums'][0]['artist_id']).to eq(artist_id)

    end 

  end 

  describe 'GET /albums/:id' do

    before { get "/albums/#{album_id}" }

    it 'returns the album' do
      expect(json).not_to be_empty
      expect(json['id']).to eq(album_id)
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

  describe 'PUT /albums/:id' do

    # Set the updated params
    let(:updated_params) { {album: 'Nebraska' } }

    before { put "/albums/#{album_id}" }

    it 'returns a successful response code' do
      expect(response).to have_http_status(204)
    end 

  end 

  describe 'DELETE /albums/:id' do

    before { delete "/albums/#{album_id}" }
    it 'returns a successful response code' do
      expect(response).to have_http_status(204)
    end 

  end 

  describe 'POST /albums/genre_ranking' do

    before { post "/albums/genre_ranking"  }

    it 'returns a successful response code' do
      expect(json).to_not be_empty
      expect(json['Rock']).to eq(3)
    end 

  end 

  describe 'POST /albums/year_ranking' do
    
    before { post "/albums/year_ranking"  }

    it 'returns a successful response code' do
      expect(json).to_not be_empty
      expect(json['1975']).to eq(3)
    end 

  end 


end

