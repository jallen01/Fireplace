TscizzleMichelleojKrosnickJallen01Final::Application.routes.draw do
  
  devise_for :users

  resources :users, only: [] do
    member do
      post 'update_context_overrides', defaults: { format: 'js' }
      post 'update_utc_offset', defaults: { format: 'js' }
    end
  end

  resources :settings, only: [:index]
  resources :tasks, only: [:index, :create, :update, :destroy]
  resources :tags, only: [:create, :update, :destroy], defaults: { format: 'js' }
  resources :locations, only: [:create, :update, :destroy], defaults: { format: 'js' }
  resources :day_ranges, only: [:create, :update, :destroy], defaults: { format: 'js' }
  resources :time_ranges, only: [:create, :update, :destroy], defaults: { format: 'js' }

  # Route root to user's tasks page
  authenticated :user do
    root to: "tasks#index", as: "authenticated_root"
  end

  # Otherwise route to login
  root to: redirect("/users/sign_in")
end
