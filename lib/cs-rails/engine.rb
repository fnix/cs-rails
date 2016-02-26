module CsRails
  class Engine < ::Rails::Engine
    isolate_namespace CsRails

    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        routing_specs: false,
        controller_specs: true,
        request_specs: false
      g.template_engine :haml
      g.javascript_engine :coffee
    end
  end
end
