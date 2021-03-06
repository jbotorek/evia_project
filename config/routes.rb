Evia::Application.routes.draw do
  
  resources :users do
    member do
	  get :following, :followers, :attendees					#paths will look like: user/1/following					user/3/followers
	end
  end
  
  resources :routes do
    member do
	  get 'wanters', 'unwant', 'triers', 'untry'
	end
  end
  
  resources :events do
    member do
	  get 'attend', 'unattend'
	end
  end
  
  
  
  resources :sessions, only: [:new, :create, :destroy]
  resources :routes, only: [:new, :create, :destroy, :show]
  resources :relationships, only: [:create, :destroy]
  resources :want_try_relationships, only: [:create, :destroy]
  resources :route_comment, only: [:create, :destroy]
  resources :route_comment_relationships, only: [:create, :destroy]
  resources :event_comment_relationships, only: [:create, :destroy]
  resources :infos
  resources :events
  
			
	match '/signup', to: 'users#new'
	match '/signin', to: 'sessions#new'
	match '/signout', to:'sessions#destroy'
	match '/allwanters', to: 'users#allwanters'
	match '/alltriers', to:'users#alltriers'	
	match '/photogallery', to:'routes#photogallery'
	match 'routes/:id', to:'routes#addphotos', via: :post
	match '/delete_photo_from_photogallery', to:'routes#delete_photo_from_photogallery'

  
  root :to => 'static_pages#home'
	

  # The priority is based upon order of creation:
  # first created -> highest priority.		get "static_pages/home"

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
   

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
