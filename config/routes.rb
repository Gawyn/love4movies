require 'sidekiq/web'
Love4movies::Application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'registrations'
  }

  get "in" => "users#in"

  get ":decade", constraints: { decade: /\d{3}0s/ }, to: "movies#decade"
  get ":year", constraints: { year: /\d{4}/ }, to: "movies#year"

  namespace :admin do
    resources :movies, only: :none do
      get :hidden, on: :collection
    end
    root to: "home#index"
  end

  namespace :api do
    namespace :v1 do
      get "search" => "search#search"
    end
  end

  resources :users, :only => [:show, :index], :constraints => { :id => /[^\/]*/ } do
    get ":decade", constraints: { decade: /\d{3}0s/ }, to: "users#decade"
    get ":year", constraints: { year: /\d{4}/ }, to: "users#year"
    get :ranking
    get :login, on: :collection
    resources :lists, :only => [:show, :index]
    resources :follows, only: :create
  end

  resources :persons, :only => :show
  resources :follows, only: :destroy
  resources :activities, only: :index

  resources :movies, :only => [:show, :index] do
    resources :ratings, :only => [:create, :show, :destroy]
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
