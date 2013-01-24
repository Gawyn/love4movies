Love4movies::Application.routes.draw do
  devise_scope :user do
    match "/users/auth/:provider/callback" => "users#login"
  end

  devise_for :users

  resources :movies, :only => [:show, :index]
  resources :ratings, :only => :create
  resources :comments, :only => :create

  root :to => 'home#index'
end
