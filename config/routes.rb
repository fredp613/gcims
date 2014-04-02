GCIMS::Application.routes.draw do
  

  resources :otherfunders
  resources :applicationtypes
  resources :budgetcategories
  resources :users
  resources :budgetitems
  resources :charities
  resources :bands
  resources :websites
  resources :phones
  resources :emails
  resources :corporations
  resources :addresstypes
  resources :contacttypes
  resources :contacttypes
  resources :countries
  resources :states
  resources :clientlocations
  resources :contactlocations
  resources :fiscalyears
  resources :commitmentitems
  resources :summarycommitments 
  resources :subservicelines  
  resources :productservicelines, path: 'pras' 
  resources :fincodes

  resources :searches do
    collection do
      get "searches/index", :as=>'quicksearch'
      post "searches/index", :as=>'quicksearch'
      get "searches/advanced", :as=>'advancedsearch'
      post "searches/advanced", :as=>'advancedsearch'
    end
  end

  resources :divisions do
    resources :locations
  end

   resources :clienttypes do

      collection do
        get "/new_client" => 'clienttypes#new_client'
        post "/new_client" => 'clienttypes#new_client_go'

      end
    end

  resources :clients do
    collection do
      get "/foreign" => 'clients#foreign'
      post "/foreign" => 'clients#foreign_go'
      get "corporation" => 'clients#corporation'      
    end
    
    
    resources :locations
    resources :contacts do
      resources :locations
    end
    resources :contactlocations
    resources :projects
    resources :divisions
    resources :emails
    resources :websites
    resources :phones
  end


  resources :projectcontacts

  resources :applications do
    resources :budgetitems
  end
  
  resources :projects do
    resources :contacts do
      resources :locations
    end
    resources :contactlocations
    resources :projectcontacts
    resources :locations
    resources :budgetitems
  end

  resources :contacts do
    resources :locations
    resources :projectcontacts
  end

  resources :locations do
    collection do
        get "/foreign" => 'locations#foreign'
        post "/foreign" => 'locations#foreign_go'
    end
    resources :contactlocations
    resources :clientlocations
  end


  devise_for :user, :controllers => { :registrations => "registrations" }

  as :user do
    get '/register', to: 'devise/registrations#new', as: :register
    get '/login', to: 'devise/sessions#new', as: :login
    post "/login" => 'devise/sessions#create', as: :user_session
    delete "/logout" => 'devise/sessions#destroy', as: :destroy_user_session
    get '/logout', to: 'devise/sessions#destroy', as: :logout

    get '/frontend/register', to: 'devise/registrations#new', as: :register
    get '/frontend/login', to: 'devise/sessions#new', as: :login
    post "/frontend/login" => 'devise/sessions#create', as: :user_session
    delete "/frontend/logout" => 'devise/sessions#destroy', as: :destroy_user_session
    get '/frontend/logout', to: 'devise/sessions#destroy', as: :logout

    
  end

  namespace :frontend do
    resources :client_application 
    root to: "ClientApplication#index"    
  end

 

  
  #get 'edit_psl', to: "productserviceline/edit/:id/layout/:layout"
  

  # The priority is based upon order of creation:
  # first created -> highest priority.

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
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
