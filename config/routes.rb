Rails.application.routes.draw do

  resources :artists do
    resources :albums
  end 

  get 'genre', to: 'albums#genre'

end
