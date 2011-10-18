require 'sinatra'
require 'dalli'
require 'rack/cache'
require 'data_mapper'
require 'haml'
require 'sass'

Dir[File.dirname(__FILE__) + '/lib/**/*.rb'].each { |file| require file }

use Rack::Deflater

configure do
  set :root, File.dirname(__FILE__)
  set :static, true
  set :public_folder, 'public'
  set :haml, :format => :html5
  set :static_cache_control, [:public, :max_age => 60 * 60 * 24]
  
  enable :sessions
  set :session_secret, 'super secret session key'
  
  set :authenticate,  false
  set :auth_username, 'admin'
  set :auth_password, 'secret'
  
  # set the last mod time to now, when the app starts up
  @last_mod_time = Time.now

  # for google analytics
  @analytics_token = '-'

  # database
  # DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/db/development.db")
  # DataMapper.auto_upgrade!
  # DataMapper.finalize   # To do after declaring all models
end


configure :development do |config|
  require 'ruby-debug'
  require "sinatra/reloader"
  config.also_reload "lib/*.rb"
end


configure :production do |config|
  unless settings.authenticate
    use Rack::Cache,
        :verbose => true,
        :metastore => "memcached://#{ENV['MEMCACHE_SERVERS']}",
        :entitystore => "memcached://#{ENV['MEMCACHE_SERVERS']}"
  end
end


# helpers
helpers Sinatra::Partials
helpers Sinatra::Helpers


# hooks
before do
  if settings.authenticate
    authenticate!
  end
  
  cache_control :public, :max_age => 60 * 60 * 24
end


# routes
get '/' do
  haml :index
end


get '/css/style.css' do
  scss :"scss/styles"
end


not_found do
  haml :not_found
end


# error handlers in production
error do
  haml :error
end
