Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    
    #users 
    devise_for :users, controllers: { 
        confirmations: 'users/confirmations',
        passwords: 'users/passwords',
        registrations: 'users/registrations',
        sessions: 'users/sessions',
        unlocks: 'users/unlocks'
    }

    as :user, defaults: {format: :json} do  
        get 'users/sign_out' => 'users/sessions#destroy'
        get 'users/settings' => 'users#edit'
        get 'users/email_subscribers' => 'users#email_subscribers'
    end

    resources :users, only: [:index, :show], defaults: {format: :json} do
        resources :collections, defaults: {format: :json}
        resources :collection_resources, defaults: {format: :json}
        resources :favorites, only: [:index, :create, :destroy], defaults: {format: :json}
    end

    get 'admin' => 'control_panel#index', :as => :admin, defaults: {format: :json}
    resources :control_panel, only: [:index], defaults: {format: :json} 


    #resources & tags  
    resources :resources, defaults: {format: :json}
    resources :tags, only: [:create], defaults: {format: :json}
    resources :resource_tags, only: [:create, :destroy], defaults: {format: :json}

    #reviews 
    resources :reviews, defaults: {format: :json}

    #categories
    resources :categories, defaults: {format: :json}

    #welcome
    resources :welcome, defaults: {format: :json} 

    root to: "welcome#index"

end
