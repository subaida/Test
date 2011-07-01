# * Copyright (c) 2003-2006 by CalChennai Mobile-worx  Pvt Ltd
# *
# * All rights reserved.
# *
# * 1059 Opal Way, Gardena, CA 90247 
# *
# * Y222, 2nd Floor, 2nd Avenue, Anna Nagar, Chennai 600040
# * www.mobile-worx.com
# *
# * INTELLECTUAL PROPERTY RIGHTS NOTICE
# * ALL IPR including that of source code, design documents, algorithms, flow documents,project plans,
# * reviews, images,architectural documents and other documents related to this document are held by
# * mobile-worx and any modification, alteration,re-engineering, reverse engineering or
# * any change targeted towards any kinds of use would be severely dealt with under the Federal Laws
# * of United States of America & Republic of India
# *
# *
# * Contact us at 
# * info@mobile-worx.com
# *
# * Notes
# * Version: 1.0

#~ require 'rubygems' 
require 'dbi'
require 'settings.rb'
#------------------------------------------------------------------------------------
#class Name: CarrierUpdator
#Purpose: The purpose of this class is to select the distinct carriers from temp_adv_carriers table from temp_analytics database and update the owners table in zestadz_analytics database.
#Version: 1.0
#Author: Shujauddeen
#Last-Modified: 29-10-2009
#-------------------------------------------------------------------------------------
class CarrierUpdator
    begin
        #------------------------------------------------------------------------------------
        #Method Name: updateCarrier
        #Purpose: This method is used to update the owners table in zestadz_analytics database.
        #Version: 1.0
        #Author: Md Shujauddeen
        #Last-Modified: 29-10-2009
        #-------------------------------------------------------------------------------------
        def updateCarrier
            begin
                @db_read = DBI.connect("DBI:MYSQL:#{AnalyticsDBReadServer::DATABASE}:#{AnalyticsDBReadServer::IP}","#{AnalyticsDBReadServer::USERNAME}","#{AnalyticsDBReadServer::PASSWORD}")
                @db_insert= DBI.connect("DBI:MYSQL:#{AnalyticsDBWriteServer::DATABASE}:#{AnalyticsDBWriteServer::IP}","#{AnalyticsDBWriteServer::USERNAME}","#{AnalyticsDBWriteServer::PASSWORD}")
                getHour=Time.now.strftime("%H")
                getDate=(Time.now-86400).strftime("%Y-%m-%d")
                @getCarrier=@db_read.execute("select distinct(owner) as carrier from temp_adv_carriers where delivery_date='#{getDate}' and delivery_hour=#{getHour}")
                @db_read.disconnect
                while a=@getCarrier.fetch do
                   if a["carrier"]!=nil && a["carrier"]!=''
                        carr=a["carrier"].gsub(/([,])/,'')
                        @max_id = @db_insert.select_one("select id from owners where carrier=\"#{carr}\"") 
                        if @max_id!=nil and @max_id.size>0
                        else
                              @db_insert.execute("INSERT INTO owners(carrier,operator,country) VALUES(\"#{carr}\",\"Other Carrier\",\"Others\")")
                        end #end of @max_id!=nil and @max_id.size>0
                    end #end of a["carrier"]!=nil && a["carrier"]!=''
                end #end of while
                @getCarrier=nil
                @db_insert.disconnect
            rescue Exception=>e
                puts"Exception occured in method: updateCarrier and error is :: #{e.to_s}"
            end
        end #end of method updateCarrier 
    rescue  Exception =>e
        puts"Exception occured in class: CarrierUpdator and error is :: #{e.to_s}"
    end
end #end of class CarrierUpdator  

  #------------------------------------------------------------------------------------
  #Class Name: Cronjob
  #Purpose: The purpose of the class is to extend CarrierUpdator class and to call updateCarrier method to begin the updation of carriers
  #Version: 1.0
  #Author: Md Shujauddeen
  #Last-Modified: 29-10-2009
  #-------------------------------------------------------------------------------------
class Cronjob < CarrierUpdator
    begin
        def invoke
            begin
		puts"Carrier Updator has been started..."
                begin
                    call_carr=CarrierUpdator.new
                    call_carr.updateCarrier
                    sleep(3600)
                end while(true)
            rescue Exception=>e
                puts"Exception occured in method: invoke and error is :: #{e.to_s}"
            end
        end
    rescue Exception=>e
    puts"Exception occured in class: Cronjob and error is :: #{e.to_s}"
    end
end
obj = Cronjob.new
obj.invoke


