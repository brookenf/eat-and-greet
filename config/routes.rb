Rails.application.routes.draw do

  get "my-events", to: "my_events#index"

  resources :events do
    resources :memberships, only: [:create, :destroy]
  end

  resources :comments, only: [:create]

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"

end
