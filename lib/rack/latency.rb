require "rack/latency/version"
require "rack/latency/reporter"
require "rack/latency/rack_latency_railtie"

module Rack
  module Latency

    def self.configure(&block)
      yield self
    end

    def self.measurements
      @measurements ||= {}
    end

    def self.wait(val)
      @wait = val
    end

    def self.get_wait
      @wait || 2
    end

    def self.head(url, opts = {})
      add_measurement(url, :head, opts)
    end

    def self.get(url, opts = {})
      add_measurement(url, :get, opts)
    end

    def self.add_measurement(url, method, opts = {})
      url = URI.parse(url)
      url.path = "/" if url.path == ""
      measurements[url] = opts.merge(method: method)
      puts "measurements is now #{measurements}"
    end
  end
end
