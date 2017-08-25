Rails.application.routes.draw do

  resources :artists do
    resources :albums, only: [:create ]
  end 
  
  resources :albums, only: [:index, :update, :destroy, :show] do
    collection do
      get 'genre_ranking'
      get 'year_ranking'
    end 
      
  end

end
