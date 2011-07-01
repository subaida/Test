#require "dbi"
require 'rubygems'
require 'active_record'


class Billing

def che
    begin        
      @dbconn = DBI.connect("DBI:Mysql:zestadz_development:localhost", "root", "sqlworx@ch")
      return DATABASE_SUCCESS
    rescue Exception =>e
      puts "An exception has occurred while connecting to the database. The Exception is #{e.to_s}"
      return DATABASE_FAILED
end
end

end
a=Billing.new
a.che

