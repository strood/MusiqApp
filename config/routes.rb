Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

    resources :users, only: [:create, :new, :show, :index] do
      collection do
        get 'activate'
        get 'admin'
      end
    end

    resource :session, only: [:create, :new, :destroy]

    resources :bands do
        resources :albums, only: [:new]
    end

    resources :albums, except: [:index, :new] do
        resources :tracks, only: [:new]
    end

    resources :tracks, except: [:index, :new]

    resources :notes, only: [:create, :destroy]

    root to: redirect('/session/new')
end
