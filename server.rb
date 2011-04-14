require 'sinatra/base'
require 'simplydb'

class AuthenticationFilter < Sinatra::Base
  before '/domains/:name' do |name|
    halt(401) unless name == "test"
  end
  
  before '/domains/:name/*' do |name, other|
    halt(401) unless name == "test"
  end
end

class ExampleServer < SimplyDB::Server
  set :aws_secret_key, ENV['AWS_SECRET_KEY']
  set :aws_access_key, ENV['AWS_ACCESS_KEY']
  
  use AuthenticationFilter
  
  set :root, File.dirname(__FILE__)
  enable :logging, :method_override
  
  get '/' do
    content_type :html
    send_file("public/index.html")
  end
end