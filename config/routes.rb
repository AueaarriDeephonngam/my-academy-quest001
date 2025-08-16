Rails.application.routes.draw do
  root 'quests#index'
  resources :quests, only: [:index, :create, :update, :destroy] do
    member do
      patch :toggle
    end
  end
  
  resource :brag_document, only: [:show]
end