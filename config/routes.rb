Love4movies::Application.routes.draw do
  devise_scope :user do
    match "/users/auth/:provider/callback" => "users#login"
  end

  devise_for :users

  root :to => 'home#index'
end
