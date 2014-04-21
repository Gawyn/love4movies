require 'sidekiq/web'
Love4movies::Application.routes.draw do
  devise_scope :user do
    get "/users/auth/:provider/callback" => "users#login"
  end

  mount Sidekiq::Web => '/sidekiq'

  devise_for :users

  namespace :admin do
    resources :movies, only: :none do
      get :hidden, on: :collection
    end
    root to: "home#index"
  end

  resources :users, :only => :show do
    get :ranking
    resources :lists, :only => [:show, :index]
    resources :follows, only: :create
  end

  resources :persons, :only => :show

  resources :movies, :only => [:show, :index] do
    get :ranking, :on => :collection
  end
  resources :ratings, :only => [:create, :destroy] do
    resources :comments, only: :create
  end
  resources :reviews, :only => :create do
    resources :comments, only: :create
  end
  resources :lists, :only => :create do
    get :movie_search, :on => :member
  end
  resources :list_belongings, :only => :create do
    delete :destroy, :on => :collection
  end
  resources :badges, only: :index

  get "ranking" => "movies#ranking"
  get "notifications" => "notifications#index"
  root :to => 'home#index'
end
