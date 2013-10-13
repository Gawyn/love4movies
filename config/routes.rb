Love4movies::Application.routes.draw do
  devise_scope :user do
    get "/users/auth/:provider/callback" => "users#login"
  end

  devise_for :users

  namespace :admin do
    root to: "home#index"
  end

  resources :users, :only => :show do
    get :ranking
    resources :lists, :only => [:show, :index]
  end

  resources :persons, :only => :show

  resources :movies, :only => [:show, :index] do
    get :ranking, :on => :collection
  end
  resources :ratings, :only => [:create, :destroy]
  resources :comments, :only => :create
  resources :lists, :only => :create do
    get :movie_search, :on => :member
  end
  resources :list_belongings, :only => :create do
    delete :destroy, :on => :collection
  end

  get "ranking" => "movies#ranking"
  root :to => 'home#index'
end
