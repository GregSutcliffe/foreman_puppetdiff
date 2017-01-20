require 'deface'

module ForemanPuppetdiff
  class Engine < ::Rails::Engine
    engine_name 'foreman_puppetdiff'

    config.autoload_paths += Dir["#{config.root}/app/controllers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/helpers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/models/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/overrides"]


    initializer 'foreman_puppetdiff.register_plugin', :before => :finisher_hook do |_app|
      Foreman::Plugin.register :foreman_puppetdiff do
        requires_foreman '>= 1.13'
      end
    end

    # Precompile any JS or CSS files under app/assets/
    # If requiring files from each other, list them explicitly here to avoid precompiling the same
    # content twice.
    assets_to_precompile =
      Dir.chdir(root) do
        Dir['app/assets/javascripts/**/*', 'app/assets/stylesheets/**/*'].map do |f|
          f.split(File::SEPARATOR, 4).last
        end
      end
    initializer 'foreman_puppetdiff.assets.precompile' do |app|
      app.config.assets.precompile += assets_to_precompile
    end
    initializer 'foreman_puppetdiff.configure_assets', group: :assets do
      SETTINGS[:foreman_puppetdiff] = { assets: { precompile: assets_to_precompile } }
    end

    # Include concerns in this config.to_prepare block
    config.to_prepare do
      begin
        Host::Managed.send(:include, ForemanPuppetdiff::HostExtensions)
        HostsHelper.send(:include, ForemanPuppetdiff::HostsHelperExtensions)
	::HostsController.send(:include, ForemanPuppetdiff::HostsControllerExtensions)
      rescue => e
        Rails.logger.warn "ForemanPuppetdiff: skipping engine hook (#{e})"
      end
    end

    initializer 'foreman_puppetdiff.register_gettext', after: :load_config_initializers do |_app|
      locale_dir = File.join(File.expand_path('../../..', __FILE__), 'locale')
      locale_domain = 'foreman_puppetdiff'
      Foreman::Gettext::Support.add_text_domain locale_domain, locale_dir
    end
  end
end
