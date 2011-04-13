require 'rubygems'
require 'bundler'

Bundler.require

require "simplydb"

class ExampleServer < SimplyDB::Server
  set :aws_secret_key, ENV['AWS_SECRET_KEY']
  set :aws_access_key, ENV['AWS_ACCESS_KEY']
  
  set :root, File.dirname(__FILE__)
  enable :logging
  
  before '/domains/:name' do |name|
    puts "Attempted to access domain: #{name}"
    halt unless name == "test"
  end
  
  before '/domains/:name/*' do |name, other|
    puts "Attempted to access domain: #{name} with arguments #{other}"
    halt unless name == "test"
  end
end

run ExampleServer