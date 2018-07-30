Rails.application.routes.draw do
  resources :messages do
    member do
      get :chat_room
    end
  end
  devise_for :users
  root 'welcome#index'
  mount ActionCable.server, at: '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
