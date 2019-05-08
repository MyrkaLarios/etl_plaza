Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations' ,
    sessions: 'users/sessions'
  }
  devise_scope :user do
    authenticated :user do
      root 'dashboard#index', as: :authenticated_root
      resources :etl
      get '/delete' => 'etl#delete_element', as: :delete_register
      get '/modify' => 'etl#modify_element', as: :modify_register
      post '/update' => 'etl#update', as: :update_register
    end

    unauthenticated do
      root 'users/sessions#new', as: :unauthenticated_root
    end
  end
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
