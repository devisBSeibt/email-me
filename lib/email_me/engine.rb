require 'redcarpet'
require 'liquid'
require 'ace-rails-ap'

module EmailMe
  class Engine < ::Rails::Engine
    isolate_namespace EmailMe

    initializer :append_migrations do |app|
      unless app.root.to_s.match(root.to_s)
        config.paths["db/migrate"].expanded.each do |p|
          app.config.paths["db/migrate"] << p
        end
      end
    end


    # config.assets.paths << Rails.root.join("vendor/assets/stylesheets")
    config.assets.paths << File.expand_path("../../vendor/assets/stylesheets", __FILE__)



  end
end
