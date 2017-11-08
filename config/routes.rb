Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :videos, only:[:index, :show] do
    collection do
      get :search
    end
  end

  resources :actors, only:[:index, :show]
  resources :stars, only:[:index, :show]
  resources :users
  root 'welcome#index'
end
