Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  
  authenticated :user do
    root 'the_app#home', as: :authenticated_root
  end

  root 'the_app#welcome'
   
  get '/welcome',       to: 'the_app#welcome'
  get '/home',          to: 'the_app#home'
  get '/find',          to: 'the_app#find'
  post '/find',         to: 'the_app#find'
  get '/profile',       to: 'the_app#profile'
  get '/accomplices',   to: 'the_app#accomplices'
  get '/search',        to: 'the_app#search'
  get '/about',         to: 'the_app#about'
  get '/jobs',          to: 'the_app#jobs'  
  get '/help',          to: 'the_app#help'
  get '/policies',      to: 'the_app#policies'
  get '/sitemap',       to: 'the_app#sitemap'
  get '/find/?c=:tag',  to: 'the_app#find', as: :tag

  resources :locations  

  devise_for :users, :controllers => { :registrations => "registrations", :omniauth_callbacks => "users/omniauth_callbacks" }

  devise_scope :user do
    get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
  end

  resources :users, :only => [:show, :index] do	
    member do
      get :following, :followers, :activity, :want, :done, :authored
    end
  end

  resources :schemes do
    member do
      put 'mark_todo'
      put 'mark_done'
      put 'create_where'
      put 'update_where'
      delete 'destroy_where'
      get 'index_tags'
    end
  
    resources :comments do
      member do
        get 'reply'
        get 'nothelpful'
      end
      resources :replies
    end
  end

  resources :relationships, only: [:create, :destroy]
  resources :connections, only: [:create, :update, :destroy]

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
