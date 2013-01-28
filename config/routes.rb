Love4movies::Application.routes.draw do
  devise_scope :user do
    match "/users/auth/:provider/callback" => "users#login"
  end

  devise_for :users

  resources :movies, :only => [:show, :index] do
    get :ranking, :on => :collection
  end
  resources :ratings, :only => [:create, :update, :destroy]
  resources :comments, :only => :create

  match "ranking" => "movies#ranking"
  root :to => 'home#index'
end
