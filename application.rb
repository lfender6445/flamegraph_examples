require 'sinatra'

class Sinatra::Application
  use Rack::MiniProfiler
  module ApplicationHelper
    def foo
      puts 'foo'
    end
    def bar
      puts 'bar'
    end
  end
  helpers ApplicationHelper

  get '/' do
    foo
    bar
    'hello world'
  end
end

