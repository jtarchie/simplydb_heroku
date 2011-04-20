require "spec_helper"
require './server'

describe ExampleServer do
  include Rack::Test::Methods
  
  def app
    ExampleServer
  end
  
  it "returns successful" do
    get '/'
    last_response.status.should == 200
  end
  
  describe "authentication on domains" do
    it "halts the request on an invalid domain" do
      get '/domains/not'
      last_response.status.should == 401
      get '/domains/not/items/'
      last_response.status.should == 401
    end
  
    it "returns successful for the test domain" do
      get '/domains/test'
      last_response.status.should == 200
      get '/domains/test/items'
      last_response.status.should == 200
    end
  end
  
  describe "authentication on items" do
    it "halts on SELECT queries not for the test domain" do
      get '/items', :q => "SELECT * FROM other"
      last_response.status.should == 401
      get '/items', :q => "SELECT * FROM test"
      last_response.status.should == 200
    end
  end
end