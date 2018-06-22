Portrait::Application.routes.draw do
  resources :customers, except: [:new, :edit]
  resources :users, except: [:new, :edit]
  resources :sites, only: [:index, :create]

  root to: 'home#index'
end
