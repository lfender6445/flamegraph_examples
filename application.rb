require 'sinatra'
require 'pry'

module ApplicationHelper
  MAX_STACK = 100
  def foo
    1000.times { puts 'foo' }
  end

  def bar
    10000.times { puts 'bar' }
  end

  def baz
    100000.times { puts 'baz' }
  end

  def recursion(some_arg = nil)
    some_undefined_method_0
  end

  # create stack or sequence of alphabet methods
  # that each call the next letter if one exists
  alphabet = ('a'..'z').to_a
  alphabet.each_with_index do |letter, index|
    define_method(letter.to_sym) do
      next_letter = alphabet[index + 1]
      unless letter == alphabet.last
        self.send((next_letter.to_sym)) if next_letter
      end
      sleep(0.8)
      return next_letter
    end
  end

  def stack
    a()
  end


  def method_missing(method_sym, *arguments, &block)
    # the first argument is a Symbol, so you need to_s it if you want to pattern match
    if method_sym.to_s =~ /^stack_(.*)$/
      suffix = (method_sym.to_s.split('_').last.to_i + 1)
      return false if suffix == MAX_STACK
      self.send "stack_#{suffix}".to_sym
    end
  end
end

class Sinatra::Application
  use Rack::MiniProfiler
  helpers ApplicationHelper

  get '/' do
    # flamegraph branches here

    # ~ 0.79% of a sampling
    foo

    # bar ~8% of a sampling
    bar

    # baz ~ 78% of a sampling
    baz
    'hello world'
  end

  get '/recursion' do
    recursion
    'hello world'
  end

  get '/stack' do
    stack
    'hello world'
  end
end
