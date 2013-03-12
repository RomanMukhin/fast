Fast::Application.routes.draw do
  devise_for :users
  resources :users
  resources :tasks do
    member do
      get 'apply'
      get 'cancel'
      get 'finish'
    end
  end
  
  root to: "users#index"
end
