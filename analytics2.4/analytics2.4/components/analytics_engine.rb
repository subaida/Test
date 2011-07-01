require 'dbi'

class AnalyticsEngine
  
    def initialize
        @adclient_rec=Hash.new
        @ipaddress="192.168.0.15"
        @username="root"
        @password="mysql"
        @last30_date=(Time.now-2678400).strftime("%Y-%m-%d")
        @last7_date=(Time.now-518400).strftime("%Y-%m-%d")
        @ystday_date=(Time.now-86400).strftime("%Y-%m-%d")
        @today_date=Time.now.strftime("%Y-%m-%d")
    end
      
    def publisherDashboard(date,client_id)
            puts"----------#{date.inspect}-----------#{client_id}---------"
            puts"------------------pub analytics summary-----------------"
            #connect to analytics db
            db_conn = DBI.connect("DBI:MYSQL:zestadz_analytics:#{@ipaddress}",@username,@password)
            adclient_rec=db_conn.execute("select * from publisher_dashboards where delivery_date>='#{ @ystday_date}' and delivery_date<='#{@ystday_date}' and client_id=#{client_id}")        
            db_conn.disconnect #disconnect the db connection
            for i in adclient_rec
              puts i.inspect
            end
    end
      
    def pubUniqueVisitor
    end
    
    def pubChannelOverview
    end
    
    def pubCarrierOverview
    end
    
    def pubGeoLocation
    end
    
    def pubHandsetOverview
    end
    
    def pubDeviceModel
    end
    
    def pubMobileOs
    end
    
  end
  @last30_date=(Time.now-2678400).strftime("%Y-%m-%d")
  @last7_date=(Time.now-518400).strftime("%Y-%m-%d")
  @ystday_date=(Time.now-86400).strftime("%Y-%m-%d")
  @today_date=Time.now.strftime("%Y-%m-%d")
  #create object for the class and set it to drb.
  puts"please wait inmemory setter is initializing...."
  obj = AnalyticsEngine.new()
  puts"inmemory setter is started..."
  obj.publisherDashboard(@ystday_date,644)






