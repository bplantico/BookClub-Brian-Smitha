Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "welcome#index"

  get    '/books',       to: 'books#index', as: 'books'
  post   '/books',       to: 'books#create'
  get    '/books/new',   to: 'books#new',   as: 'new_book'
  delete '/books/:id',   to: 'books#destroy'

  # resources :books, only: [ :index, :new, :create, :destroy]

  get  '/books/:id',                  to: 'books#show',     as: 'book'
  get  '/books/:book_id/reviews/new', to: 'reviews#new',    as: "new_book_review"
  post '/books/:book_id/reviews',     to: 'reviews#create', as: "book_reviews"

  # resources :books, only: [:show] do
  #   resources :reviews, only: [:new, :create]
  # end

  get    '/authors/:id', to: 'authors#show', as: 'author'
  delete '/authors/:id', to: 'authors#destroy'

  # resources :authors, only: [:show, :destroy]

  get    '/users/:id',                  to: 'users#show',      as: 'user'
  delete '/users/:user_id/reviews/:id', to: 'reviews#destroy', as: 'user_review'

  # resources :users, only: [:show] do
  #   resources :reviews, only: [:destroy]
  # end

end
