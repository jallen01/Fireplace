TscizzleMichelleojKrosnickJallen01Final::Application.routes.draw do
  
  devise_for :users do
    member do
      post 'update_flags', defaults: { format: 'js' }
    end
  end

  resources :settings, only: [:index]

  resources :tasks

  resources :tags, only: [:create, :update, :destroy], defaults: { format: 'js' }
  resources :locations, only: [:create, :update, :destroy], defaults: { format: 'js' }
  resources :day_ranges, only: [:create, :update, :destroy], defaults: { format: 'js' }
  resources :time_ranges, only: [:create, :update, :destroy], defaults: { format: 'js' }

  # Route root to user's tasks page
  root :to => "tasks#index"

end
