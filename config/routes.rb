require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users

  root 'stories#index'

  devise_scope :user do
    get 'login', to: "devise/sessions#new", as: :login
    get 'logout', to: "devise/sessions#destroy", as: :logout
    get 'register', to: "devise/registrations#new", as: :register
  end

  resources :users, only: [:show]
  put "stories/:id/vote/:vote_value", to: "stories#vote", as: :story_vote
  put "stories/:story_id/submissions/:id/vote/:vote_value", to: "submissions#vote", as: :story_submission_vote

  # scope concerns: :paginatable do
    resources :stories do
      resources :submissions, only: [:new, :create, :edit, :update, :destroy]
    end
  # end

  namespace :admin do
    resources :users, only: [:update, :destroy]
  end

authenticate :user, lambda { |u| u.admin? } do
  mount Sidekiq::Web => '/sidekiq'
end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
