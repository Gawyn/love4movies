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

  resources :users, :only => [:show, :index] do
    get :ranking
    resources :lists, :only => [:show, :index]
    resources :follows, only: :create
  end

  resources :persons, :only => :show
  resources :follows, only: :destroy
  resources :activities, only: :index

  resources :movies, :only => [:show, :index] do
    resources :ratings, :only => [:create, :show]
    get :ranking, :on => :collection
    get :recommended, :on => :collection
    get :trending, :on => :collection
  end
  resources :ratings, :only => [:create, :destroy, :show] do
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

  resources :loves, only: [:create, :destroy]

  get "ranking" => "movies#ranking"
  get "notifications" => "notifications#index"
  get "search" => "search#search"

  get "timeline" => "home#timeline"
  get "trending" => "movies#trending"
  root :to => 'home#index'
end
