Rails.application.routes.draw do
  get 'messages/show'
  devise_for :users

  resources :users,only: [:show,:index,:edit,:update,:destroy] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    get 'search' => 'users#search'
  end

  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
    # get 'search' => 'books#search'
  end

  resources :groups do
    get "join" => "groups#join"
    get "leave" => "groups#leave"
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end


  root 'homes#top'
  get 'home/about' => 'homes#about'
  get 'home/search' => 'homes#search'
  get 'search' => 'searches#search'
  resources :messages, only: [:create]
  get 'message/:id' => 'messages#show', as: 'message'
  get 'books/search' => 'books#search'

end