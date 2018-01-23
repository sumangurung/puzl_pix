Rails.application.routes.draw do

  get 'share', to: 'files#share'
  get 'apple-app-site-association', to: 'files#apple_app_site_association'

  namespace :v2 do
    resources :users, only: [:create, :update, :show] do
      resources :device_tokens, only: [:create]
    end

    resources :scores, only: [:create, :index, :create_bulk] do
      # match :batch_create, via: [:post],  on: :collection
      collection do # v2/scores/create_bulk
        post :create_bulk
      end
    end

    resources :challenges, only: [:create, :index, :show, :accept, :finish, :created, :accepted] do
      collection do
        post :accept
        post :finish
      end
    end
  end

  namespace :v1 do
    resources :users, only: [:create, :update, :show] do
      resources :device_tokens, only: [:create]
    end
    resources :scores, only: [:create, :index]
    resources :challenges, only: [:create, :index]
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
