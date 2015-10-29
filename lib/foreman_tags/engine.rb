require 'deface'
require 'acts-as-taggable-on'

module ForemanTags
  class Engine < ::Rails::Engine
    engine_name 'foreman_tags'

    config.autoload_paths += Dir["#{config.root}/app/controllers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/helpers"]
    config.autoload_paths += Dir["#{config.root}/app/models/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/overrides"]
    config.autoload_paths += Dir["#{config.root}/app/views/"]

    # Add any db migrations
    initializer 'foreman_tags.load_app_instance_data' do |app|
      ForemanTags::Engine.paths['db/migrate'].existent.each do |path|
        app.config.paths['db/migrate'] << path
      end
    end

    initializer 'foreman_tags.register_plugin', after: :finisher_hook do |_app|
      Foreman::Plugin.register :foreman_tags do
        requires_foreman '>= 1.4'

        # Add permissions
        # security_block :foreman_tags do
        #   permission :view_foreman_tags, {:HostsController => [:tag] }
        # end

        # Add a new role called 'Discovery' if it doesn't exist
        # role 'ForemanTags', [:view_foreman_tags]

      end
    end

    config.to_prepare do
      begin
        ::HostsController.send :include, ForemanTags::HostsControllerExtensions
        Host::Base.send :include, ForemanTags::HostExtensions
      rescue => e
        Rails.logger.warn "ForemanTags: skipping engine hook (#{e})"
      end
    end

    initializer 'foreman_tags.register_gettext', after: :load_config_initializers do |_app|
      locale_dir = File.join(File.expand_path('../../..', __FILE__), 'locale')
      locale_domain = 'foreman_tags'
      Foreman::Gettext::Support.add_text_domain locale_domain, locale_dir
    end
  end
end
