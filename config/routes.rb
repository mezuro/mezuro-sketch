ActionController::Routing::Routes.draw do |map|
  map.resources :projects, :except => [:show]
  map.show "/projects/:identifier", {:controller => 'projects', :action => 'show'}

  map.resources :users
end
