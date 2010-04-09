ActionController::Routing::Routes.draw do |map|
  map.resources :projects, :except => [:show]
  map.show "/projects/:identifier", {:controller => 'projects', :action => 'show'}

  map.resources :users

  map.root :controller => "projects", :action => "index"

  map.login '/login', :conditions => {:method => :get}, :controller => 'user_sessions', :action => 'new'
  map.login_submit '/login', :conditions => {:method => :post}, :controller => 'user_sessions', :action => 'create'
  map.logout '/logout', :conditions => {:method => :delete}, :controller => 'user_sessions', :action => 'destroy'

end
