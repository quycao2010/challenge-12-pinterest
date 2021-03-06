Rails.application.routes.draw do
  get 'sessions/new'

  resources :pins do
    member do
      put "like", to: "pins#like"
      put "dislike", to: "pins#dislike"
    end 
  end 
  root "pins#index"
  resources :users
  post "/signup", to: "users#create"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
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
