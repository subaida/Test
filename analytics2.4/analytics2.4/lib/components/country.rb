require 'dbi'
        begin
            #Connecting the database server
            #@db = Mysql.real_connect(ZDc::HOSTNAME,ZDc::USERNAME,ZDc::PASSWORD,ZDc::DATABASE) 
            @dbh = DBI.connect(ZDc::DATABASE,ZDc::USERNAME,ZDc::PASSWORD)
            report="Connected"
            @debug=true
            print "#{report}\n"
            #puts "INFO : GatewayServer :: Server started"
        rescue
            #If any occur to connecting the database server then the error stored in log file and return error message
            #return "PANIC: Gatewayserver :: DataBase not connecting..it may not be running or the password may be wrong.."
            report="Database is not connected,contact your development team"
            #puts "\nERROR : GatewayServer :: #{report}"
        end
          
          
        
