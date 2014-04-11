module Rack
  module Latency
    class RackLatencyRailtie < Rails::Railtie
      initializer "rack_latency_railtie.configure_rails_initialization" do |app|
        app.middleware.use Rack::Latency::Reporter
      end
    end
  end
end
