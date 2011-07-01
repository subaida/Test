ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.
  
  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up '' 
  # -- just remember to delete public/index.html.
  map.connect '', :controller => 'login', :action=>'index'
  map.connect 'home', :controller => 'home', :action=>'home_analytics'
  map.connect 'home/:duration/:showlist', :controller => 'home', :action=>'home_analytics'
  map.connect 'publisher_analytic/generate_report/:adclient_dropdown/:pub_start_on/:pub_end_on/:duration/:filled', :controller => 'publisher_analytic', :action=>'generate_report'
  map.connect 'advertiser_analytic/generate_adv_report/:campaign_id/:ad_id/:adv_start_on/:adv_end_on/:duration/:statistics', :controller => 'advertiser_analytic', :action=>'generate_adv_report'
  map.connect 'admin_analytic/generate_adv_report/:campaign_id/:ad_id/:adv_start_on/:adv_end_on/:duration/:statistics', :controller => 'admin_analytic', :action=>'generate_adv_report'
  map.connect 'admin_analytic/generate_report/:adclient_dropdown/:pub_start_on/:pub_end_on/:duration/:filled', :controller => 'admin_analytic', :action=>'generate_report'
  #map.redirect 'login', :controller => 'home', :action=>'login'
  
  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
  #map.connect '*path', :controller => 'application', :action => 'rescue_404' 
end
