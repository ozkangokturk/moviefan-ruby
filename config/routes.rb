Rails.application.routes.draw do
  devise_for :users

  namespace :api, defaults: {format: :json} do
    devise_scope :user do
      resource :session, only: [:create, :destroy]
      match '/authenticate' => 'sessions#create', :via => :post
      match '/register' => 'sessions#register', :via => :post
      match '/account' => 'sessions#destroy', :via => :delete
      match '/account' => 'sessions#show_current_user', :via => :get
    end
    resources :movies
    match '/movies' => 'movies#update', :via => :put
    match '/movies' => 'movies#create', :via => :post
    match '/movies' => 'movies#destroy', :via => :delete
    resources :genres
    match '/genres' => 'genres#update', :via => :put
    match '/genres' => 'genres#create', :via => :post
    match '/genres' => 'genres#destroy', :via => :delete
    resources :moviefan
    match '/moviefan/:movieId' => 'moviefan#create', :via => :post
    match '/moviefan/:movieId' => 'moviefan#destroy', :via => :delete
  end

  root 'home#index'
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
