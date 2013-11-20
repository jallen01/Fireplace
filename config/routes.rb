TscizzleMichelleojKrosnickJallen01Final::Application.routes.draw do
  
  devise_for :users do
    member do
      post 'update_flags', defaults: { format: 'js' }
    end
  end

  resources :settings, only: [:index]

  resources :tasks

  resources :tags, defaults: { format: 'js' }

  resources :locations

  # Route root to user's tasks page
  root :to => "tasks#index"

end
