# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/latency/version'

Gem::Specification.new do |spec|
  spec.name          = "rack-latency"
  spec.version       = Rack::Latency::VERSION
  spec.authors       = ["Chad Bailey"]
  spec.email         = ["chad@heroku.com"]
  spec.summary       = %q{Measure and report latency to external hosts.}
  spec.description   = %q{Measure and report latency to external hosts.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
end
