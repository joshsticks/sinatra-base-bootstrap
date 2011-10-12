# why should I have to do this!?
$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), ".."))

ENV['RACK_ENV'] = 'test'

require 'test/unit'
require 'rack/test'
require 'app'

class ApplicationTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_without_authentication
    get '/protected'
    assert_equal 401, last_response.status
  end

  def test_with_bad_credentials
    authorize 'bad', 'boy'
    get '/protected'
    assert_equal 401, last_response.status
  end

  def test_with_proper_credentials
    authorize 'admin', 'secret'
    get '/protected'
    assert_equal 200, last_response.status
    assert_equal "Welcome, authenticated client", last_response.body
  end
end