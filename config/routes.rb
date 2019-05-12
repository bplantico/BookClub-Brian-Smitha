Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "welcome#index"

  resources :reviews, only: [:show, :new, :create]

  resources :books, only: [:index, :show, :new, :create, :destroy]

  resources :authors, only: [:show]

end
