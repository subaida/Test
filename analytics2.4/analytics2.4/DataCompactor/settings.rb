require 'rubygems'
require 'memcache'
require 'socket'
require 'timeout'
require 'thread'

module MemcacheSettings
    memcache_options = {
      :c_threshold => 10_000,
      :compression => true,
      :debug => false,
      :namespace => 'zestadz_in_memory',
      :readonly => false,
      :urlencode => false
    }
    CACHE = MemCache.new memcache_options 
    SERVERS = ["localhost:11211"]
    CACHE.servers = SERVERS
end


module AnalyticsDBReadServer
    #this is the DBI ORM settings
    DATABASE = "temp_analytics"
    REDUCE_DATABASE="reduce_analytics"
    USERNAME = "root"
    PASSWORD = "mysql"
    IP="192.168.0.15"
  end
  module AnalyticsDBWriteServer
    #this is the DBI ORM settings
    DATABASE = "zestadz_analytics"
    REDUCE_DATABASE="reduce_analytics"
    USERNAME = "root"
    PASSWORD = "mysql"
    IP="192.168.0.15"
end

module MailerSettings
    ADDRESS = "smtp.illian.net"
    PORT = 25
    DOMAIN = "zestadz.com"
    SENDER = "support@zestadz.com"
    RECIPIENTS = ["shujaudeen@mobile-worx.com"]
    SENDMAIL="error"
end
 
 module GetMaxId
 MAXID=750000
 REDUCER_MAX_ID=750000
 end
