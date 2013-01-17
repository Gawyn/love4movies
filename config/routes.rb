Love4movies::Application.routes.draw do
  devise_scope :user do
    match "/users/auth/:provider/callback" => "users#login"
  end

  devise_for :users

  resources :movies, :only => :show

  root :to => 'home#index'
end
