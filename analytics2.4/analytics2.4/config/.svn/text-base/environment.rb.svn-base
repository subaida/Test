# Be sure to restart your web server when you modify this file.

# Uncomment below to force Rails into production mode when 
# you don't control web/app server and can't set it the proper way
#ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
# RAILS_GEM_VERSION = '1.2.6' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here
  
  # Skip frameworks you're not going to use (only works if using vendor/rails)
  
  #config.frameworks -= [ :action_web_service ]
  #config.plugins = ["engines", "*"]
  # Only load the plugins named here, by default all plugins in vendor/plugins are loaded
  # config.plugins = %W( exception_notification ssl_requirement )

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Force all environments to use the same logger level 
  # (by default production uses :info, the others :debug)
   config.log_level = :none

  # Use the database for sessions instead of the file system
  # (create the session table with 'rake db:sessions:create')
  # config.action_controller.session_store = :active_record_store
    config.action_controller.session_store = :mem_cache_store 

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper, 
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql
  # config.active_record.schema_format = :ruby

  # Activate observers that should always be running
#   config.active_record.observers = :cacher, :garbage_collector

  # Make Active Record use UTC-base instead of local time
  # config.active_record.default_timezone = :utc
  
  # See Rails::Configuration for more options
end

# Add new inflection rules using the following format 
# (all these examples are active by default):
# Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
# Mime::Type.register "application/x-mobile", :mobile
 Mime::Type.register "text/xhtml+xml", :xhtml

# Include your application configuration below
#RCC_PUB='6LcNOgAAAAAAADmkMZW0vvJKzKXGGA4ArTcYZI5Y'
#RCC_PRIV='6LcNOgAAAAAAAJDSd3UjUZhm0Bk6MXEIp-EFKWp9'
require 'tlsmail'
Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
ActionMailer::Base.delivery_method = :smtp

#config.cache_classes = true
ActionMailer::Base.smtp_settings = {
:address => "smtp.gmail.com",
:port => 587,
:domain => "zestadz.com",
:authentication => :plain,
:user_name => "support@zestadz.com",
:password => "temp123"
}

#ActionController::Base.fragment_cache_store =:mem_cache_store, "localhost:11211"

#ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.default_charset = "string"

#ExceptionNotifier.exception_recipients = %w(asghar@mobile-worx.com sathish@mobile-worx.com)
# defaults to exception.notifier@default.com
#ExceptionNotifier.sender_address = %("Application Error" <app.error@myapp.com>)
# defaults to "[ERROR] "
#ExceptionNotifier.email_prefix = "[APP] "
#ActionController::Base.consider_all_requests_local = true
ActiveRecord::Base.verification_timeout=14000

#~ $CONS=SmsComponent.new
#~ $CONS.cache_drbserver_obj
#~ $CONW=WapComponent.new
#~ $CONW.cache_drbserver_obj

#$count=1

#require 'cached_model'
require 'memcache'
memcache_options = {
  :c_threshold => 10_000,
  :compression => true,
  :debug => false,
  :namespace => 'zestadz_Analytics',
  :readonly => false,
  :urlencode => false
}

CACHE = MemCache.new memcache_options
CACHE.servers = '127.0.0.1:11211'
#CACHE.servers = %w[localhost:11211, mw16:11211]
ActionController::Base.session_options[:expires] = 21600 
#ActionController::Base.session_options[:cache] = CACHE.servers
ActionController::CgiRequest::DEFAULT_SESSION_OPTIONS.merge!({ 'cache' => CACHE })
ActionController::Base.fragment_cache_store = :mem_cache_store
#ActionController::Base.fragment_cache_store = :file_store, "#{RAILS_ROOT}/public/cache"
