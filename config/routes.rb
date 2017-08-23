Rails.application.routes.draw do

  resources :artists do
    resources :albums, only: [:create ]
  end 

  resources :albums, only: [:index, :update, :destroy, :show]
  post '/albums/genre_ranking', to: 'albums#genre_ranking'

end
