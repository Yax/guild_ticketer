ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end 

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "tickets"


  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  ttypes = %w{ questions problems complaints refunds cancellations technicals }
  
  map.namespace :admin do |admin|
    admin.connect '', :controller => 'tickets', :action => 'index'
    admin.resources :ticket_categories
    admin.resources :tickets, :shallow => true,
                    :member => { :transitions => :get },
                    :collection => { :any_new => :get } do |ticket|
      ticket.resources :messages, :except => 'index'
    end
    
    ttypes.each do |type|
      admin.resources type.to_sym, :as => 'tickets', :controller => 'tickets',
        :shallow => true, :except => [ 'create', 'update', 'destroy' ] do |ttype|
        ttype.resources :messages, :only => [ 'create', 'new' ]
      end
    end
  end

  map.with_options :controller => 'frontend', 
                   :name_prefix => 'client_',
                   :path_prefix => 'client',
                   :conditions => { :method => :get } do |front|
    front.connect '', :action => 'index'
    front.tickets 'tickets.:format', :action => 'index'
    front.connect 'tickets.:format', :action => 'create_ticket', :conditions => { :method => :post }
    front.new_ticket 'tickets/new.:format', :action => 'new_ticket'

    front.ticket 'tickets/:id.:format', :action => 'show_ticket'
    front.message 'messages/:id.:format', :action => 'show_message'

    front.ticket_messages 'tickets/:id/messages.:format',
                          :action => 'create_message',
                          :conditions => { :method => :post }
    front.new_message 'ticket/:id/messages/new.:format', :action => 'new_message'
  end

  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end
