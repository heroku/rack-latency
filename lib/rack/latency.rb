require "rack/latency/version"
require "rack/latency/reporter"
require "rack/latency/rack_latency_railtie"

module Rack
  module Latency

    def self.configure(&block)
      yield self
    end

    def self.paths
      @paths ||= {}
    end

    def self.wait(val)
      @wait = val
    end

    def self.get_wait
      @wait || 2
    end

    def self.head(path, opts = {})
      paths[path] = opts.merge(method: :head)
    end

    def self.get(path, opts = {})
      paths[path] = opts.merge(method: :get)

    end
  end
end
