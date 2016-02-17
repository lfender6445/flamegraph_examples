require 'rubygems'
require 'bundler'

require 'stackprof'
require 'flamegraph'
require 'memory_profiler'
require 'rack-mini-profiler'

require_relative 'application'

run Rack::URLMap.new \
  '/'    => Sinatra::Application
