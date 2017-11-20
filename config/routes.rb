Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :videos, only:[:index, :show] do
    collection do
      get :search
      post :fave
      delete :unfave
    end
  end

  resources :actors, only:[:index, :show] do
    member do
      get 'output'
      get 'genres'
    end
  end

  resources :stars, only:[:index, :show]
  resources :users do
    collection do
      get 'videos'
    end
  end

  resource :relationships, only:[:create, :destroy]

  root 'welcome#index'
end
