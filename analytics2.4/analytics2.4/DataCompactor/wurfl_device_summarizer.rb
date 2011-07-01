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
# * Note: This class read the adsdeliveries table in shard db and execute the report summary for all the advertiser and publisher.
# * Modified Date : 6/Jul/09
# * Modified Note : Required  the setting.rb file and used the username and password module.
 
require 'rexml/document'
require 'device_atlas.rb'
require 'dbi'
include REXML
#~ require 'rubygems' 
require 'settings.rb'
#------------------------------------------------------------------------------------
#class Name: WurflDevices
#Purpose: The purpose of this class is to select the distinct useragent from temp_adv_devicesproperties table from temp_analytics database and update the analytics_wurfl_analytics table in zestadz_analytics database.
#Version: 1.0
#Author: Shujauddeen
#Last-Modified: 30-04-2009
#-------------------------------------------------------------------------------------
class WurflDevices
    begin
        #------------------------------------------------------------------------------------
        #Method Name: updateUseragent
        #Purpose: This method is used to update the analytics_wurfl_devices table in zestadz_analytics database.
        #Version: 1.0
        #Author: Md Shujauddeen
        #Last-Modified: 23-03-2009
        #-------------------------------------------------------------------------------------
        def updateUseragent
            begin
                @db_read = DBI.connect("DBI:MYSQL:#{AnalyticsDBReadServer::DATABASE}:#{AnalyticsDBReadServer::IP}","#{AnalyticsDBReadServer::USERNAME}","#{AnalyticsDBReadServer::PASSWORD}")
                @db_insert= DBI.connect("DBI:MYSQL:#{AnalyticsDBWriteServer::DATABASE}:#{AnalyticsDBWriteServer::IP}","#{AnalyticsDBWriteServer::USERNAME}","#{AnalyticsDBWriteServer::PASSWORD}")
                getHour=Time.now.strftime("%H")
                getDate=(Time.now-86400).strftime("%Y-%m-%d")
                deviceproperties={'1'=>'midp','2'=>'mp3','3'=>'mpeg4','4'=>'3gpp','5'=>'3gpp2','6'=>'wmv','7'=>'aacInVideo','8'=>'aacLtpInVideo','9'=>'amrInVideo','10'=>'awbInVideo','11'=>'h263Type0InVideo','12'=>'h263Type3InVideo','13'=>'mpeg4InVideo','14'=>'qcelpInVideo','15'=>'midiPolyphonic','16'=>'osSymbian','17'=>'osWindows','18'=>'osRim','19'=>'osLinux','20'=>'osOsx'}
                device_atlas = DeviceAtlas.new
                tree = device_atlas.getTreeFromFile("api.json")
                @getUA=@db_read.execute("select distinct(user_agent) as user_agent from temp_adv_devicesproperties where delivery_date='#{getDate}' and delivery_hour=#{getHour.to_i}")
                @db_read.disconnect
                for ua in @getUA
                    @max_id = @db_insert.select_one("select id from analytics_wurfl_devices where user_agent=\"#{ua}\"") 
                    if @max_id!=nil and @max_id.size>0
                        property = device_atlas.getPropertiesAsTyped(tree, "#{ua}")
                        vendor=property['vendor']
                        model=property['model']
                        if vendor==nil && model==nil
                        else
                            check_handset=@db_insert.select_one("select id from analytics_wurfl_devices where vendor=\"#{vendor}\" and model=\"#{model}\"") 
                            if  check_handset!=nil and check_handset.size>0
                            else
                                if property["isRobot"]==true
                                    browser = "Robot"
                                elsif property["isBrowser"]==true
                                    browser = "Browser"
                                elsif property["mobileDevice"]==true
                                    browser = "mobileDevice"
                                else
                                    browser='nil'
                                end
                                @db_insert.execute("UPDATE analytics_wurfl_devices set vendor=\"#{vendor}\",model=\"#{model}\",browser_type=\"#{browser}\" where id=\"#{@max_id[0]}\"")
                                for dev in 1..deviceproperties.size
                                    getproperty=deviceproperties["#{dev}"]
                                    if property["#{getproperty}"]!=nil && property["#{getproperty}"]!=false && property["#{getproperty}"]!='false'
                                        check_capability=@db_insert.select_one("select id from analytics_wurfl_capabilities where wurfl_device_id=\"#{@max_id[0]}\" and name=\"#{getproperty}\"") 
                                        if check_capability!=nil and check_capability.size>0
                                        else
                                            @db_insert.execute("INSERT INTO analytics_wurfl_capabilities(wurfl_device_id,name,value) VALUES(\"#{@max_id[0]}\",\"#{getproperty}\",\"#{ property["#{getproperty}"]}\")")
                                        end
                                    end #end of property["#{getproperty}"]!=nil && property["#{getproperty}"]!=false 
                                end # end of dev in 1..deviceproperties.size
                            end # end of  check_handset.size>0
                        end
                    else
                        property = device_atlas.getPropertiesAsTyped(tree, "#{ua}")
                        vendor=property['vendor']
                        model=property['model']
                        if property["isRobot"]==true
                            browser = "Robot"
                        elsif property["isBrowser"]==true
                            browser = "Browser"
                        elsif property["mobileDevice"]==true
                            browser = "mobileDevice"
                        else
                            browser='nil'
                        end
                        if vendor==nil && model==nil
                            @db_insert.execute("INSERT INTO analytics_wurfl_devices(user_agent,vendor,model,browser_type) VALUES(\"#{ua}\",\"#{vendor}\",\"#{model}\",\"#{browser}\")")
                            @id = @db_insert.select_one("select max(id) as parentid from analytics_wurfl_devices") 
                            for j in 1..deviceproperties.size
                                getproperty=deviceproperties["#{j}"]
                                if property["#{getproperty}"]!=nil && property["#{getproperty}"]!=false && property["#{getproperty}"]!='false'
                                    @db_insert.execute("INSERT INTO analytics_wurfl_capabilities(wurfl_device_id,name,value) VALUES(\"#{@id[0]}\",\"#{getproperty}\",'#{ property["#{getproperty}"]}')")
                                end
                            end
                        else
                            check_handset=@db_insert.select_one("select id from analytics_wurfl_devices where vendor=\"#{vendor}\" and model=\"#{model}\"") 
                            if check_handset!=nil and check_handset.size>0
                            else
                                @db_insert.execute("INSERT INTO analytics_wurfl_devices(user_agent,vendor,model,browser_type) VALUES(\"#{ua}\",\"#{vendor}\",\"#{model}\",\"#{browser}\")")
                                @id = @db_insert.select_one("select max(id) as parentid from analytics_wurfl_devices") 
                                for j in 1..deviceproperties.size
                                    getproperty=deviceproperties["#{j}"]
                                    if property["#{getproperty}"]!=nil && property["#{getproperty}"]!=false && property["#{getproperty}"]!='false'
                                        @db_insert.execute("INSERT INTO analytics_wurfl_capabilities(wurfl_device_id,name,value) VALUES(\"#{@id[0]}\",\"#{getproperty}\",'#{ property["#{getproperty}"]}')")
                                    end
                                end
                            end  #end of check_handset!=nil and check_handset.size>0
                        end # end of vendor==nil && model==nil
                    end #end of @max_id!=nil and @max_id.size>0
                  end #end of for ua in @getUA
                  @db_insert.disconnect
            rescue Exception=>e
                puts"Exception occured in method: updateUseragent and error is :: #{e.to_s}"
            end
        end #end of updateUseragent method
    rescue  Exception =>e
        puts"Exception occured in class: WurflDevices and error is :: #{e.to_s}"
    end
end

  #------------------------------------------------------------------------------------
  #Class Name: Cronjob
  #Purpose: The purpose of the class is to extend WurflDevices class and to call updateUseragent method to begin the updation of useragent
  #Version: 1.0
  #Author: Ayshwarya
  #Last-Modified: 30-04-2009
  #-------------------------------------------------------------------------------------
class Cronjob < WurflDevices
    begin
    puts"Wurfl summarizer has started...."
        def invoke
            begin
                begin
                    call_wurlf=WurflDevices.new
                    call_wurlf.updateUseragent
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
