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
require 'logger'
require 'dbi'
require 'rubygems' 
require 'mongo'
require 'nkf'
include Mongo
require 'yaml'
require 'email_component.rb'
require 'time'
require 'date'
require 'settings.rb'
require 'mongodb_query_settings.rb'
require 'us_geodetails.rb'
require 'why_no_ads.rb'
#~ require 'fileutils'  
#setting the path to load the config files
PATH= PathSettings::DB_TEMP_FILE
PATH_MASTER= PathSettings::DB_MASTER_FILE



#------------------------------------------------------------------------------------
#class Name: MongoDBSummarizer
#Purpose: The purpose of this class is to select the mongodb_transactions table from shard database. If no rows are available, then set the status for transaction. Then read all the tables, do the calculations and insert the final results into MongoDB summarizer. Finnaly update the status in mongodb_transactions table resides in all shard database.
#Version: 1.0
#Author: Shujauddeen
#Last-Modified: 30-04-2009
#-------------------------------------------------------------------------------------
class MongoDBSummarizer
    #initialize global variable for creating seperate thread in the cron job.
    $status  = "true"
    #initialize constant variables used as the part of table names.
    EVEN_TABLE="_even_"
    ODD_TABLE = "_odd_"
    #initialize constant variables used in acquire lock method.
    ACQUIRE_LOCK="GET_LOCK"
    RELEASE_LOCK="RELEASE_LOCK"
    REPORTS_SUMMARIZER = "mongodb_reports_string"
    REPORTS_RECOVERY = "mongodb_recovery_string"
    #$us_city_obj=UsGeodetails.new
    #$us_city_obj.setState
    #------------------------------------------------------------------------------------
    #Method Name: initilaize
    #Purpose: This action is to call the re_initialize method for initializing the values to global variables.
    #Version: 1.0
    #Author: Shujauddeen
    #Last-Modified: 12-10-2010
    #-------------------------------------------------------------------------------------
    def initialize(*args)
        begin
		@us_city_obj=nil
		@index={'A'=>0,'B'=>1,'C'=>2,'D'=>3,'E'=>4,'F'=>5,'G'=>6,'H'=>7,'I'=>8,'J'=>9,'K'=>10,'L'=>11,'M'=>12,'N'=>13,'O'=>14,'P'=>15,'Q'=>16,'R'=>17,'S'=>18,'T'=>19,'U'=>20,'V'=>21,'W'=>22,'X'=>23,'Y'=>24,'Z'=>25}
		#$us_city_obj.setState
		#puts $us_city_obj.findState("KAKE")
            #puts "MongoDB summarizer INITIALIZE METHOD"
            #call the re_initialize method for initializing the values to global variables.
            @country_details={"AS.NP"=>"NEPAL", "AS.TH"=>"THAILAND", "AF.KE"=>"KENYA", "AF.NA"=>"NAMIBIA", "AF.LY"=>"LIBYAN ARAB JAMAHIRIYA", "EU.MT"=>"MALTA", "EU.SM"=>"SAN MARINO", "SA.PE"=>"PERU", "AS.TJ"=>"TAJIKISTAN", "EU.FI"=>"FINLAND", "EU.IE"=>"IRELAND", "AS.AM"=>"ARMENIA", "AS.GE"=>"GEORGIA", "AF.NE"=>"NIGER", "EU.PT"=>"PORTUGAL", "AF.RW"=>"RWANDA", "ME.YE"=>"YEMEN", "AS.TM"=>"TURKMENISTAN", "AF.NG"=>"NIGERIA", "NA.BM"=>"BERMUDA", "AS.KZ"=>"KAZAKHSTAN", "AF.ER"=>"ERITREA", "AF.BW"=>"BOTSWANA", "ME.LB"=>"LEBANON", "EU.CS"=>"SERBIA", "AS.TP"=>"East Timor", "EU.FO"=>"FAROE ISLANDS", "CA.HN"=>"HONDURAS", "AF.ET"=>"ETHIOPIA", "AF.KM"=>"COMOROS", "SA.VE"=>"VENEZUELA", "EU.LI"=>"LIECHTENSTEIN", "SA.GY"=>"GUYANA", "CA.NI"=>"NICARAGUA", "AF.TD"=>"CHAD", "EU.BA"=>"BOSNIA AND HERZEGOVINA", "EU.FR"=>"FRANCE", "OC.UM"=>"UNITED STATES MINOR OUTLYING ISLANDS", "NA.BS"=>"BAHAMAS", "CA.BZ"=>"BELIZE", "SA.CL"=>"CHILE", "EU.UA"=>"UKRAINE", "AF.GA"=>"GABON", "ME.IL"=>"ISRAEL", "AF.TG"=>"TOGO", "EU.BE"=>"BELGIUM", "EU.CY"=>"CYPRUS", "NA.US"=>"UNITED STATES", "AS.TW"=>"TAIWAN, PROVINCE OF CHINA", "OC.NC"=>"NEW CALEDONIA", "AF.ZA"=>"SOUTH AFRICA", "EU.CZ"=>"CZECH REPUBLIC", "EU.IS"=>"ICELAND", "SA.CO"=>"COLOMBIA", "AS.AZ"=>"AZERBAIJAN", "SA.FK"=>"FALKLAND ISLANDS (MALVINAS)", "EU.BG"=>"BULGARIA", "EU.IT"=>"ITALY", "AS.JP"=>"JAPAN", "AS.PH"=>"PHILIPPINES", "OC.KI"=>"KIRIBATI", "AS.MM"=>"MYANMAR", "SA.SR"=>"SURINAME", "ME.SY"=>"SYRIAN ARAB REPUBLIC", "OC.NF"=>"NORFOLK ISLAND", "EU.EE"=>"ESTONIA", "NA.KN"=>"SAINT KITTS AND NEVIS", "AS.MN"=>"MONGOLIA", "NA.TC"=>"TURKS AND CAICOS ISLANDS", "AF.DJ"=>"DJIBOUTI", "ME.IQ"=>"IRAQ", "AS.MO"=>"MACAO", "AF.AO"=>"ANGOLA", "AS.PK"=>"PAKISTAN", "AS.SG"=>"SINGAPORE", "AF.GH"=>"GHANA", "ME.IR"=>"IRAN, ISLAMIC REPUBLIC OF", "EU.LT"=>"LITHUANIA", "NA.HT"=>"HAITI", "SA.PY"=>"PARAGUAY", "AF.MA"=>"MOROCCO", "AF.TN"=>"TUNISIA", "NA.AG"=>"ANTIGUA AND BARBUDA", "EU.LU"=>"LUXEMBOURG", "EU.LV"=>"LATVIA", "ME.BH"=>"BAHRAIN", "ME.OM"=>"OMAN", "NA.AI"=>"ANGUILLA", "EU.RO"=>"ROMANIA", "AS.ID"=>"INDONESIA", "AF.GM"=>"GAMBIA", "NA.GD"=>"GRENADA", "AS.LA"=>"LAO PEOPLES DEMOCRATIC REPUBLIC", "AS.MV"=>"MALDIVES", "CA.PA"=>"PANAMA", "AF.GN"=>"GUINEA", "AF.MG"=>"MADAGASCAR", "AS.PS"=>"PALESTINIAN TERRITORY, OCCUPIED", "AF.ZM"=>"ZAMBIA", "NA.AN"=>"NETHERLANDS ANTILLES", "AS.CN"=>"CHINA", "SA.EC"=>"ECUADOR", "EU.RU"=>"RUSSIAN FEDERATION", "AS.MY"=>"MALAYSIA", "AF.GQ"=>"EQUATORIAL GUINEA", "OC.NR"=>"NAURU", "NA.KY"=>"CAYMAN ISLANDS", "AS.VN"=>"VIET NAM", "AF.SC"=>"SEYCHELLES", "OC.TK"=>"TOKELAU", "NA.DM"=>"DOMINICA", "AF.ML"=>"MALI", "AF.SD"=>"SUDAN", "AF.CD"=>"CONGO, THE DEMOCRATIC REPUBLIC OF THE", "OC.NU"=>"NIUE", "EU.ES"=>"SPAIN", "NA.DO"=>"DOMINICAN REPUBLIC", "AF.TZ"=>"TANZANIA, UNITED REPUBLIC OF", "NA.GL"=>"GREENLAND", "AF.DZ"=>"ALGERIA", "ME.QA"=>"QATAR", "EU.AD"=>"ANDORRA", "OC.TO"=>"TONGA", "CA.GT"=>"GUATEMALA", "AF.CF"=>"CENTRAL AFRICAN REPUBLIC", "OC.AS"=>"AMERICAN SAMOA", "AF.GW"=>"GUINEA-BISSAU", "EU.BY"=>"BELARUS", "EU.HR"=>"CROATIA", "AS.IN"=>"INDIA", "AF.CG"=>"CONGO", "SA.BO"=>"BOLIVIA", "AS.IO"=>"BRITISH INDIAN OCEAN TERRITORY", "AS.LK"=>"SRI LANKA", "NA.TT"=>"TRINIDAD AND TOBAGO", "OC.AU"=>"AUSTRALIA", "AF.MR"=>"MAURITANIA", "OC.NZ"=>"NEW ZEALAND", "AF.ZW"=>"ZIMBABWE", "NA.AW"=>"ARUBA", "NA.GP"=>"GUADELOUPE", "EU.NL"=>"NETHERLANDS", "CA.PM"=>"SAINT PIERRE AND MIQUELON", "EU.HU"=>"HUNGARY", "AS.BD"=>"BANGLADESH", "NA.JM"=>"JAMAICA", "AF.CI"=>"COTE D IVOIRE", "AF.SL"=>"SIERRA LEONE", "EU.DE"=>"GERMANY", "NA.CA"=>"CANADA", "OC.MH"=>"MARSHALL ISLANDS", "EU.GB"=>"UNITED KINGDOM", "SA.BR"=>"BRAZIL", "EU.NO"=>"NORWAY", "ME.AE"=>"UNITED ARAB EMIRATES", "AF.MU"=>"MAURITIUS", "AF.SN"=>"SENEGAL", "OC.SB"=>"SOLOMON ISLANDS", "OC.TV"=>"TUVALU", "AF.SO"=>"SOMALIA", "OC.PF"=>"FRENCH POLYNESIA", "EU.AL"=>"ALBANIA", "OC.WS"=>"SAMOA", "AQ.AQ"=>"ANTARCTICA", "AF.CM"=>"CAMEROON", "OC.PG"=>"PAPUA NEW GUINEA", "NA.VC"=>"SAINT VINCENT AND THE GRENADINES", "AF.MW"=>"MALAWI", "EU.DK"=>"DENMARK", "OC.GU"=>"GUAM", "NA.MQ"=>"MARTINIQUE", "AF.MZ"=>"MOZAMBIQUE", "EU.JE"=>"JERSEY", "EU.GI"=>"GIBRALTAR", "NA.VG"=>"VIRGIN ISLANDS, U.S.", "AF.ST"=>"SAO TOME AND PRIMCIPE", "AS.BN"=>"BRUNEI DARUSSALAM", "NA.MS"=>"MONTSERRAT", "OC.MP"=>"NORTHERN MARIANA ISLANDS", "SA.UY"=>"URUGUAY", "EU.MC"=>"MONACO", "CA.CR"=>"COSTA RICA", "NA.VI"=>"VIRGIN ISLANDS", "ME.KW"=>"KUWAIT", "EU.MD"=>"MOLDOVA, REPUBLIC OF", "EU.TR"=>"TURKEY", "NA.PR"=>"PUERTO RICO", "AF.CV"=>"CAPE VERDE", "EU.AT"=>"AUSTRIA", "OC.CK"=>"COOK ISLANDS", "CA.SV"=>"EL SALVADOR", "NA.LC"=>"SAINT LUCIA", "AS.HK"=>"HONG KONG", "AS.KG"=>"KYRGYZSTAN", "NA.MX"=>"MEXICO", "AF.RE"=>"REUNION", "AS.BT"=>"BHUTAN", "AS.KH"=>"CAMBODIA", "AF.SZ"=>"SWAZILAND", "AF.BF"=>"BURKINA FASO", "OC.FJ"=>"FIJI", "AF.YT"=>"MAYOTTE", "EU.AX"=>"ALAND ISLANDS", "SA.GF"=>"FRENCH GUIANA", "EU.GR"=>"GREECE", "EU.MK"=>"MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF", "EU.VA"=>"HOLY SEE (VATICAN CITY STATE)", "OC.FM"=>"MICRONESIA, FEDERATED STATES OF", "EU.SE"=>"SWEDEN", "AF.BI"=>"BURUNDI", "AF.LR"=>"LIBERIA", "ME.SA"=>"SAUDI ARABIA", "AF.UG"=>"UGANDA", "OC.PW"=>"PALAU", "NA.CU"=>"CUBA", "AF.BJ"=>"BENIN", "AF.EG"=>"EGYPT", "AF.LS"=>"LESOTHO", "NA.BB"=>"BARBADOS", "SA.AR"=>"ARGENTINA", "AS.AF"=>"AFGHANISTAN", "EU.MO"=>"MONTENEGRO", "AS.KP"=>"KOREA - NORTH", "ME.JO"=>"JORDAN", "EU.PL"=>"POLAND", "AS.UZ"=>"UZBEKISTAN", "EU.CH"=>"SWITZERLAND", "EU.SI"=>"SLOVENIA", "AS.KR"=>"KOREA", "OC.VU"=>"VANUATU", "EU.SK"=>"SLOVAKIA"}
            config = YAML::load(File.open("#{PATH}"))
            database_name = config[:active_server][:active_database]
            @records_array = []
            @error_selection_summarizer = []
            @error_insertion_summarizer = []
            @error_updation_summarizer = []
            
            @records_recovery_array = []
            @error_selection_recovery = []
            @error_insertion_recovery = []
            @error_updation_recovery = []          
            if database_name == "single" or args[0] == "parallel"
                @ant_process = "single"
                @ant_process_rec = "single"
                @maxdb =  config[:localhost][:max_databases].to_i
                @start_db =  config[:localhost][:start_db].to_i
                @start_even_table  =  config[:localhost][:start_even_table].to_i
                @start_odd_table  =  config[:localhost][:start_odd_table].to_i
                @max_even_table  =  config[:localhost][:max_even_tables].to_i
                @max_odd_table  =  config[:localhost][:max_odd_tables].to_i
                @master_ip = config[:localhost][:master_ip]
                @master_db = config[:localhost][:master_db]
                @analytics_ip=AnalyticsDBServer::IP
                @analytics_db=AnalyticsDBServer::DATABASE
                @max_ip  =  config[:localhost][:max_ip].to_i
                @ip_addr  =  config[:localhost][:ip_addr]
                @shard_db_name = config[:localhost][:shard_database_name]
                @shard_table_name = config[:localhost][:table_name]
                @available_server = config[:localhost][:available_server]
            elsif database_name == "multiple"
                @ant_process = "multiple"
                @ant_process_rec = "multiple"
                @maxdb =  config[:old_localhost][:old_max_databases].to_i
                @start_db =  config[:old_localhost][:old_start_db].to_i
                @start_even_table  =  config[:old_localhost][:old_start_even_table].to_i
                @start_odd_table  =  config[:old_localhost][:old_start_odd_table].to_i
                @max_even_table  =  config[:old_localhost][:old_max_even_tables].to_i
                @max_odd_table  =  config[:old_localhost][:old_max_odd_tables].to_i
                @master_ip = config[:old_localhost][:old_master_ip]
                @master_db = config[:old_localhost][:old_master_db]
                @analytics_ip=AnalyticsDBServer::IP
                @analytics_db=AnalyticsDBServer::DATABASE
                @max_ip  =  config[:old_localhost][:old_max_ip].to_i
                @ip_addr  =  config[:old_localhost][:old_ip_addr]
                @shard_db_name = config[:old_localhost][:old_shard_database_name]
                @shard_table_name = config[:old_localhost][:old_table_name]
                @available_server = config[:old_localhost][:old_available_server]
            else
                puts "Command not matched in MongoDB summarizer re_initialize method.."           
            end
        rescue Exception => e
            puts "Error in ClassName:MongoDBSummarizer MethodName:initialize ErrInfo:#{e.to_s} " 
        end      
    end  

    def setCityData(us_city_obj)
      @us_city_obj=us_city_obj
      #puts @us_city_obj.inspect
    end    
    #-------------------------------------------------------------------------------------
    #Method Name: acquire_lock
    #Purpose: The purpose of this method is to acquire the lock and return the values.
    #Version: 1.0
    #Author: Ayshwarya
    #Last-Modified: 30-04-2009
    #--------------------------------------------------------------------------------------
    def acquire_lock(dbconn_reports_transaction,get_or_release, reports_or_recovery_string)
        begin
            if get_or_release == ACQUIRE_LOCK
                @lock_obj = dbconn_reports_transaction.select_one("SELECT IS_FREE_LOCK('#{reports_or_recovery_string}')" )
                if @lock_obj[0] == 1
                    @get_lock_stat = dbconn_reports_transaction.select_one("SELECT GET_LOCK('#{reports_or_recovery_string}',10)")
                else
                    executed = false
                    begin # begin while loop
                        #puts "ROTATE LOOP"
                        @lock_obj = dbconn_reports_transaction.select_one("SELECT IS_FREE_LOCK('#{reports_or_recovery_string}')" )
                        if @lock_obj[0] == 1
                          executed = true   
                          @get_lock_stat = dbconn_reports_transaction.select_one("SELECT GET_LOCK('#{reports_or_recovery_string}',10)")
                        else
                          executed = false
                        end # end of @lock_obj[0] == 1 inside begin loop
                        sleep(0.1)
                    end while (executed == false)  
                end  # end of @lock_obj[0] == 1
                return @get_lock_stat[0]
            elsif get_or_release == RELEASE_LOCK
                #puts "RELEASE lock method"
                dbconn_reports_transaction.select_one("SELECT RELEASE_LOCK('#{reports_or_recovery_string}')")
            end        
        rescue Exception =>e
          puts "Error in ClassName: MongoDBSummarizer MethodName: acquire_lock ErrInfo:#{e.to_s}" 
        end
    end  #end of method acquire_lock
      
    #-------------------------------------------------------------------------------------
    #Method Name: reports
    #Purpose: This action is to load the values form config files. If the current hour is even hour, does the process for the odd hour and vice versa. If no records are there for the whole day, start inserting records from 00 hours for even hour table, 01 for odd hour table. If any one record is lost  in the transaction, insert the lost record alone without making any changes in other records.
    #Version: 1.0
    #Author: Md Shujauddeen
    #Last-Modified by: Md Shujauddeen
    #Last-Modified: 30-04-2009
    #--------------------------------------------------------------------------------------
  def reports
      begin
          obj_tempQuery=MongodbQuerySetting.new()
          logger=Logger.new("mongodb_logs.log","daily")
          curr_date=Time.now.strftime("%Y-%m-%d %H:%M:%S") #getting current year, month and date
          now_date=Date.today
          curr_time=Time.now
          curr_datetime = curr_time.strftime("%Y-%m-%d %H:%M:%S")
          check_time = curr_time.strftime("%H").to_i # Getting the current time
          #declare this variable to take the current time for comparing end time to this variable.
          check_curr_time = Time.now.strftime("%Y-%m-%d %H:%M:%S")
         @records_array_summarizer = []
          analytics_table_arr=['fraud_clicks','why_no_ads','owner_summaries','wifi_summaries','ip_details','campaigns_breakdown','click_logs','us_geostats','pub_us_geostats']
          # analytics_table_arr=['us_geostats']
          #~ analytics_table_arr=['fraud_clicks','ip_details']
          # If current time is an odd hour, do the process for even hour table
          if check_time % 2 == 1
              @start_table = @start_even_table # Assigning the @start_even_table value to @start_table
              @max_table = @max_even_table # Assigning the @max_even_table value to @max_table
              @table_name = "#{EVEN_TABLE}" # Assign _even_ to table_name
              # If current hour is even hour, do the process for odd hour table
          elsif check_time % 2 == 0
              @start_table = @start_odd_table # Assigning the @start_odd_table value to @start_table
              @max_table = @max_odd_table # Assigning the @max_odd_table value to @max_table
              @table_name = "#{ODD_TABLE}"  # Assign _odd_ to table_name
          end
          ynoads = WhyNoAds.new.create
          #Establish a connection to master databse
          for ip in @available_server
              for db in @start_db..@maxdb
                  for table_number in @start_table..@max_table
                      for analytics_table in analytics_table_arr
                          begin
                              # Here we are going to establish a connection for shard table to check the availablitiy of rows for the even hour table. 
                              @dbconn_selection = DBI.connect("DBI:MYSQL:#{@shard_db_name}#{db}:#{ip}", WriteDBServer::USERNAME, WriteDBServer::PASSWORD)
                              tx_illegal = "false"
                              get_lock= acquire_lock(@dbconn_selection ,ACQUIRE_LOCK,REPORTS_SUMMARIZER)
                              if(get_lock == 1)
                                  #Check if any records is available from shard database, check any records having the status as Table is locked for reading' or Transaction completed or Transaction completed for zero records. 
                                  select_all="select * from mongodb_transactions where ip='#{ip}' and database_name='#{@shard_db_name}#{db}' and table_name='#{@shard_table_name}#{@table_name}#{table_number}' and analytics_table='#{analytics_table}' and (status='Transaction completed' or status = 'Transaction completed for zero record' or status = 'Table is locked for reading') order by id desc limit 1"
                                  select_status_transaction =@dbconn_selection.select_all(select_all)
                                  last_hour_datetime = Time.now-3600 # Getting the current time - 1 hour
                                  if select_status_transaction.length == 0 # If no records are there for the whole day.
                                      #If current time is an odd hour, do the process for even hour table.
                                      start_date = "#{now_date} 00:00:00" # Get the current date and assign 00:00:00 to start_date
                                      last_hour = last_hour_datetime.strftime("%H").to_i # Getting the hour from current_time - 1 hour 
                                      end_date = "#{now_date} 00:59:59" # Get the current date and last_hour and assign :59:59 to end_date
                                      #If records are there in mongodb_transactions 
                                  elsif(select_status_transaction.length > 0) 
                                      select_status_transaction[0]['end_datetime'] = select_status_transaction[0]['end_datetime'].to_s
                                      increment_hour = select_status_transaction[0]['end_datetime']
                                      last_tx_datetime = Time.parse(increment_hour) + 1 # Incrementing the end datetime by 1 sec.
                                      start_date = last_tx_datetime.strftime("%Y-%m-%d %H:%M:%S") # Get the date and time from end_datetime collumn
                                      end_date =  last_tx_datetime.strftime("%Y-%m-%d %H:59:59") # Get the date and hour from current_time - 1 hour 
                                  end # end of select_status_transaction.length == 0
                              else
                                  tx_illegal = "true"
                              end  # end of @get_lock_stat[0] == 1
                              # If start_date is greater than end_date, while incrementing end_datetime, if it exceeds the current date
                              end_date_plus_five_min = Time.parse(end_date) + 600 
                              chk_end_date_plus_five_min = end_date_plus_five_min.strftime("%Y-%m-%d %H:%M:%S")
                              if tx_illegal == "true" or start_date >  end_date or end_date >= curr_datetime or chk_end_date_plus_five_min > check_curr_time
                                  acquire_lock(@dbconn_selection ,RELEASE_LOCK,REPORTS_SUMMARIZER)
                                  @dbconn_selection.disconnect if @dbconn_selection != nil
                                  #puts "===== TX ILLEGAL Lock is released===================================="
                              else 
                                  #Insert the record into the mongodb_transactions which is available in all shard database Set the status as "Table is locked for reading". 
                                  insert_transaction_query = "insert into mongodb_transactions(ip,database_name,table_name,analytics_table,start_datetime, end_datetime, status, date) values('#{ip}', '#{@shard_db_name}#{db}', '#{@shard_table_name}#{@table_name}#{table_number}','#{analytics_table}','#{start_date}', '#{end_date}', 'Table is locked for reading', '#{curr_date}')"
                                  insert_status = @dbconn_selection.do(insert_transaction_query)
                                  acquire_lock(@dbconn_selection ,RELEASE_LOCK,REPORTS_SUMMARIZER)
                                  time_taken=Time.now # Fetch the current time 'seconds' 
                                  #After the status has been set, select the required collumns from different shard databases resides in various ip addresses. And we are checking a condition for delivery time for the last one hour. Basesd on that condition it fetches list of rows, in that we are calculating the total number of clicks, impressions, cost and publisher revenue
                                  select_records = "false"
                                  @dbconn_selection.disconnect if @dbconn_selection != nil
                                  #iterate to get appropriate queries to select/insert record in to analytics table
                                  begin
                                      #puts "Select statement in Reports ................"
                                      @dbconn_selection = DBI.connect("DBI:MYSQL:#{@shard_db_name}#{db}:#{ip}", WriteDBServer::USERNAME, WriteDBServer::PASSWORD)
                                      select_stat=obj_tempQuery.selectMongodbQuery(@shard_table_name,@table_name,table_number,start_date,end_date,analytics_table)
                                      select_query = @dbconn_selection.select_all(select_stat)
                                      select_records = "true"
                                      if analytics_table=='why_no_ads'
                                          if ynoads==nil or ynoads==''
                                              select_records = "false"
                                          end
                                      end
                                  rescue Exception =>e  
                                      puts "Error in ClassName: MongoDBSummarizer MethodName: reports while selcting records ErrInfo:#{e.to_s}" 
                                      puts @error_selection_summarizer << "<p style='color:#FF0000'> ERROR :: Analytics Summarizer method (reports) during Selection...<br />Project: ANALYTICS_SHARDING<br />Job: MongoDBSummarizer<br />Ip address is: #{ip}<br />Database: #{@shard_db_name}#{db}<br />Table: #{@shard_table_name}#{@table_name}#{table_number}<br />Start_time: #{start_date}<br />End_time: #{end_date}<br />Failure_Time:#{Time.now}<br />Exception is : #{e.to_s}<br /></p>"
                                  ensure
                                      update_flag='false'
                                      begin
                                          if select_records=='true'
                                              if(select_query.length ==0) # If records is not there in MongoDB summarizer
                                                  status_val = "Transaction completed for zero record" # set the transaction status as "Transaction completed for zero record"
                                              elsif (select_query.length > 0)
                                                  status_val ="Transaction completed" # set the transaction status as "Transaction completed"
                                              end
                                              fetch_new_time=Time.now # Fetch the current time again
                                              new_time_taken = fetch_new_time-time_taken # Calculating the difference between two 'seconds'
                                              update_transaction_status = "update mongodb_transactions set status = '#{status_val}', time_taken = #{new_time_taken.to_i} where ip = '#{ip}' and database_name = '#{@shard_db_name}#{db}' and table_name = '#{@shard_table_name}#{@table_name}#{table_number}' and start_datetime='#{start_date}' and end_datetime='#{end_date}' and status = 'Table is locked for reading' and date = '#{curr_date}'"
                                              campaign_details=campaign_name_bid() if (analytics_table=='fraud_clicks' || analytics_table=='wifi_summaries')
                                              carrier_details=owner_details() if (analytics_table=='owner_summaries')
                                              if (analytics_table=='fraud_clicks' || analytics_table=='wifi_summaries')
                                                  if campaign_details!=nil
                                                      update_status = @dbconn_selection.prepare(update_transaction_status)
                                                      update_status.execute
                                                      update_flag='true'
                                                  end
                                              elsif analytics_table=='owner_summaries'
                                                  if carrier_details!=nil
                                                      update_status = @dbconn_selection.prepare(update_transaction_status)
                                                      update_status.execute
                                                      update_flag='true'
                                                  end
                                              else
                                                  update_status = @dbconn_selection.prepare(update_transaction_status)
                                                  update_status.execute
                                                  update_flag='true'
                                              end
                                          end
                                      rescue Exception=>e
                                          update_flag='false'
                                          puts "Error occured while updating the analytics transaction table::#{e}"
                                      end
                                          @dbconn_selection.disconnect if @dbconn_selection != nil
                                  end
                                  begin
                                      if select_records=='true' and update_flag=='true' 
                                          mongo_db  = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
                                          if (analytics_table =='ip_details' and (Time.parse(start_date).strftime('%H:%M:%S'))=='00:00:00')
                                              coll_del = mongo_db.drop_collection("#{analytics_table}_#{(Time.parse(start_date)-172800).strftime('%Y-%m-%d')}")
                                          end
                                          coll_del=nil
                                          reason='UNKNOWN'
                                          coll = mongo_db.collection(analytics_table) if analytics_table !='ip_details'
                                          coll = mongo_db.collection("#{analytics_table}_#{Time.parse(start_date).strftime('%Y-%m-%d')}") if (analytics_table =='ip_details') 
                                          coll.create_index([['pub_id', Mongo::ASCENDING],['client_id', Mongo::ASCENDING],['campaign_id', Mongo::ASCENDING],['country_name',Mongo::ASCENDING]]) if (analytics_table =='ip_details' and (Time.parse(start_date).strftime('%H:%M:%S'))=='00:00:00')  
                                          if (select_query.length > 0) 
                                              @mail_status_insert = "true"
                                              #caid--campaign_id, cid--client_id, dt--delivery_time, imp--impression, ck--clicks, spt-amount spent, rev-- revenue, ip-- ipaddress, ua-- useragent
                                              for report in select_query # Insert the selected rows one by one into the MongoDB summarizer table resides in master database. 
                                                  begin
                                                      coll.update({"campaign_id" => "#{report['campaign_id']}", "client_id" => "#{report['client_id']}", "pub_id" => "#{report['pub_id']}","delivery_time" => "#{Time.parse(report['delivery_time'].to_s).strftime('%Y-%m-%d')}","campaign_name"=>campaign_details[report['campaign_id']]==nil ? "Unknown" : "#{campaign_details[report['campaign_id']][0]}","bid"=>campaign_details[report['campaign_id']]==nil ? "0.0" : "#{campaign_details[report['campaign_id']][1]}","status"=>"open"}, { "$inc" => { "fraud_click"=> report['fraud_click'].to_i}} ,:upsert => true) if analytics_table=='fraud_clicks'
                                                      coll.update({"client_id" => "#{report['client_id']}", "pub_id" => "#{report['pub_id']}","delivery_time" => "#{Time.parse(report['delivery_time'].to_s).strftime('%Y-%m-%d')}","country_name"=>"#{@country_details["#{report['continent_code']}.#{report['country_code']}"]}"}, { "$inc" => { "impressions"=> report['impressions'].to_i}} ,:upsert => true) if analytics_table=='unfilled_ips'
                                                      if (analytics_table=='why_no_ads')
                                                          if (report['reason']=='NO ADS' or report['reason']=='NO_ADS')  
                                                              if (ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]!=nil and ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]!='')
                                                                  if (ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]['carrier']!=nil and ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]['carrier']!='')
                                                                      if (ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]['carrier'].include?(report['carrier_name'].to_s.upcase) or ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]['carrier'].include?("ALL"))
                                                                          if (ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]['devices']!=nil and ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]['devices']!='')
                                                                              if (ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]['devices'].include?(report['device_name'].to_s.upcase) or ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]['devices'].include?('ALL DEVICES'))
                                                                                  if (ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]['models']!=nil and ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]['models']!='')
                                                                                      if (ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]['models'].include?("#{report['device_name'].to_s.upcase}.#{report['mobile_model'].to_s.upcase}") or ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]['models'].include?("#{report['device_name'].to_s.upcase}.ALL") or ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]['models'].include?('ALL.ALL'))
                                                                                          if (ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]['fad']!=nil and ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]['fad']!='')
                                                                                              if (ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]['fad'].include?(report['client_id'].to_s))
                                                                                                  reason='FORBIDDEN ADCLIENT'
                                                                                              else
                                                                                                  reason='UNKNOWN'
                                                                                              end
                                                                                          else
                                                                                              reason='UNKNOWN'
                                                                                          end
                                                                                      else
                                                                                          reason='HANDSET MODEL MISMATCH'
                                                                                      end
                                                                                  else
                                                                                      reason='HANDSET MODEL MISMATCH'
                                                                                  end
                                                                              else
                                                                                  reason='HANDSET MISMATCH'
                                                                              end
                                                                          else
                                                                              reason='HANDSET MISMATCH'
                                                                          end
                                                                      else
                                                                          reason='CARRIER MISMATCH'
                                                                      end
                                                                  else
                                                                      reason='CARRIER MISMATCH'
                                                                  end
                                                              else
                                                                  reason='COUNTRY MISMATCH'
                                                              end
                                                              coll.update({"pub_id" => "#{report['pub_id']}", "reason" => "#{report['reason']}", "yad" => "#{reason}","delivery_time" => "#{Time.parse(report['delivery_time'].to_s).strftime('%Y-%m-%d')}","country_name"=>"#{@country_details["#{report['continent_code']}.#{report['country_code']}"]}"}, { "$inc" => { "impressions"=> report['impressions'].to_i}} ,:upsert => true)
                                                          else 
                                                              coll.update({"pub_id" => "#{report['pub_id']}", "reason" => "#{report['reason']}", "yad" => "#{report['reason']}","delivery_time" => "#{Time.parse(report['delivery_time'].to_s).strftime('%Y-%m-%d')}","country_name"=>"#{@country_details["#{report['continent_code']}.#{report['country_code']}"]}"}, { "$inc" => { "impressions"=> report['impressions'].to_i}} ,:upsert => true)
                                                          end
                                                      end
                                                      coll.update({"owner_name" => "#{NKF.nkf('-wxm0', (report['carrier_name']==nil || report['carrier_name']=="")? 'Unknown' : report['carrier_name'])}", "delivery_time" => "#{Time.parse(report['delivery_time'].to_s).strftime('%Y-%m-%d')}","carrier_name"=>"#{(carrier_details[report['carrier_name']]==nil  or carrier_details[report['carrier_name']]=='') ? "Unknown" : NKF.nkf('-wxm0', carrier_details[report['carrier_name']])}","country_name"=>(report['continent_code']==nil or report['continent_code']=='' or report['country_code']=='' or report['country_code']==nil) ? "Unknown" : @country_details["#{report['continent_code']}.#{report['country_code']}"]},{ "$inc" => { "impressions"=> report['impressions'].to_i}} ,:upsert => true) if analytics_table=='owner_summaries'
                                                      coll.update({"campaign_id" => "#{report['campaign_id']}", "client_id" => "#{report['client_id']}", "pub_id" => "#{report['pub_id']}","delivery_time" => "#{Time.parse(report['delivery_time'].to_s).strftime('%Y-%m-%d')}","campaign_name"=>campaign_details[report['campaign_id']]==nil ? "Unknown" : "#{campaign_details[report['campaign_id']][0]}","status"=>"open"}, { "$inc" => { "filled"=> report['filled'].to_i,"unfilled"=> report['unfilled'].to_i}} ,:upsert => true) if analytics_table=='wifi_summaries'
                                                      coll.insert({"campaign_id" => "#{report['campaign_id']}", "pub_id" => "#{report['pub_id']}","client_id" => "#{report['client_id']}","ip_address"=>"#{report['ipaddress']}","user_agent"=>"#{NKF.nkf('-wxm0',"#{report['user_agent']}")}","carrier_name"=>"#{NKF.nkf('-wxm0',"#{report['carrier_name']}")}","currency_symbol" => "#{report['currency_symbol']}", "country_name" => "#{@country_details["#{report['continent_code']}.#{report['country_code']}"]}", "status" => "#{report['status']}","delivery_time" => "#{report['delivery_time'].to_s}"},{"safe"=>1}) if analytics_table=='ip_details'
                                                      coll.update({"aid" => "#{report['advertiser_id']}","caid" => "#{report['campaign_id']}", "cid" => "#{report['client_id']}", "pid" => "#{report['pub_id']}", "dt" => "#{Time.parse(report['delivery_time'].to_s).strftime('%Y-%m-%d')}"}, { "$inc" => {"imp" => report['impression'].to_i, "ck" => report['click'].to_i, "spt" => report['spent'].to_f, "rev" => report['revenue'].to_f}} ,:upsert => true) if analytics_table=='campaigns_breakdown'
                                                      coll.update({"aid" => "#{report['advertiser_id']}", "cid" => "#{report['client_id']}", "ip" => "#{report['ipaddress']}", "ua" => "#{report['ua']}", "carr" => "#{NKF.nkf('-wxm0', (report['carrier_name']==nil || report['carrier_name']=="")? 'Unknown' : report['carrier_name'])}", "dt" => "#{Time.parse(report['delivery_time'].to_s).strftime('%Y-%m-%d')}"}, { "$inc" => {"ck" => report['click'].to_i, "cost" => report['cost'].to_f}} ,:upsert => true) if analytics_table=='click_logs'
                                                      state=''
                                                      if report['city']!=nil and report['city']!=''
                                                          if @index[report['city'][0,1]]!=nil
                                                              state=@us_city_obj[@index[report['city'][0,1]]]["#{report['city'].to_s.upcase}"]
                                                          end
                                                      end
                                                      coll.update({"aid" => "#{report['advertiser_id']}","caid" => "#{report['campaign_id']}", "ct" => "#{report['city'].to_s.upcase}","st"=>"#{state.to_s.upcase}", "dt" => "#{Time.parse(report['delivery_time'].to_s).strftime('%Y-%m-%d')}"}, { "$inc" => {"fl" => report['filled'].to_i,"ck" => report['click'].to_i}} ,:upsert => true) if analytics_table=='us_geostats'
                                                      coll.update({"pid" => "#{report['pub_id']}","cid" => "#{report['client_id']}", "ct" => "#{report['city'].to_s.upcase}","st"=>"#{state.to_s.upcase}", "dt" => "#{Time.parse(report['delivery_time'].to_s).strftime('%Y-%m-%d')}"}, { "$inc" => {"fl" => report['filled'].to_i,"unfl" => report['unfilled'].to_i,"ck" => report['click'].to_i}} ,:upsert => true) if analytics_table=='pub_us_geostats'
                                                  rescue Exception =>e  
                                                      #log string is used to store the log text while updating specified content                                                  
                                                      logger.error("Error while updating the #{analytics_table}(table name) with the following content. on #{Time.now} \n")
                                                      log_string="campaign_id--#{report['campaign_id']} client_id--#{report['client_id']}   pub_id--#{report['pub_id']}   delivery_time--#{Time.parse(report['delivery_time'].to_s).strftime('%Y-%m-%d')}    campaign_name--#{campaign_details[report['campaign_id']]==nil ? "0" : campaign_details[report['campaign_id']][0] }   bid--#{campaign_details[report['campaign_id']]==nil ? "0.0" : campaign_details[report['campaign_id']][1]}   status--open fraud_click--#{report['fraud_click'].to_i}" if analytics_table=='fraud_clicks'
                                                      log_string="client_id--#{report['client_id']} pub_id--#{report['pub_id']}   delivery_time--#{Time.parse(report['delivery_time'].to_s).strftime('%Y-%m-%d')}  country_name--#{@country_details["#{report['continent_code']}.#{report['country_code']}"]}   impressions--#{report['impressions'].to_i}"  if analytics_table=='unfilled_ips'
                                                      log_string="pub_id--#{report['pub_id']} reason--#{report['reason']}   delivery_time--#{Time.parse(report['delivery_time'].to_s).strftime('%Y-%m-%d')}   country_name--#{@country_details["#{report['continent_code']}.#{report['country_code']}"]} impressions--#{report['impressions'].to_i}"  if analytics_table=='why_no_ads'
                                                      log_string="owner_name--#{ report['carrier_name']} delivery_time--#{Time.parse(report['delivery_time'].to_s).strftime('%Y-%m-%d')}  carrier_name--#{(carrier_details[report['carrier_name']]==nil  or carrier_details[report['carrier_name']]=='') ? 'Unknown' : carrier_details[report['carrier_name']]}   country_name--#{(report['continent_code']==nil or report['continent_code']=='' or report['country_code']=='' or report['country_code']==nil) ? 'Unknown' : @country_details["#{report['continent_code']}.#{report['country_code']}"]}  owner_name--#{report['carrier_name']}  delivery_time--#{Time.parse(report['delivery_time'].to_s).strftime('%Y-%m-%d')}   carrier_name--#{(carrier_details[report['carrier_name']]==nil  or carrier_details[report['carrier_name']]=='') ? 'Unknown' : carrier_details[report['carrier_name']]}   country_name--#{(report['continent_code']==nil or report['continent_code']=='' or report['country_code']=='' or report['country_code']==nil) ? 'Unknown' : @country_details["#{report['continent_code']}.#{report['country_code']}"]}"  if analytics_table=='owner_summaries'
                                                      log_string="campaign_id--#{report['campaign_id']} client_id--#{report['client_id']}  pub_id--#{report['pub_id']}  delivery_time--#{Time.parse(report['delivery_time'].to_s).strftime('%Y-%m-%d')}  campaign_name--#{campaign_details[report['campaign_id']][0]}  status--open  filled--#{report['filled'].to_i}  unfilled--#{report['unfilled'].to_i}"  if analytics_table=='wifi_summaries'
                                                      log_string="campaign_id--#{report['campaign_id']} pub_id--#{report['pub_id']} client_id--#{report['client_id']}  ip_address--#{report['ipaddress']}  user_agent--#{report['user_agent']}  carrier_name--#{report['carrier_name']}  currency_symbol--#{report['currency_symbol']}   country_name--#{@country_details["#{report['continent_code']}.#{report['country_code']}"]}   status--#{report['status']}   delivery_time--#{report['delivery_time']}"  if analytics_table=='ip_details'
                                                      log_string="advertiser_id --#{report['advertiser_id']}  campaign_id--#{report['campaign_id']} publisher_id --#{report['pub_id']} client_id--#{report['client_id']} delivery_time--#{report['delivery_time']} impression--#{report['impression']}, click--#{report['click']}  spent--#{report['spent']}  revenue--#{report['revenue']}"  if analytics_table=='campaigns_breakdown'
                                                      log_string="advertiser_id--#{report['advertiser_id']} carrier_name--#{report['carrier_name']} client_id--#{report['client_id']} delivery_time--#{report['delivery_time']} ipaddress--#{report['ipaddress']}, click--#{report['click']}  cost--#{report['cost']}  useragent--#{report['ua']}"  if analytics_table=='click_logs'
                                                      log_string="advertiser_id --#{report['advertiser_id']}  campaign_id--#{report['campaign_id']} city --#{report['city']} delivery_time--#{report['delivery_time']} filled--#{report['filled']}  clicks--#{report['click']}"  if analytics_table=='us_geostats'
                                                      log_string="pub_id --#{report['pub_id']}  client_id--#{report['client_id']} city --#{report['city']} delivery_time--#{report['delivery_time']} filled--#{report['filled']} unfilled--#{report['unfilled']}  clicks--#{report['click']}"  if analytics_table=='pub_us_geostats'
                                                      logger.error("#{log_string}\n\n")                                                      
                                                      puts "Error in ClassName: MongoDBSummarizer MethodName: reports while inserting records ErrInfo:#{e.to_s}" 
                                                      if @mail_status_insert == "true" # "<p style='color:#FF0000'>"+ +"</p>"
                                                          @error_insertion_summarizer << "<p style='color:#FF0000'> ERROR :: Analytics Summarizer method (reports) during Insertion...<br />Project: ANALYTICS_SHARDING <br />Job: MongoDBSummarizer <br />Ip address is: #{ip}<br />Database: #{@shard_db_name}#{db}<br />Table: #{@shard_table_name}#{@table_name}#{table_number}<br />Start_time: #{start_date}<br />End_time: #{end_date}<br />Failure_Time:#{Time.now}<br />Exception is : #{e.to_s}<br /></p>"
                                                          @mail_status_insert = "false"
                                                      end # end of @mail_status_insert == "true"
                                                  end
                                              end # end of row in select_query
                                          end # end of (select_query.length > 0) 
                                      end  #select_records=='true' and update_flag=='true'
                                  rescue Exception => e
                                      puts "Error in ClassName: MongoDBSummarizer MethodName: reports while checking length ErrInfo:#{e.to_s}" 
                                  end # end of begin
                              end # end of tx_illegal == "true" or start_date >  end_date or start_date > curr_datetime   
                          rescue Exception =>e  
                              puts "Error in ClassName: MongoDBSummarizer MethodName: reports while iterating ErrInfo:#{e.to_s}" 
                              acquire_lock(@dbconn_selection ,RELEASE_LOCK,REPORTS_SUMMARIZER)
                              @dbconn_selection.disconnect if @dbconn_selection != nil
                          end # end of begin
                      end #end of analytics_table in analytics_table_arr
                  end # end of  table_number in @start_table..@max_table
              end # end of db in @start_db..@maxdb
          end # end of @available_server
          ynoads=nil  
      rescue Exception =>e  
          puts "Error in ClassName: MongoDBSummarizer MethodName: reports ErrInfo:#{e.to_s}" 
          #acquire_lock(@dbconn_selection ,RELEASE_LOCK,REPORTS_SUMMARIZER)
      end # end of begin 
  end # end of reports method

    #-------------------------------------------------------------------------------------
    #Method Name: reports_recovery
    #Purpose: This action is to check the report transaction status. If it is  "Table is locked for reading" and end time for that particular record exceeds 3 hours, select the records and do the transaction. Finnaly update its status as 'Transaction completed'
    #Version: 1.0
    #Author: Md Shujauddeen
    #Last-Modified by: Md Shujauddeen
    #Last-Modified: 30-04-2009
    #--------------------------------------------------------------------------------------
    def reports_recovery
        begin
            #puts "REPORTS RECOVERY"
            obj_tempQuery=MongodbQuerySetting.new()
            logger=Logger.new("mongodb_logs.log","daily")
            last_time = Time.now-3600    #3600 # Getting current time (3 hours before)
            check_hour = last_time.strftime("%Y-%m-%d %H:%M:%S") # Getting the date and time
            @records_recovery_array = []
            @error_selection_recovery = []
            @error_insertion_recovery = []
            @error_updation_recovery = []
            #~ $ip_array = []
            ynoads = WhyNoAds.new.create
            for ip in @available_server
                for db in @start_db..@maxdb
                    # Here we are going to establish a connection to shard database for transaction table to check any rows is still under the status called 'Table is locked for reading'  based on certain conditions
                    @dbconn_select = DBI.connect("DBI:MYSQL:#{@shard_db_name}#{db}:#{ip}", WriteDBServer::USERNAME, WriteDBServer::PASSWORD)
                    begin
                        get_lock = acquire_lock(@dbconn_select,ACQUIRE_LOCK,REPORTS_RECOVERY)
                        if(get_lock == 1)
                            # Select the records based on certain condition
                            select_table = "select * from mongodb_transactions where status='Table is locked for reading' and ip = '#{ip}' and database_name = '#{@shard_db_name}#{db}' and end_datetime < '#{check_hour}'"
                            select_status_table = @dbconn_select.select_all(select_table)
                            # If records are available, fetch the ip address, database name, table name, start time and end time. And store the values in ip_array
                            if(select_status_table.length > 0)
                                curr_datetime=select_status_table[0]['date']
                                check_currtime=Time.now-10800   #10800
                                if check_currtime > Time.parse("#{curr_datetime}")
                                    fetch_curr_time = Time.now # Fetch the current time
                                    time_taken = Time.now # Fetch the current 'Seconds'
                                    select_records = "false"
                                    for row in select_status_table # Fetch the records from $ip_array
                                        begin 
                                            select_query_table=obj_tempQuery.selectMongodbQuery(row['table_name'],"","",row['start_datetime'],row['end_datetime'],row['analytics_table'])
                                            select_recovery_records = @dbconn_select.select_all(select_query_table)
                                            select_records = "true"
                                            if row['analytics_table']=='why_no_ads'
                                                if ynoads==nil or ynoads==''
                                                    select_records = "false"
                                                end
                                            end
                                        rescue Exception => e
                                            puts "Error in ClassName: MongoDBSummarizer MethodName: reports_recovery while selcting records ErrInfo:#{e.to_s}" 
                                            @error_selection_recovery << "<p style='color:#FF0000'> ERROR :: Analytics Summarizer method (Recovery) For Selection...<br />Project: ANALYTICS_SHARDING<br />Job: Reports_Recovery<br />Ip address is: #{row['ip']}<br />Database: #{row['database_name']}<br />Table: #{row['table_name']}<br />Start_time: #{row['start_datetime']}<br />End_time: #{row['end_datetime']}<br />Failure_Time:#{Time.now}<br />Exception is : #{e.to_s}<br /></p>"
                                            #~ acquire_lock(@dbconn_select,RELEASE_LOCK,REPORTS_RECOVERY)
                                        ensure
                                            update_flag='false'
                                            begin
                                                if select_records =='true'
                                                    if (select_recovery_records.length ==0) # If no records are there in ads deliveries table
                                                        status_val = "Transaction completed for zero record"  # set the status as "Transaction completed for zero record"
                                                    elsif (select_recovery_records.length > 0)
                                                        status_val ="Transaction completed" # set the transaction status as "Transaction completed"
                                                    end
                                                    update_transaction_status = "update mongodb_transactions set status = '#{status_val}', time_taken = #{Time.now-time_taken} where ip = '#{row['ip']}' and database_name = '#{row['database_name']}' and table_name = '#{row['table_name']}' and analytics_table='#{row['analytics_table']}' and start_datetime='#{row['start_datetime']}' and end_datetime='#{row['end_datetime']}' and status = 'Table is locked for reading' and date = '#{row['date']}'"
                                                    analytics_table=row['analytics_table']
                                                    campaign_details=campaign_name_bid() if (analytics_table=='fraud_clicks' || analytics_table=='wifi_summaries')
                                                    carrier_details=owner_details() if (analytics_table=='owner_summaries')
                                                    if (analytics_table=='fraud_clicks' || analytics_table=='wifi_summaries')
                                                        if campaign_details!=nil
                                                            update_status = @dbconn_select.prepare(update_transaction_status)
                                                            update_status.execute
                                                            update_flag='true'
                                                        end
                                                    elsif analytics_table=='owner_summaries'
                                                        if carrier_details!=nil
                                                            update_status = @dbconn_select.prepare(update_transaction_status)
                                                            update_status.execute
                                                            update_flag='true'
                                                        end
                                                    else
                                                        update_status = @dbconn_select.prepare(update_transaction_status)
                                                        update_status.execute
                                                        update_flag='true'
                                                    end
                                                end
                                            rescue Exception=>e
                                                update_flag='false'
                                                puts "Error occured while updating the analytics transaction table::#{e}"
                                            end
                                            #~ @dbconn_select.disconnect if @dbconn_select != nil  
                                        end
                                        begin
                                            if select_records=='true' and update_flag=='true'
                                                mongo_db  = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
                                                if (analytics_table =='ip_details' and (Time.parse(row['start_datetime'].to_s).strftime('%H:%M:%S'))=='00:00:00')
                                                    coll_del = mongo_db.drop_collection("#{analytics_table}_#{((Time.parse(row['start_datetime'].to_s))-172800).strftime('%Y-%m-%d')}")
                                                end
                                                coll_del=nil  
                                                coll = mongo_db.collection(analytics_table)  if analytics_table !='ip_details'
                                                #coll = mongo_db.collection("#{analytics_table}_#{Time.parse(row['start_datetime'].to_s).strftime('%Y-%m-%d')}") if (analytics_table =='ip_details' and (Time.parse(start_date).strftime('%H:%M:%S'))=='00:00:00')
                                                coll = mongo_db.collection("#{analytics_table}_#{Time.parse(row['start_datetime'].to_s).strftime('%Y-%m-%d')}") if (analytics_table =='ip_details')
                                                coll.create_index([['pub_id', Mongo::ASCENDING],['client_id', Mongo::ASCENDING],['campaign_id', Mongo::ASCENDING],['country_name',Mongo::ASCENDING]]) if (analytics_table =='ip_details' and (Time.parse(row['start_datetime'].to_s).strftime('%H:%M:%S'))=='00:00:00')
                                                if(select_recovery_records.length > 0)
                                                    @mail_status_insert = "true"
                                                    for row_table in select_recovery_records # Insert the selected rows one by one into the MongoDB summarizer table resides in master database. 
                                                        begin 
                                                            coll.update({"campaign_id" => "#{row_table['campaign_id']}", "client_id" => "#{row_table['client_id']}", "pub_id" => "#{row_table['pub_id']}","delivery_time" => "#{Time.parse(row_table['delivery_time'].to_s).strftime('%Y-%m-%d')}","campaign_name"=>campaign_details[row_table['campaign_id']]==nil ? "Unknown" : "#{campaign_details[row_table['campaign_id']][0]}","bid"=>campaign_details[row_table['campaign_id']][1]==nil ? "0.0" : "#{campaign_details[row_table['campaign_id']][1]}","status"=>"open"}, { "$inc" => { "fraud_click"=> row_table['fraud_click'].to_i}} ,:upsert => true) if analytics_table=='fraud_clicks'
                                                            coll.update({"client_id" => "#{row_table['client_id']}", "pub_id" => "#{row_table['pub_id']}","delivery_time" => "#{Time.parse(row_table['delivery_time'].to_s).strftime('%Y-%m-%d')}","country_name"=>(row_table['continent_code']==nil or row_table['continent_code']=='' or row_table['country_code']=='' or row_table['country_code']==nil) ? "Unknown" : @country_details["#{row_table['continent_code']}.#{row_table['country_code']}"]}, { "$inc" => { "impressions"=> row_table['impressions'].to_i}} ,:upsert => true) if analytics_table=='unfilled_ips'
                                                            if (analytics_table=='why_no_ads')
                                                                if (report['reason']=='NO ADS' or report['reason']=='NO_ADS')  
                                                                    if (ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]!=nil and ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]!='')
                                                                        if (ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]['carrier']!=nil and ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]['carrier']!='')
                                                                            if (ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]['carrier'].include?(report['carrier_name'].to_s.upcase) or ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]['carrier'].include?("ALL"))
                                                                                if (ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]['devices']!=nil and ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]['devices']!='')
                                                                                    if (ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]['devices'].include?(report['device_name'].to_s.upcase) or ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]['devices'].include?('ALL DEVICES'))
                                                                                        if (ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]['models']!=nil and ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]['models']!='')
                                                                                            if (ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]['models'].include?("#{report['device_name'].to_s.upcase}.#{report['mobile_model'].to_s.upcase}") or ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]['models'].include?("#{report['device_name'].to_s.upcase}.ALL") or ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]['models'].include?('ALL.ALL'))
                                                                                                if (ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]['fad']!=nil and ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]['fad']!='')
                                                                                                    if (ynoads[@country_details["#{report['continent_code']}.#{report['country_code']}"].to_s.upcase]['fad'].include?(report['client_id'].to_s))
                                                                                                        reason='FORBIDDEN ADCLIENT'
                                                                                                    else
                                                                                                        reason='UNKNOWN'
                                                                                                    end
                                                                                                else
                                                                                                    reason='UNKNOWN'
                                                                                                end
                                                                                            else
                                                                                                reason='HANDSET MODEL MISMATCH'
                                                                                            end
                                                                                        else
                                                                                            reason='HANDSET MODEL MISMATCH'
                                                                                        end
                                                                                    else
                                                                                        reason='HANDSET MISMATCH'
                                                                                    end
                                                                                else
                                                                                    reason='HANDSET MISMATCH'
                                                                                end
                                                                            else
                                                                                reason='CARRIER MISMATCH'
                                                                            end
                                                                        else
                                                                            reason='CARRIER MISMATCH'
                                                                        end
                                                                    else
                                                                        reason='COUNTRY MISMATCH'
                                                                    end
                                                                    coll.update({"pub_id" => "#{report['pub_id']}", "reason" => "#{report['reason']}", "yad" => "#{reason}","delivery_time" => "#{Time.parse(report['delivery_time'].to_s).strftime('%Y-%m-%d')}","country_name"=>"#{@country_details["#{report['continent_code']}.#{report['country_code']}"]}"}, { "$inc" => { "impressions"=> report['impressions'].to_i}} ,:upsert => true)
                                                                else 
                                                                    coll.update({"pub_id" => "#{report['pub_id']}", "reason" => "#{report['reason']}", "yad" => "#{report['reason']}","delivery_time" => "#{Time.parse(report['delivery_time'].to_s).strftime('%Y-%m-%d')}","country_name"=>"#{@country_details["#{report['continent_code']}.#{report['country_code']}"]}"}, { "$inc" => { "impressions"=> report['impressions'].to_i}} ,:upsert => true)
                                                                end
                                                            end
                                                            coll.update({"owner_name" => "#{NKF.nkf('-wxm0', row_table['carrier_name'])}", "delivery_time" => "#{Time.parse(row_table['delivery_time'].to_s).strftime('%Y-%m-%d')}","carrier_name"=>"#{(carrier_details[row_table['carrier_name']]==nil  or carrier_details[row_table['carrier_name']]=='') ? 'Unknown' : NKF.nkf('-wxm0',carrier_details[row_table['carrier_name']])}","country_name"=>(row_table['continent_code']==nil or row_table['continent_code']=='' or row_table['country_code']=='' or row_table['country_code']==nil) ? "Unknown" : @country_details["#{row_table['continent_code']}.#{row_table['country_code']}"]},{ "$inc" => { "impressions"=> row_table['impressions'].to_i}} ,:upsert => true) if analytics_table=='owner_summaries'
                                                            coll.update({"campaign_id" => "#{row_table['campaign_id']}", "client_id" => "#{row_table['client_id']}", "pub_id" => "#{row_table['pub_id']}","delivery_time" => "#{Time.parse(row_table['delivery_time'].to_s).strftime('%Y-%m-%d')}","campaign_name"=>campaign_details[row_table['campaign_id']]==nil ? "Unknown" : "#{campaign_details[row_table['campaign_id']][0]}","status"=>"open"}, { "$inc" => { "filled"=> row_table['filled'].to_i,"unfilled"=> row_table['unfilled'].to_i}} ,:upsert => true) if analytics_table=='wifi_summaries'
                                                            coll.insert({"campaign_id" => "#{row_table['campaign_id']}", "pub_id" => "#{row_table['pub_id']}","client_id" => "#{row_table['client_id']}","ip_address"=>"#{row_table['ipaddress']}","user_agent"=>"#{row_table['user_agent']}","carrier_name"=>"#{NKF.nkf('-wxm0', row_table['carrier_name'])}","currency_symbol" => "#{row_table['currency_symbol']}", "country_name" => "#{@country_details["#{row_table['continent_code']}.#{row_table['country_code']}"]}", "status" => "#{row_table['status']}","delivery_time" => "#{row_table['delivery_time'].to_s}"},{"safe"=>1}) if analytics_table=='ip_details'
                                                            coll.update({"aid" => "#{row_table['advertiser_id']}","caid" => "#{row_table['campaign_id']}", "cid" => "#{row_table['client_id']}", "pid" => "#{row_table['pub_id']}", "dt" => "#{Time.parse(row_table['delivery_time'].to_s).strftime('%Y-%m-%d')}"}, { "$inc" => {"imp" => row_table['impression'].to_i, "ck" => row_table['click'].to_i, "spt" => row_table['spent'].to_f, "rev" => row_table['revenue'].to_f}} ,:upsert => true) if analytics_table=='campaigns_breakdown'
                                                            coll.update({"aid" => "#{row_table['advertiser_id']}", "cid" => "#{row_table['client_id']}", "ip" => "#{row_table['ipaddress']}", "ua" => "#{row_table['ua']}", "carr" => "#{NKF.nkf('-wxm0', (row_table['carrier_name']==nil || row_table['carrier_name']=="")? 'Unknown' : row_table['carrier_name'])}", "delivery_time" => "#{Time.parse(row_table['delivery_time'].to_s).strftime('%Y-%m-%d')}"}, { "$inc" => {"ck" => row_table['click'].to_i, "cost" => row_table['cost'].to_f}} ,:upsert => true) if analytics_table=='click_logs'
                                                            state=''
                                                            if row_table['city']!=nil and row_table['city']!=''
                                                                if @index[row_table['city'][0,1]]!=nil
                                                                    state=@us_city_obj[@index[row_table['city'][0,1]]]["#{row_table['city'].to_s.upcase}"]
                                                                end
                                                            end
                                                            coll.update({"aid" => "#{row_table['advertiser_id']}","caid" => "#{row_table['campaign_id']}", "ct" => "#{row_table['city'].to_s.upcase}","st"=>"#{state.to_s.upcase}", "dt" => "#{Time.parse(row_table['delivery_time'].to_s).strftime('%Y-%m-%d')}"}, { "$inc" => {"fl" => row_table['filled'].to_i, "ck" => row_table['click'].to_i}} ,:upsert => true) if analytics_table=='us_geostats'
                                                            coll.update({"pid" => "#{row_table['pub_id']}","cid" => "#{row_table['client_id']}", "ct" => "#{row_table['city'].to_s.upcase}","st"=>"#{state.to_s.upcase}", "dt" => "#{Time.parse(row_table['delivery_time'].to_s).strftime('%Y-%m-%d')}"}, { "$inc" => {"fl" => row_table['filled'].to_i,"unfl" => row_table['unfilled'].to_i, "ck" => row_table['click'].to_i}} ,:upsert => true) if analytics_table=='pub_us_geostats'
                                                        rescue Exception =>e
                                                            #log string is used to store the log text while updating specified content                                                            
                                                            logger.error("Error while updating the #{analytics_table}(table name) with the following content. on #{Time.now} \n")
                                                            log_string="campaign_id--#{row_table['campaign_id']}   client_id--#{row_table['client_id']}   pub_id--#{row_table['pub_id']}   delivery_time--#{Time.parse(row_table['delivery_time'].to_s).strftime('%Y-%m-%d')}    campaign_name--#{campaign_details[row_table['campaign_id']]==nil ? "0" : campaign_details[row_table['campaign_id']][0] }   bid--#{campaign_details[row_table['campaign_id']]==nil ? "0.0" : campaign_details[row_table['campaign_id']][1]}   status--open fraud_click--#{row_table['fraud_click'].to_i}" if analytics_table=='fraud_clicks'
                                                            log_string="client_id--#{row_table['client_id']}   pub_id--#{row_table['pub_id']}   delivery_time--#{Time.parse(row_table['delivery_time'].to_s).strftime('%Y-%m-%d')}  country_name--#{@country_details["#{row_table['continent_code']}.#{row_table['country_code']}"]}   impressions--#{row_table['impressions'].to_i}"  if analytics_table=='unfilled_ips'
                                                            log_string="pub_id--#{row_table['pub_id']}   reason--#{row_table['reason']}   delivery_time--#{Time.parse(row_table['delivery_time'].to_s).strftime('%Y-%m-%d')}   country_name--#{@country_details["#{row_table['continent_code']}.#{row_table['country_code']}"]} impressions--#{row_table['impressions'].to_i}"  if analytics_table=='why_no_ads'
                                                            log_string="owner_name--#{ row_table['carrier_name']}   delivery_time--#{Time.parse(row_table['delivery_time'].to_s).strftime('%Y-%m-%d')}  carrier_name--#{(carrier_details[row_table['carrier_name']]==nil  or carrier_details[row_table['carrier_name']]=='') ? 'Unknown' : carrier_details[row_table['carrier_name']]}   country_name--#{(row_table['continent_code']==nil or row_table['continent_code']=='' or row_table['country_code']=='' or row_table['country_code']==nil) ? 'Unknown' : @country_details["#{row_table['continent_code']}.#{row_table['country_code']}"]}  owner_name--#{row_table['carrier_name']}  delivery_time--#{Time.parse(row_table['delivery_time'].to_s).strftime('%Y-%m-%d')}   carrier_name--#{(carrier_details[row_table['carrier_name']]==nil  or carrier_details[row_table['carrier_name']]=='') ? 'Unknown' : carrier_details[row_table['carrier_name']]}   country_name--#{(row_table['continent_code']==nil or row_table['continent_code']=='' or row_table['country_code']=='' or row_table['country_code']==nil) ? 'Unknown' : @country_details["#{row_table['continent_code']}.#{row_table['country_code']}"]}"  if analytics_table=='owner_summaries'
                                                            log_string="campaign_id--#{row_table['campaign_id']}  client_id--#{row_table['client_id']}  pub_id--#{row_table['pub_id']}  delivery_time--#{Time.parse(row_table['delivery_time'].to_s).strftime('%Y-%m-%d')}  campaign_name--#{campaign_details[row_table['campaign_id']]}  status--open  filled--#{row_table['filled'].to_i}  unfilled--#{row_table['unfilled'].to_i}"  if analytics_table=='wifi_summaries'
                                                            log_string="campaign_id--#{row_table['campaign_id']}  pub_id--#{row_table['pub_id']} client_id--#{row_table['client_id']} ip_address--#{row_table['ipaddress']}  user_agent--#{NKF.nkf('-wxm0',row_table['user_agent'])}  carrier_name--#{row_table['carrier_name']}  currency_symbol--#{row_table['currency_symbol']}   country_name--#{@country_details["#{row_table['continent_code']}.#{row_table['country_code']}"]}   status--#{row_table['status']}   delivery_time--#{row_table['delivery_time']}"  if analytics_table=='ip_details'
                                                            log_string="advertiser_id --#{row_table['advertiser_id']}  campaign_id--#{row_table['campaign_id']} publisher_id --#{row_table['pub_id']} client_id--#{row_table['client_id']} delivery_time--#{row_table['delivery_time']} impression--#{row_table['impression']}, click--#{row_table['click']}  spent--#{row_table['spent']}  revenue--#{row_table['revenue']}"  if analytics_table=='campaigns_breakdown'
                                                            log_string="advertiser_id--#{row_table['advertiser_id']} carrier_name--#{row_table['carrier_name']} client_id--#{row_table['client_id']} delivery_time--#{row_table['delivery_time']} ipaddress--#{row_table['ipaddress']}, click--#{row_table['click']}  cost--#{row_table['cost']}  useragent--#{row_table['ua']}"  if analytics_table=='click_logs'
                                                            log_string="advertiser_id --#{row_table['advertiser_id']}  campaign_id--#{row_table['campaign_id']} city --#{row_table['city']} delivery_time--#{row_table['delivery_time']} filled--#{row_table['filled']}  clicks--#{row_table['click']}"  if analytics_table=='us_geostats'
                                                            log_string="pub_id --#{row_table['pub_id']}  client_id--#{row_table['client_id']} city --#{row_table['city']} delivery_time--#{row_table['delivery_time']} filled--#{row_table['filled']} unfilled--#{row_table['unfilled']}  clicks--#{row_table['click']}"  if analytics_table=='pub_us_geostats'
                                                            logger.error("#{log_string}\n\n")                                                          
                                                            puts "Error in ClassName: MongoDBSummarizer MethodName: reports_recovery while inserting ErrInfo:#{e.to_s}" 
                                                            if @mail_status_insert == "true"
                                                                @error_insertion_recovery << "<p style='color:#FF0000'> ERROR :: Analytics Summarizer method (Recovery) for Insertion...<br />Project: ANALYTICS_SHARDING<br />Job: Reports_Recovery<br />Ip address is: #{row['ip']}<br />Database: #{row['database_name']}<br />Table: #{row['table_name']}<br />Analytics Table: #{row['analytics_table']}<br />Start_time: #{row['start_datetime']}<br />End_time: #{row['end_datetime']}<br />Failure_Time:#{Time.now}<br />Exception is : #{e.to_s}<br /></p>"
                                                                @mail_status_insert = "false"
                                                                #~ acquire_lock(@dbconn_select,RELEASE_LOCK,REPORTS_RECOVERY)
                                                            end 
                                                        end
                                                    end # end of row_table in select_recovery_records
                                                end # end of (select_recovery_records.length ==0)
                                            end
                                        rescue Exception => e
                                            puts "Error in ClassName: MongoDBSummarizer MethodName: reports_recovery while checking length ErrInfo:#{e.to_s}" 
                                            select_records = "false"
                                            #~ acquire_lock(@dbconn_select,RELEASE_LOCK,REPORTS_RECOVERY)
                                        end # end of begin
                                    end # row in select_status_table
                                    acquire_lock(@dbconn_select,RELEASE_LOCK,REPORTS_RECOVERY)
                                    @dbconn_select.disconnect if @dbconn_select != nil
                                else
                                    acquire_lock(@dbconn_select,RELEASE_LOCK,REPORTS_RECOVERY)
                                    @dbconn_select.disconnect if @dbconn_select != nil
                                end # if check_currtime > Time.parse(curr_datetime)
                            else
                                #puts "No records are there"
                                @records_recovery_array<< "<p style='color:#0000FF'>Project: ANALYTICS_SHARDING<br />Job: Reports_Recovery<br />Ip address is: #{ip}<br />Database: #{@shard_db_name}#{db}<br />Status: No records in mongodb_transactions table<br />Processed Time:#{Time.now.strftime('%Y-%m-%d %H:%M:%S')}<br /></p>"
                                acquire_lock(@dbconn_select,RELEASE_LOCK,REPORTS_RECOVERY)
                                @dbconn_select.disconnect if @dbconn_select != nil
                            end # if(select_status_table.length!=0)
                        else
                            acquire_lock(@dbconn_select,RELEASE_LOCK,REPORTS_RECOVERY)
                            @dbconn_select.disconnect if @dbconn_select != nil
                        end  # end of @get_lock_stat[0] == 1
                    rescue Exception => e
                        puts "Error in ClassName: MongoDBSummarizer MethodName: reports_recovery while iterating ErrInfo:#{e.to_s}" 
                        select_records = "false"
                        acquire_lock(@dbconn_select,RELEASE_LOCK,REPORTS_RECOVERY)
                        @dbconn_select.disconnect if @dbconn_select != nil
                    end # end of begin
                end # end of db in @start_db..@maxdb
            end # end of ip in @available_server
        rescue Exception => e
            puts "Error in ClassName: MongoDBSummarizer MethodName: reports_recovery ErrInfo:#{e.to_s}" 
            #~ acquire_lock(@dbconn_select,RELEASE_LOCK,REPORTS_RECOVERY)
            #~ @dbconn_select.disconnect if @dbconn_select != nil
        end # end of begin
    end # end of reports_recovery method
      
      
    def campaign_name_bid
        #campaigns details from Master db
        begin
            dbconn = DBI.connect("DBI:MYSQL:zestadz_analytics:#{@analytics_ip}", WriteDBServer::USERNAME, WriteDBServer::PASSWORD)
            sql="select id,campaign_name,bid_range_avg from campaigns"
            campaigns = dbconn.execute(sql)
            campaign_details=Hash.new
        rescue Exception => e
              puts "error in dbconn :: #{e}"
        ensure
              dbconn.disconnect unless dbconn==nil
              dbconn=nil
        end
        sql=nil
        while campaign = campaigns.fetch do
            campaign_details.store(campaign['id'],[campaign['campaign_name'],campaign['bid_range_avg']])
        end
        campaigns=nil
        return campaign_details
    end
    
    def owner_details
        begin
                dbconn = DBI.connect("DBI:MYSQL:zestadz_analytics:#{@analytics_ip}", WriteDBServer::USERNAME, WriteDBServer::PASSWORD)
                carriers = dbconn.execute("select id,carrier_name,owners from carriers where carrier_name!='' and owners!=''")
            rescue Exception => e
                  puts "error in dbconn :: #{e}"
            ensure
                  dbconn.disconnect unless dbconn==nil
                  dbconn=nil
            end
            sql=nil
            carrier_details=Hash.new
            #store owners details in a hash with owner as key and carrier as value.
            while carrier = carriers.fetch do
                ownerNames=Array.new
                ownerNames=carrier['owners'].split(',')
                for owner in ownerNames
                    if owner!=nil and owner!=''
                        carrier_details.store(owner.strip,carrier['carrier_name'])
                    end
                end
            end
            carriers=nil
            ownerNames=nil
            return carrier_details
    end 
    
     def send_mail(subject,content)
      begin
        results = ""
        obj=Hash.new
        # Giving the recepient email addresses
        obj["to"]=["yasmine@mobile-worx.com","shujaudeen@mobile-worx.com","j.viswanathan@mobile-worx.com"]
        if (content != []) #or (content != "")
          obj["subject"] = subject
          for array_records in content
            results += "#{array_records} "
          end
        end
        mail=SendMail.new(obj)
        mailBody = ""
        mailBody += "<table width='100%' style='border: 1px solid #CCCCCC;border-collapse: collapse;' cellpadding='5px'>"
        mailBody += "<tr>" # style='background-color: #B2DCF4; color: #333333;'>"
        mailBody += "<td width='5%' align='left' valign='top' style='border: 1px solid #CCCCCC; font-family: 'Tahoma'; font-size: 8pt; background-color: #FFFFFF; font-weight: bold;'>#{results}</td>"  # Appending the records inside the body of mail
        mailBody += "</tr>"
        mailBody += "</table>"
        mail.body="#{mailBody}"
        mail.send # Sending the mail
      rescue Exception => e
        puts "Error in ComponentName: MongoDBSummarizer MethodName: send_mail ErrInfo:#{e.to_s}"
      end
    end

     #-------------------------------------------------------------------------------------
    #Method Name: updation
    #Purpose: This action is used to check the global variables before calling the method send mail.
    #Version: 1.0
    #Author: S.Sathish kumar
    #Last-Modified: 9-06-09
    #--------------------------------------------------------------------------------------
    def chk_send_mail(call_from)
      begin
        #puts "Call from -#{call_from}"
        #open the master config file and check the mail option.
        @check_mail_option = YAML::load(File.open("#{PATH_MASTER}"))
        if call_from == "reports"
          if (@error_selection_summarizer != [] and (@check_mail_option[:sendmail] == "error" or @check_mail_option[:sendmail] == "all"))
            subject = "Error in MongoDB summarizer in reports method whilie selecting."
            send_mail(subject,@error_selection_summarizer)
          end
          if (@error_insertion_summarizer != [] and (@check_mail_option[:sendmail] == "error" or @check_mail_option[:sendmail] == "all"))
            subject = "Error in MongoDB summarizer in reports method whilie inserting."
            send_mail(subject,@error_insertion_summarizer)
          end
          if(@error_updation_summarizer != [] and (@check_mail_option[:sendmail] == "error" or @check_mail_option[:sendmail] == "all"))
            subject = "Error in MongoDB summarizer in reports method whilie updating."
            send_mail(subject,@error_updation_summarizer)
          end
          if(@records_array != [] and @check_mail_option[:sendmail].to_s == "all")
            subject = "Status of Reports Summarizer Component."
            #Fetch the  updated records ip address, database name, table name, start datetime, end datetime and status from @records_array.
            send_mail(subject,@records_array)
          end # end of (@records_array != [])
          @records_array = [] # Reset the @records_array to fetch next set of records
          @error_selection_summarizer = []
          @error_insertion_summarizer = []
          @error_updation_summarizer = []
        elsif call_from == "reports_recovery"
           if (@error_selection_recovery != [] and (@check_mail_option[:sendmail] == "error" or @check_mail_option[:sendmail] == "all"))
             subject = "Error in MongoDB summarizer in report_recovery method whilie selecting."
             send_mail(subject,@error_selection_recovery)
          end
          if (@error_insertion_recovery != [] and (@check_mail_option[:sendmail] == "error" or @check_mail_option[:sendmail] == "all"))
            subject = "Error in MongoDB summarizer in report_recovery method whilie inserting."
            send_mail(subject,@error_insertion_recovery)
          end
          if(@error_updation_recovery != [] and (@check_mail_option[:sendmail] == "error" or @check_mail_option[:sendmail] == "all"))
            subject = "Error in MongoDB summarizer in report_recovery method whilie updating."
            send_mail(subject,@error_updation_recovery)
          end
          if (@records_recovery_array != [] and @check_mail_option[:sendmail].to_s == "all")
            #Fetch the  updated records ip address, database name, table name, start datetime, end datetime and status from @records_recovery_array
            subject = "Recovered records in Reports Summarizer Component"
            send_mail(subject,@records_recovery_array)
          end # end of (@records_recovery_array != [])
          @records_recovery_array = [] # Reset the @records_recovery_array to fetch next set of records
          @error_selection_recovery = []
          @error_insertion_recovery = []
          @error_updation_recovery = []
        end # end of call_from == "reports"
      rescue Exception => e
        puts "Error in ComponentName: MongoDBSummarizer MethodName: chk_send_mail ErrInfo:#{e.to_s}"
      end
    end  # end of method chk_send_mail
 
end # end of MongoDBSummarizer class
  
  #------------------------------------------------------------------------------------
  #Class Name: Updates
  #Purpose: The purpose of the class is to extend theMongoDBSummarizer class and create and run two threads
  #Version: 1.0
  #Author: Ayshwarya
  #Last-Modified: 30-04-2009
  #-------------------------------------------------------------------------------------
  class Updates < MongoDBSummarizer
    def setUSData
	us_city_obj=UsGeodetails.new
	@city=us_city_obj.setState
    end  
    #-------------------------------------------------------------------------------------
    #Method Name: cronjob
    #Purpose: This action is to run the server continously. Call the reports method for every one hour and reports_recovery method for every 30 minutes
    #Version: 1.0
    #Author: Ayshwarya
    #Last-Modified: 30-04-2009
    #--------------------------------------------------------------------------------------
    def cronjob
      begin
        puts "MongoDB summarizer has been started..."
        begin # this begin is for while loop.
          begin  #this begin is used for rescue inside the loop.
          #For the first time, it calls the reports method. After that it will be in sleep state for 1 hour. Again it will call the reports mehtod. This is going to be a continous process
          obj_reports = MongoDBSummarizer.new 
          obj_reports.setCityData(@city)
          obj_reports.reports
          obj_reports. chk_send_mail("reports")
          obj_reports = nil
          if @ant_process == "multiple"
            obj_multiple_reports = MongoDBSummarizer.new("parallel") 
            obj_multiple_reports.setCityData(@city)
            obj_multiple_reports.reports
            obj_multiple_reports.chk_send_mail("reports")
            obj_multiple_reports = nil 
          end
          puts"-----under sleep---"  
          sleep(300) #Set the sleep state for 25 seconds
          puts"--------comp wakeup-----"
          #call the reports recovery method..
          obj_reports_update = MongoDBSummarizer.new  #Create an object for the MongoDBSummarizer class 
          obj_reports_update.setCityData(@city)
          obj_reports_update.reports_recovery # Call the reports_recovery method with the object
          obj_reports_update.chk_send_mail("reports_recovery") 
          obj_reports_update = nil #Set the object as nil
          if @ant_process_rec == "multiple"
             obj_rec_multiple = MongoDBSummarizer.new("parallel")  
             obj_rec_multiple.setCityData(@city)
             obj_rec_multiple.reports_recovery
             obj_rec_multiple.chk_send_mail("reports_recovery") 
             obj_rec_multiple = nil
          end  
          rescue Exception => e
            puts "Error in ComponentName: MongoDBSummarizer MethodName: cronjob while iterating ErrInfo:#{e.to_s}" 
          end  
        end while(true)        
      rescue Exception => e
        puts "Error in ComponentName: MongoDBSummarizer MethodName: cronjob ErrInfo:#{e.to_s}" 
      end 
    end # end of cronjob method
  end # end of Updates class
#Creating the object and call the updation method first
obj = Updates.new()
obj.setUSData
obj.cronjob


