TscizzleMichelleojKrosnickJallen01Final::Application.routes.draw do
  devise_for :users do
    member do
      post 'update_flags', defaults: { format: 'js' }
    end
  end

  resources :tasks do
    member do
      post 'add_tag', defaults: { format: 'js' }
      get 'remove_tag', defaults: { format: 'js' }
    end
  end

  resources :tags, defaults: { format: 'js' } do 
    member do
      post 'add_child_tag', defaults: { format: 'js' }
      get 'remove_child_tag', defaults: { format: 'js' }
      post 'add_location', defaults: { format: 'js' }
      get 'remove_location', defaults: { format: 'js' }
    end
  end

  resources :locations

  # Aliases
  devise_scope :user do
    get "sign_up" => "devise/registrations#new"
    get "log_in" => "devise/session#new"
    get "log_out" => "devise/sessions#destroy"
  end

  # Route root to group index
  root :to => "tasks#index"

end
