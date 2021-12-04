Rails.application.routes.draw do
  devise_for :users

  resources :users,only: [:show,:index,:edit,:update,:destroy] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'

  end

  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :groups do
    get "join" => "groups#join"
    get "leave" => "groups#leave"
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end


  root 'homes#top'
  get 'home/about' => 'homes#about'
  get 'search' => 'searches#search'

end