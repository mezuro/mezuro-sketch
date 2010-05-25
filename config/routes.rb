ActionController::Routing::Routes.draw do |map|
  map.resources :projects, :except => [:show]
  map.project "/projects/:identifier", {:controller => 'projects', :action => 'show'}

  map.root :controller => "projects", :action => "index"

  map.login '/login', :conditions => {:method => :get}, :controller => 'user_sessions', :action => 'new'

  map.login_submit '/login', :conditions => {:method => :post}, :controller => 'user_sessions', :action => 'create'

  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'

  map.resources :users, :except => [:show]
  map.user "/:login", {:controller => 'users', :action => 'show'} 
end
