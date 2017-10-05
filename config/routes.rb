Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :videos do
    collection do
      get :search
    end
  end

  resources :actors
  resources :stars
  root 'welcome#index'
end
