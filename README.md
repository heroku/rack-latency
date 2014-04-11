# Rack::Latency

```
10:06:49 web.1  | at=info source=yahoo measure#response.size=9 measure#response.latency=130.86ms
10:06:53 web.1  | at=info source=google measure#response.size=11 measure#response.latency=60.65ms
10:06:53 web.1  | at=info source=yahoo measure#response.size=9 measure#response.latency=122.92ms
10:06:57 web.1  | at=info source=google measure#response.size=11 measure#response.latency=53.46ms
10:06:57 web.1  | at=info source=yahoo measure#response.size=9 measure#response.latency=129.75ms
10:07:01 web.1  | at=info source=google measure#response.size=11 measure#response.latency=58.56ms
```

This gem measures request latency to other hosts. It runs as a separate thread created by its own middleware. If you're running multiple apps that talk to each other, it's a good way to sniff out potential network problems.

On my system, the `head`  measurement times are roughly equivalent to (maybe 10-20% faster than) `curl -I`.

## Installation and Configuration

Add `gem 'rack-latency'` to your app's Gemfile. Then create an initializer to specify your desired measurements:

```
# config/initializers/rack-latency.rb
Rack::Latency.configure do |measure|
  # time a HEAD request for google.com.
  measure.head "http://www.google.com/" 

  # time a GET request to a Yahoo IP, and rename the measurement to "yahoo".
  measure.get "http://98.138.253.109/", name: "yahoo" 

  # set the delay time between measurement loops.
  measure.wait ENV["RACK-LATENCY-WAIT"] || 4
end

```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/rack-latency/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
