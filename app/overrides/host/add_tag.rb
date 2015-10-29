Deface::Override.new(:virtual_path  => "hosts/index",
                     :name          => "change hosts index to have tag coulmn",
                     :replace       => "erb[loud]:contains('render')",
                     :text          => "<%= render 'list_with_tag', :hosts => @hosts, :header => @title || _('Hosts') %>")

Deface::Override.new(:virtual_path  => "discovered_hosts/index",
                     :name          => "change discovered hosts index to have tag coulmn",
                     :replace       => "erb[loud]:contains('render')",
                     :text          => "<%= render 'discovered_list_with_tag', :hosts => @hosts, :header => @title || _('Hosts') %>")