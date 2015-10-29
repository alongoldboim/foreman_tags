Rails.application.routes.draw do
  match 'tag/:id' => 'hosts#tag'
  match 'add_tag/:id' => 'hosts#add_tag'
  match 'remove_tag/:id' => 'hosts#remove_tag'
  match 'tag/:id' => 'discovered_hosts#tag'
  match 'add_tag/:id' => 'discovered_hosts#add_tag'
  match 'remove_tag/:id' => 'discovered_hosts#remove_tag'
end
