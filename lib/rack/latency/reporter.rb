require 'net/http'
require 'uri'

module Rack
  module Latency
    class Reporter
      def initialize(app, logger = nil)
        @app = app
        @logger = logger || ::Logger.new($stdout)

        interval = (Rack::Latency.get_wait).to_i
        if defined?(Rails)
          start(interval) if Rack::Latency.get_environments.include?(Rails.env.to_sym)
        else
          start(interval) if Rack::Latency.get_environments.include(ENV["RACK_ENV"].to_sym)
        end
      end

      def call(env)
        status, headers, body = @app.call(env)
        [status, headers, body]
      end

      private

      def start(interval)
        @logger.info "-> rack-latency starting in interval mode (#{interval}s)"
        Thread.new { report(interval) }
      end

      def report(interval)
        loop do
          Rack::Latency.measurements.each do |uri, opts|
            begin
              start_time = Time.now
              @size = 0
              Net::HTTP.start(uri.host, uri.port) do |http|
                response = http.send(opts[:method], uri.path)
                @size = response.length
              end
              end_time = Time.now
              @logger.info "at=info source=#{opts[:name] || uri.host} measure#response.size=#{@size} measure#response.latency=#{"%.2f" % ((end_time - start_time)*1000)}ms"
            rescue
              @logger.info "at=error source=#{uri}"
            end
          end
          sleep(interval)
        end
      end
    end
  end
end
