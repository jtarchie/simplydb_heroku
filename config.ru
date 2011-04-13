require 'rubygems'
require 'bundler'

Bundler.require

require "simplydb"

class ExampleServer < SimplyDB::Server
  set :aws_secret_key, ENV['AWS_SECRET_KEY']
  set :aws_access_key, ENV['AWS_ACCESS_KEY']
end

run ExampleServer