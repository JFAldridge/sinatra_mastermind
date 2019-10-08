require 'sinatra'
require 'sinatra/reloader'
require "erb"

get '/' do
  "Hello, World"
end