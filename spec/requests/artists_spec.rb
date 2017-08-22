require 'rails_helper'

RSpec.describe 'Artists API', type: :request do

  # Create a list of artists
  let!(:artists) { create_list(:artist, 10) }
  # Set an artist_id 
  let(:artist_id) { artists.first.id }

  describe 'GET /artists' do
    
    before { get '/artists' }

    it 'returns artists' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end 

    it 'returns status code 200' do
      expect( response ).to have_http_status( 200 )
    end

  end

  describe 'GET /artists/:id' do

    before { get "/artists/#{ artist_id }" }

    it 'returns the artist' do
      expect( json ).not_to be_empty
      expect( json['id'] ).to eq( artist_id )
    end 

  end 

  describe 'POST /artists' do

    # Set the params
    let(:create_params) { {name: 'Bruce Springsteen'} }

    context 'when the params are correct' do
      before { post '/artists', params: create_params }
      
          it 'creates an artist' do
            expect(json['name']).to eq('Bruce Springsteen')
          end
      
          it 'returns a successful status code' do
            expect(response).to have_http_status(201)
          end 

    end 


    context 'when the params are wrong' do 
      before { post '/artists', params: {foo: 'Bruce Springsteen'} } 
      
        it 'returns a status code of 422 when the params are not correct' do
          expect(response).to have_http_status(422)  
        end 
    end 

end
    

  describe 'PUT /artists/' do

    # Set the updated params
    let(:updated_params) { {name: 'Mick Jagger'} }
    before { put "/artists/#{artist_id}", params: updated_params }

    it 'returns a successful code' do
      expect(response).to have_http_status(204)
    end 

  end 

  describe 'DELETE /artists/:id' do

    before {delete "/artists/#{artist_id}"}

    it 'returns a successful code' do
      expect(response).to have_http_status(204)
    end 

  end 


end

