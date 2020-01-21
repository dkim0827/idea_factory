Rails.application.routes.draw do
  root 'welcome#home'
  
  get '/users/:id/password/edit', to: 'users#password_edit', as: 'password'
  patch '/users/:id/password/edit', to: 'users#password_update', as: 'update_password'
  

  resources :ideas do
    resources :reviews, only: [:create, :destroy]
    resources :likes, shallow: true, only: [:create, :destroy]
    get :liked, on: :collection
  end
  
  resources :users, only: [:new, :create, :edit, :update, :destroy]
  resource :session, only: [:new, :create, :destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
