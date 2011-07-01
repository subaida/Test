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
 
require 'dbi'
require 'rubygems' 
require 'yaml'
require 'email_component.rb'
require 'time'
require 'date'
require 'settings.rb'
require 'analytics_query_setting.rb'
#setting the path to load the config files
PATH= PathSettings::DB_TEMP_FILE
PATH_MASTER= PathSettings::DB_MASTER_FILE
#------------------------------------------------------------------------------------
#class Name: AnalyticsSummarizer
#Purpose: The purpose of this class is to select the analytics_transaction table from shard database. If no rows are available, then set the status for transaction. Then read all the tables, do the calculations and insert the final results into Analytics summarizer. Finnaly update the status in analytics_transaction table resides in all shard database.
#Version: 1.0
#Author: Ayshwarya
#Last-Modified: 30-04-2009
#-------------------------------------------------------------------------------------
class AnalyticsSummarizer
    #initialize global variable for creating seperate thread in the cron job.
    $status  = "true"
    #initialize constant variables used as the part of table names.
    EVEN_TABLE="_even_"
    ODD_TABLE = "_odd_"
    #initialize constant variables used in acquire lock method.
    ACQUIRE_LOCK="GET_LOCK"
    RELEASE_LOCK="RELEASE_LOCK"
    REPORTS_SUMMARIZER = "analytics_reports_string"
    REPORTS_RECOVERY = "analytics_recovery_string"
    #------------------------------------------------------------------------------------
    #Method Name: initilaize
    #Purpose: This action is to call the re_initialize method for initializing the values to global variables.
    #Version: 1.0
    #Author: S.Sathish kumar  
    #Last-Modified: 23-03-2009
    #-------------------------------------------------------------------------------------
    def initialize(*args)
      begin
        #puts "Analytics summarizer INITIALIZE METHOD"
        #call the re_initialize method for initializing the values to global variables.
        if args[0] == nil
          re_initialize 
        elsif args[0] == "parallel"  
          re_initialize(args[0])  
        else
          puts "Command not match in Analytics summarizer and initialize method."          
        end
      rescue Exception => e
        puts "Error in ClassName:AnalyticsSummarizer MethodName:initialize ErrInfo:#{e.to_s} " 
      end      
    end   
    
  #------------------------------------------------------------------------------------
  #class Name: campaign_transaction
  #method name: re_initialize
  #Purpose: The purpose of this method is to re_initialize the global variables when the time comes from even hour to odd hour and vice versa..
  #Version: 1.0
  #Author: S.Sathish kumar
  #Last-Modified by: Md Shujauddeen
  #created-on: 06-03-2009
  #Last-Modified:
  #-------------------------------------------------------------------------------------      
  def re_initialize(*args)
    begin
      #puts "Reports Summarizer Re-Initialize method..."
      config = YAML::load(File.open("#{PATH}"))
      database_name = config[:active_server][:active_database]
      if args[0] == nil
        chk_parallel = " "
      elsif args[0] == "parallel"
        #puts "Condition pass parallel"
        chk_parallel = args[0]
      else
        puts "Command not match in Analytics summarizer and re_initialize method."                  
      end         
      if database_name == "single" or chk_parallel == "parallel"
        $ant_process = "single"
        $ant_process_rec = "single"
        $maxdb =  config[:localhost][:max_databases].to_i
        $start_db =  config[:localhost][:start_db].to_i
        $start_even_table  =  config[:localhost][:start_even_table].to_i
        $start_odd_table  =  config[:localhost][:start_odd_table].to_i
        $max_even_table  =  config[:localhost][:max_even_tables].to_i
        $max_odd_table  =  config[:localhost][:max_odd_tables].to_i
        $master_ip = config[:localhost][:master_ip]
        $master_db = config[:localhost][:master_db]
        $analytics_ip=AnalyticsDBServer::IP
        $analytics_db=AnalyticsDBServer::DATABASE
        $max_ip  =  config[:localhost][:max_ip].to_i
        $ip_addr  =  config[:localhost][:ip_addr]
        $shard_db_name = config[:localhost][:shard_database_name]
        $shard_table_name = config[:localhost][:table_name]
        $available_server = config[:localhost][:available_server]
      elsif database_name == "multiple"
        $ant_process = "multiple"
        $ant_process_rec = "multiple"
        $maxdb =  config[:old_localhost][:old_max_databases].to_i
        $start_db =  config[:old_localhost][:old_start_db].to_i
        $start_even_table  =  config[:old_localhost][:old_start_even_table].to_i
        $start_odd_table  =  config[:old_localhost][:old_start_odd_table].to_i
        $max_even_table  =  config[:old_localhost][:old_max_even_tables].to_i
        $max_odd_table  =  config[:old_localhost][:old_max_odd_tables].to_i
        $master_ip = config[:old_localhost][:old_master_ip]
        $master_db = config[:old_localhost][:iold_master_db]
        $analytics_ip=AnalyticsDBServer::IP
        $analytics_db=AnalyticsDBServer::DATABASE
        $max_ip  =  config[:old_localhost][:old_max_ip].to_i
        $ip_addr  =  config[:old_localhost][:old_ip_addr]
        $shard_db_name = config[:old_localhost][:old_shard_database_name]
        $shard_table_name = config[:old_localhost][:old_table_name]
        $available_server = config[:old_localhost][:old_available_server]
      else
        puts "Command not matched in Analytics summarizer re_initialize method.."           
      end  
    rescue Exception => e
      puts "Error in ClassName: AnalyticsSummarizer MethodName: re_initialize ErrInfo:#{e.to_s}" 
    end
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
        puts "Error in ClassName: AnalyticsSummarizer MethodName: acquire_lock ErrInfo:#{e.to_s}" 
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
        obj_tempQuery=AnalyticsQuerySetting.new()
        curr_date=Time.now.strftime("%Y-%m-%d %H:%M:%S") #getting current year, month and date
        now_date=Date.today
        curr_time=Time.now
        curr_datetime = curr_time.strftime("%Y-%m-%d %H:%M:%S")
        check_time = curr_time.strftime("%H").to_i # Getting the current time
        #declare this variable to take the current time for comparing end time to this variable.
        check_curr_time = Time.now.strftime("%Y-%m-%d %H:%M:%S")
        $records_array = []
        $error_selection_summarizer = []
        $error_insertion_summarizer = []
        $error_updation_summarizer = []
        analytics_table_arr=['temp_campaigns_summaries','temp_adv_carriers','temp_adv_devicesproperties','temp_adclients_summaries','temp_pub_channels','temp_pub_carriers','temp_pub_urls']
        # If current time is an odd hour, do the process for even hour table
        if check_time % 2 == 1
          @start_table = $start_even_table # Assigning the $start_even_table value to @start_table
          @max_table = $max_even_table # Assigning the $max_even_table value to @max_table
          @table_name = "#{EVEN_TABLE}" # Assign _even_ to table_name
          # If current hour is even hour, do the process for odd hour table
        elsif check_time % 2 == 0
          @start_table = $start_odd_table # Assigning the $start_odd_table value to @start_table
          @max_table = $max_odd_table # Assigning the $max_odd_table value to @max_table
          @table_name = "#{ODD_TABLE}"  # Assign _odd_ to table_name
        end
        #Establish a connection to master databse
        for ip in $available_server
          for db in $start_db..$maxdb
            for table_number in @start_table..@max_table
              for analytics_table in analytics_table_arr
                  begin
                    # Here we are going to establish a connection for shard table to check the availablitiy of rows for the even hour table. 
                    @dbconn_selection = DBI.connect("DBI:MYSQL:#{$shard_db_name}#{db}:#{ip}", WriteDBServer::USERNAME, WriteDBServer::PASSWORD)
                    tx_illegal = "false"
                    get_lock= acquire_lock(@dbconn_selection ,ACQUIRE_LOCK,REPORTS_SUMMARIZER)
                    if(get_lock == 1)
                      #Check if any records is available from shard database, check any records having the status as Table is locked for reading' or Transaction completed or Transaction completed for zero records. 
                      select_all="select * from analytics_transaction where ip='#{ip}' and database_name='#{$shard_db_name}#{db}' and table_name='#{$shard_table_name}#{@table_name}#{table_number}' and analytics_table='#{analytics_table}' and (status='Transaction completed' or status = 'Transaction completed for zero record' or status = 'Table is locked for reading') order by id desc limit 1"
                      select_status_transaction =@dbconn_selection.select_all(select_all)
                      last_hour_datetime = Time.now-3600 # Getting the current time - 1 hour
                      if select_status_transaction.length == 0 # If no records are there for the whole day.
                        #If current time is an odd hour, do the process for even hour table.
                        start_date = "#{now_date} 00:00:00" # Get the current date and assign 00:00:00 to start_date
                        last_hour = last_hour_datetime.strftime("%H").to_i # Getting the hour from current_time - 1 hour 
                        end_date = "#{now_date} 00:59:59" # Get the current date and last_hour and assign :59:59 to end_date
                        #If records are there in analytics_transaction 
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
                      #puts "===== TX ILLEGAL Lock is released===================================="
                    else 
                      #Insert the record into the analytics_transaction which is available in all shard database Set the status as "Table is locked for reading". 
                      insert_transaction_query = "insert into analytics_transaction(ip,database_name,table_name,analytics_table,start_datetime, end_datetime, status, date) values('#{ip}', '#{$shard_db_name}#{db}', '#{$shard_table_name}#{@table_name}#{table_number}','#{analytics_table}','#{start_date}', '#{end_date}', 'Table is locked for reading', '#{curr_date}')"
                      insert_status = @dbconn_selection.do(insert_transaction_query)
                      acquire_lock(@dbconn_selection ,RELEASE_LOCK,REPORTS_SUMMARIZER)
                      time_taken=Time.now # Fetch the current time 'seconds' 
                      #After the status has been set, select the required collumns from different shard databases resides in various ip addresses. And we are checking a condition for delivery time for the last one hour. Basesd on that condition it fetches list of rows, in that we are calculating the total number of clicks, impressions, cost and publisher revenue
                      select_records = "false"
                      @dbconn_selection.disconnect if @dbconn_selection != nil
                      #iterate to get appropriate queries to select/insert record in to analytics table
                          begin
                            #puts "Select statement in Reports ................"
                            @dbconn_selection = DBI.connect("DBI:MYSQL:#{$shard_db_name}#{db}:#{ip}", WriteDBServer::USERNAME, WriteDBServer::PASSWORD)
                            select_stat=obj_tempQuery.selectAnalyticsQuery($shard_table_name,@table_name,table_number,start_date,end_date,analytics_table)
                            #~ select_stat = "select hour(delivery_time) as hour, campaign_id, ad_id, client_id, sum(impressions) as impressions, sum(clicks) as clicks, sum(cost) as cost, sum(publisher_revenue) as publisher_revenue, metrics, ad_client_type from #{$shard_table_name}#{@table_name}#{table_number} where delivery_time>='#{start_date}' and delivery_time<='#{end_date}' group by hour, ad_id, client_id order by null" 
                            select_query = @dbconn_selection.select_all(select_stat)
                            select_records = "true"
                          rescue Exception =>e  
                            puts "Error in ClassName: AnalyticsSummarizer MethodName: reports while selcting records ErrInfo:#{e.to_s}" 
                            puts $error_selection_summarizer << "<p style='color:#FF0000'> ERROR :: Analytics Summarizer method (reports) during Selection...<br />Project: ANALYTICS_SHARDING<br />Job: AnalyticsSummarizer<br />Ip address is: #{ip}<br />Database: #{$shard_db_name}#{db}<br />Table: #{$shard_table_name}#{@table_name}#{table_number}<br />Start_time: #{start_date}<br />End_time: #{end_date}<br />Failure_Time:#{Time.now}<br />Exception is : #{e.to_s}<br /></p>"
                          ensure
                            @dbconn_selection.disconnect if @dbconn_selection != nil
                          end
			  @dbconn_transaction = DBI.connect("DBI:MYSQL:#{$analytics_db}:#{$analytics_ip}", WriteDBServer::USERNAME, WriteDBServer::PASSWORD)
        	          @dbconn_transaction.do("SET AUTOCOMMIT=0")
	                  @dbconn_transaction.do("BEGIN")
                          #Check if any records is avaiable from shard database, If it is available, then insert the records into master database and update the transaction status as "Transaction completed" for the corresponding shard database-> analytics_transaction
                          zero_record = "false"
                          failed_insert_records = "false"
                          begin
                            if(select_query.length ==0) # If records is not there in Analytics summarizer
                              zero_record = "true" # Assign true to zero_record
                            elsif (select_query.length > 0)  and (select_records == "true")
                              @mail_status_insert = "true"
                              for row in select_query # Insert the selected rows one by one into the Analytics summarizer table resides in master database. 
                                begin
                                  break if failed_insert_records=="true"
                                  insert_query="insert into temp_campaigns_summaries(metrics,ad_client_type,impressions,clicks,amount_spent,gross_profit,zestadz_revenue,handset,handset_model,unique_visitors,advertiser_id,campaign_id,ad_id,continent_code,country_code,delivery_hour,delivery_date) VALUES ('#{row['metrics']}','#{row['ad_client_type']}',#{row['impressions']},#{row['clicks']},#{row['amount_spent']},#{row['gross_profit']},#{row['zestadz_revenue']},\"#{row['handset']}\",\"#{row['handset_model']}\",'#{row['unique_visitors']}',#{row['advertiser_id']},#{row['campaign_id']},#{row['ad_id']},\"#{row['continent_code']}\",\"#{row['country_code']}\",#{row['delivery_hour']},'#{row['delivery_date']}')" if analytics_table=='temp_campaigns_summaries'
                                  insert_query="insert into temp_adv_carriers(owner,requests,advertiser_id,campaign_id,ad_id,delivery_hour,delivery_date) VALUES (\"#{row['owner']}\",#{row['requests']},#{row['advertiser_id']},#{row['campaign_id']},#{row['ad_id']},#{row['delivery_hour']},'#{row['delivery_date']}')" if analytics_table=='temp_adv_carriers'
                                  insert_query="insert into temp_adv_devicesproperties(user_agent,requests,handset,handset_model,advertiser_id,campaign_id,ad_id,delivery_hour,delivery_date) VALUES(\"#{row['user_agent']}\",#{row['requests']},\"#{row['handset']}\",\"#{row['handset_model']}\",#{row['advertiser_id']},#{row['campaign_id']},#{row['ad_id']},#{row['delivery_hour']},'#{row['delivery_date']}')" if analytics_table=='temp_adv_devicesproperties'
                                  insert_query="insert into temp_adclients_summaries(ad_client_type,ad_type,impressions,clicks,fill_rate,requests_unique_visitors,revenue,adclient_name,handset,handset_model,user_agent,pub_id,client_id,continent_code,country_code,delivery_hour,delivery_date) VALUES ('#{row['ad_client_type']}','#{row['ad_type']}',#{row['impressions']},#{row['clicks']},#{row['fill_rate']},#{row['requests_unique_visitors']},#{row['revenue']},\"#{row['adclient_name']}\",\"#{row['handset']}\",\"#{row['handset_model']}\",\"#{row['user_agent']}\",#{row['pub_id'].to_i},#{row['client_id']},\"#{row['continent_code']}\",\"#{row['country_code']}\",#{row['delivery_hour']},'#{row['delivery_date']}')" if analytics_table=='temp_adclients_summaries'
                                  insert_query="insert into temp_pub_channels(channel,requests,fill_rate,pub_id,client_id,ad_client_type,delivery_hour,delivery_date) VALUES(\"#{row['chan']}\",#{row['requests']},#{row['fill_rate']},#{row['pub_id'].to_i},#{row['client_id']},'#{row['ad_client_type']}',#{row['delivery_hour']},'#{row['delivery_date']}')" if analytics_table=='temp_pub_channels'
                                  insert_query="insert into temp_pub_carriers(owner,requests,fill_rate,pub_id,client_id,ad_client_type,delivery_hour,delivery_date) VALUES(\"#{row['owner']}\",#{row['requests']},#{row['fill_rate']},#{row['pub_id'].to_i},#{row['client_id']},'#{row['ad_client_type']}',#{row['delivery_hour']},'#{row['delivery_date']}')" if analytics_table=='temp_pub_carriers'
                                  insert_query="insert into temp_pub_urls(url,requests,fill_rate,pub_id,client_id,delivery_hour,delivery_date) VALUES (\"#{(row['url']==nil or row['url']=='') ? row['url'] : row['url'].gsub(',','')}\",#{row['requests']},#{row['fill_rate']},#{row['pub_id'].to_i},#{row['client_id']},#{row['delivery_hour']},'#{row['delivery_date']}')" if analytics_table=='temp_pub_urls'
                                  insert_stat = @dbconn_transaction.do(insert_query)
                                rescue Exception =>e  
                                  puts "Error in ClassName: AnalyticsSummarizer MethodName: reports while inserting records ErrInfo:#{e.to_s}" 
                                  if @mail_status_insert == "true" # "<p style='color:#FF0000'>"+ +"</p>"
                                    $error_insertion_summarizer << "<p style='color:#FF0000'> ERROR :: Analytics Summarizer method (reports) during Insertion...<br />Project: ANALYTICS_SHARDING <br />Job: AnalyticsSummarizer <br />Ip address is: #{ip}<br />Database: #{$shard_db_name}#{db}<br />Table: #{$shard_table_name}#{@table_name}#{table_number}<br />Start_time: #{start_date}<br />End_time: #{end_date}<br />Failure_Time:#{Time.now}<br />Exception is : #{e.to_s}<br /></p>"
                                    @mail_status_insert = "false"
                                  end # end of @mail_status_insert == "true"
                                  failed_insert_records = "true"
                                end
                              end # end of row in select_query
                            end # end of (select_records.length ==0)
                          rescue Exception => e
                            puts "Error in ClassName: AnalyticsSummarizer MethodName: reports while checking length ErrInfo:#{e.to_s}" 
                            select_records = "false"
                            failed_insert_records = "true"
                          end # end of begin
                      #Finnally we are changing the status for the particular table as transaction completed inside analytics_transaction table for each shard database. One processor will go to the next table only if the transaction is complete. If multiple processor try to execute, say first processor is doing the transaction for first table, the second processor will go to the next table and so on.
                      fetch_new_time=Time.now # Fetch the current time again
                      insert_records = "false"
                      fetch_new_time_taken=Time.now # Fetch the current time 'seconds' again
                      new_time_taken = fetch_new_time_taken-time_taken # Calculating the difference between two 'seconds'
                      if zero_record == "true" # If no records are there in ads deliveries table
                        status_val = "Transaction completed for zero record" # set the transaction status as "Transaction completed for zero record"
                      elsif failed_insert_records == "false"  # if records are there  in ads deliveries table and it has been inserted into Analytics summarizer
                        status_val ="Transaction completed" # set the transaction status as "Transaction completed"
                      end # end of zero_record == "true"
                      # Update the transaction status based on records are there in ads deliveries table are not
                      if (zero_record == "true") or (failed_insert_records == "false")
                        begin
                          @dbconn_selection = DBI.connect("DBI:MYSQL:#{$shard_db_name}#{db}:#{ip}", WriteDBServer::USERNAME, WriteDBServer::PASSWORD)
                          update_transaction_status = "update analytics_transaction set status = '#{status_val}', time_taken = #{new_time_taken.to_i} where ip = '#{ip}' and database_name = '#{$shard_db_name}#{db}' and table_name = '#{$shard_table_name}#{@table_name}#{table_number}' and start_datetime='#{start_date}' and end_datetime='#{end_date}' and status = 'Table is locked for reading' and date = '#{curr_date}'"
                          update_status = @dbconn_selection.prepare(update_transaction_status)
                          update_status.execute
                          insert_records = "true"
                          # Store the updated records ip address, database name, table name, start datetime, end datetime and status in $records_array
                          $records_array<< "<p style='color:#0000FF'>Project: ZESTADZ_SHARDING...<br />Job: AnalyticsSummarizer<br />Ip address is:#{ip}<br />Database: #{$shard_db_name}#{db}<br />Table: #{$shard_table_name}#{@table_name}#{table_number}<br />Start_time: #{start_date}<br />End_time: #{end_date}<br />Status: #{status_val}<br /></p>"
                        rescue Exception => e
                          puts "Error in ClassName: AnalyticsSummarizer MethodName: reports while updating ErrInfo:#{e.to_s}" 
                          $error_updation_summarizer << "<p style='color:#FF0000'> ERROR :: Analytics Summarizer method (reports) during Updation...<br />Project: ANALYTICS_SHARDING<br />Job: AnalyticsSummarizer<br />Ip address is: #{ip}<br />Database: #{$shard_db_name}#{db}<br />Table: #{$shard_table_name}#{@table_name}#{table_number}<br />Start_time: #{start_date}<br />End_time: #{end_date}<br />Failure_Time:#{Time.now}<br />Exception is : #{e.to_s}<br /></p>"
                        end
                      else
                          @dbconn_selection = DBI.connect("DBI:MYSQL:#{$shard_db_name}#{db}:#{ip}", WriteDBServer::USERNAME, WriteDBServer::PASSWORD)
                      end #end of (zero_record == "true") or (records == "true")
                      if (insert_records == "false")
                        @dbconn_transaction.do("ROLLBACK")
                      elsif (insert_records == "true")
                        @dbconn_transaction.do("COMMIT")   
                        #puts "Updated successfully for records"                  
                      end # end of  (records == "false")
                      @dbconn_transaction.disconnect if @dbconn_transaction != nil
                    end # end of tx_illegal == "true" or start_date >  end_date or start_date > curr_datetime   
                  rescue Exception =>e  
                    puts "Error in ClassName: AnalyticsSummarizer MethodName: reports while iterating ErrInfo:#{e.to_s}" 
                    select_records = "false"
                    acquire_lock(@dbconn_selection ,RELEASE_LOCK,REPORTS_SUMMARIZER)
                  ensure
                   @dbconn_selection.disconnect if @dbconn_selection != nil
                 end # end of begin
              end #end of analytics_table in analytics_table_arr
            end # end of  table_number in @start_table..@max_table
          end # end of db in $start_db..$maxdb
        end # end of $available_server
      rescue Exception =>e  
        puts "Error in ClassName: AnalyticsSummarizer MethodName: reports ErrInfo:#{e.to_s}" 
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
            obj_tempQuery=AnalyticsQuerySetting.new()
            last_time = Time.now-10800 # Getting current time (3 hours before)
            check_hour = last_time.strftime("%Y-%m-%d %H:%M:%S") # Getting the date and time
            $records_recovery_array = []
            $error_selection_recovery = []
            $error_insertion_recovery = []
            $error_updation_recovery = []
            $ip_array = []
            for ip in $available_server
                for db in $start_db..$maxdb
                    # Here we are going to establish a connection to shard database for transaction table to check any rows is still under the status called 'Table is locked for reading'  based on certain conditions
                    @dbconn_select = DBI.connect("DBI:MYSQL:#{$shard_db_name}#{db}:#{ip}", WriteDBServer::USERNAME, WriteDBServer::PASSWORD)
                    begin
                        get_lock = acquire_lock(@dbconn_select ,ACQUIRE_LOCK,REPORTS_RECOVERY)
                        if(get_lock == 1)
                            # Select the records based on certain condition
                            select_table = "select * from analytics_transaction where status='Table is locked for reading' and ip = '#{ip}' and database_name = '#{$shard_db_name}#{db}' and end_datetime < '#{check_hour}'"
                            select_status_table = @dbconn_select.select_all(select_table)
                            # If records are available, fetch the ip address, database name, table name, start time and end time. And store the values in ip_array
                            if(select_status_table.length > 0)
                              curr_datetime=select_status_table[0]['date']
                              check_currtime=Time.now-10800
                              if check_currtime > Time.parse("#{curr_datetime}")
                                $ip_array = []
                                for row_table in select_status_table
                                    $ip_array<<row_table
                                end #end of row in select_status_table
                                fetch_curr_time = Time.now # Fetch the current time
                                time_taken = Time.now # Fetch the current 'Seconds'
                                select_records = "false"
                                for row in $ip_array # Fetch the records from $ip_array
                                        begin 
                                            select_query_table=obj_tempQuery.selectAnalyticsQuery(row['table_name'],"","",row['start_datetime'],row['end_datetime'],row['analytics_table'])
                                            #~ select_query_table = "select hour(delivery_time) as hour, campaign_id, ad_id, client_id, sum(impressions) as impressions, sum(clicks) as clicks, sum(cost) as cost, sum(publisher_revenue) as publisher_revenue, metrics, ad_client_type from #{row['table_name']} where delivery_time>='#{row['start_datetime']}' and delivery_time<='#{row['end_datetime']}' group by hour, ad_id, client_id order by null"
                                            select_recovery_records = @dbconn_select.select_all(select_query_table)
                                            select_records = "true"
                                        rescue Exception => e
                                            puts "Error in ClassName: AnalyticsSummarizer MethodName: reports_recovery while selcting records ErrInfo:#{e.to_s}" 
                                            puts $error_selection_recovery << "<p style='color:#FF0000'> ERROR :: Analytics Summarizer method (Recovery) For Selection...<br />Project: ANALYTICS_SHARDING<br />Job: Reports_Recovery<br />Ip address is: #{row['ip']}<br />Database: #{row['database_name']}<br />Table: #{row['table_name']}<br />Start_time: #{row['start_datetime']}<br />End_time: #{row['end_datetime']}<br />Failure_Time:#{Time.now}<br />Exception is : #{e.to_s}<br /></p>"
                                            acquire_lock(@dbconn_select,RELEASE_LOCK,REPORTS_RECOVERY)
                                        end
                                        # Establish a connection to the master database
                                        @dbconn_transaction_hours = DBI.connect("DBI:MYSQL:#{$analytics_db}:#{$analytics_ip}",WriteDBServer::USERNAME,WriteDBServer::PASSWORD)
                                        @dbconn_transaction_hours.do("SET AUTOCOMMIT=0")
                                        @dbconn_transaction_hours.do("BEGIN")
                                        #Check if any records is avaiable from #{$shard_db_name} database, If it is available, then insert the records into master database and update the transaction status as "Transaction completed" for the corresponding shard database-> analytics_transaction
                                        analytics_table=row['analytics_table']
                                        zero_record = "false"
                                        failed_recovery_record = "false"
                                        begin
                                            if (select_recovery_records.length ==0) # If no records are there in ads deliveries table
                                                zero_record = "true" # set true to zero_record
                                            elsif(select_recovery_records.length > 0) and (select_records == "true")  
                                                @mail_status_insert = "true"
                                                for row_table in select_recovery_records # Insert the selected rows one by one into the Analytics summarizer table resides in master database. 
                                                    begin 
                                                        break if failed_recovery_record == "true"
                                                        insert_query="insert into temp_campaigns_summaries(metrics,ad_client_type,impressions,clicks,amount_spent,gross_profit,zestadz_revenue,handset,handset_model,unique_visitors,advertiser_id,campaign_id,ad_id,continent_code,country_code,delivery_hour,delivery_date) VALUES ('#{row_table['metrics']}','#{row_table['ad_client_type']}',#{row_table['impressions']},#{row_table['clicks']},#{row_table['amount_spent']},#{row_table['gross_profit']},#{row_table['zestadz_revenue']},\"#{row_table['handset']}\",\"#{row_table['handset_model']}\",'#{row_table['unique_visitors']}',#{row_table['advertiser_id']},#{row_table['campaign_id']},#{row_table['ad_id']},\"#{row_table['continent_code']}\",\"#{row_table['country_code']}\",#{row_table['delivery_hour']},'#{row_table['delivery_date']}')" if analytics_table=='temp_campaigns_summaries'
                                                        insert_query="insert into temp_adv_carriers(owner,requests,advertiser_id,campaign_id,ad_id,delivery_hour,delivery_date) VALUES (\"#{row_table['owner']}\",#{row_table['requests']},#{row_table['advertiser_id']},#{row_table['campaign_id']},#{row_table['ad_id']},#{row_table['delivery_hour']},'#{row_table['delivery_date']}')" if analytics_table=='temp_adv_carriers'
                                                        insert_query="insert into temp_adv_devicesproperties(user_agent,requests,handset,handset_model,advertiser_id,campaign_id,ad_id,delivery_hour,delivery_date) VALUES(\"#{row_table['user_agent']}\",#{row_table['requests']},\"#{row_table['handset']}\",\"#{row_table['handset_model']}\",#{row_table['advertiser_id']},#{row_table['campaign_id']},#{row_table['ad_id']},#{row_table['delivery_hour']},'#{row_table['delivery_date']}')" if analytics_table=='temp_adv_devicesproperties'
                                                        insert_query="insert into temp_adclients_summaries(ad_client_type,ad_type,impressions,clicks,fill_rate,requests_unique_visitors,revenue,adclient_name,handset,handset_model,user_agent,pub_id,client_id,continent_code,country_code,delivery_hour,delivery_date) VALUES ('#{row_table['ad_client_type']}','#{row_table['ad_type']}',#{row_table['impressions']},#{row_table['clicks']},#{row_table['fill_rate']},#{row_table['requests_unique_visitors']},#{row_table['revenue']},\"#{row_table['adclient_name']}\",\"#{row_table['handset']}\",\"#{row_table['handset_model']}\",\"#{row_table['user_agent']}\",#{row_table['pub_id'].to_i},#{row_table['client_id']},\"#{row_table['continent_code']}\",\"#{row_table['country_code']}\",#{row_table['delivery_hour']},'#{row_table['delivery_date']}')" if analytics_table=='temp_adclients_summaries'
                                                        insert_query="insert into temp_pub_channels(channel,requests,fill_rate,pub_id,client_id,ad_client_type,delivery_hour,delivery_date) VALUES(\"#{row_table['chan']}\",#{row_table['requests']},#{row_table['fill_rate']},#{row_table['pub_id'].to_i},#{row_table['client_id']},'#{row_table['ad_client_type']}',#{row_table['delivery_hour']},'#{row_table['delivery_date']}')" if analytics_table=='temp_pub_channels'
                                                        insert_query="insert into temp_pub_carriers(owner,requests,fill_rate,pub_id,client_id,ad_client_type,delivery_hour,delivery_date) VALUES(\"#{row_table['owner']}\",#{row_table['requests']},#{row_table['fill_rate']},#{row_table['pub_id'].to_i},#{row_table['client_id']},'#{row_table['ad_client_type']}',#{row_table['delivery_hour']},'#{row_table['delivery_date']}')" if analytics_table=='temp_pub_carriers'
                                                        insert_query="insert into temp_pub_urls(url,requests,fill_rate,pub_id,client_id,delivery_hour,delivery_date) VALUES (\"#{(row_table['url']==nil or row_table['url']=='') ? row_table['url'] : row_table['url'].gsub(',','')}\",#{row_table['requests']},#{row_table['fill_rate']},#{row_table['pub_id'].to_i},#{row_table['client_id']},#{row_table['delivery_hour']},'#{row_table['delivery_date']}')" if analytics_table=='temp_pub_urls'
                                                        insert_stat = @dbconn_transaction_hours.do(insert_query)
                                                    rescue Exception =>e  
                                                        puts "Error in ClassName: AnalyticsSummarizer MethodName: reports_recovery while inserting ErrInfo:#{e.to_s}" 
                                                        if @mail_status_insert == "true"
                                                            $error_insertion_recovery << "<p style='color:#FF0000'> ERROR :: Analytics Summarizer method (Recovery) for Insertion...<br />Project: ANALYTICS_SHARDING<br />Job: Reports_Recovery<br />Ip address is: #{row['ip']}<br />Database: #{row['database_name']}<br />Table: #{row['table_name']}<br />Analytics Table: #{row['analytics_table']}<br />Start_time: #{row['start_datetime']}<br />End_time: #{row['end_datetime']}<br />Failure_Time:#{Time.now}<br />Exception is : #{e.to_s}<br /></p>"
                                                            @mail_status_insert = "false"
                                                            acquire_lock(@dbconn_select,RELEASE_LOCK,REPORTS_RECOVERY)
                                                        end 
                                                        failed_recovery_record = "true"
                                                    end
                                                end # end of row_table in select_recovery_records
                                            end # end of (select_recovery_records.length ==0)
                                        rescue Exception => e
                                            puts "Error in ClassName: AnalyticsSummarizer MethodName: reports_recovery while checking length ErrInfo:#{e.to_s}" 
                                            select_records = "false"
                                            acquire_lock(@dbconn_select,RELEASE_LOCK,REPORTS_RECOVERY)
                                        end # end of begin
                                    #Finnally we are changing the status for the particular table as transaction completed inside analytics_transaction table for each shard database. One processor will go to the next table only if the transaction is complete. If multiple processor try to execute, say first processor is doing the transaction for first table, the second processor will go to the next table and so on.
                                    fetch_new_time=Time.now # Fetch the current time again
                                    recovery_record = "false"
                                    fetch_new_time_taken=Time.now # Fetch the current time 'seconds' again
                                    new_time_taken = fetch_new_time_taken-time_taken # Calculating the difference between two 'seconds'
                                    if zero_record == "true" # If no records are there in ads deliveries table
                                        status_val = "Transaction completed for zero record"  # set the status as "Transaction completed for zero record"
                                    elsif failed_recovery_record == "false"  # if records are there  in ads deliveries table and it has been inserted into Analytics summarizer
                                        status_val ="Transaction completed" # set the transaction status as "Transaction completed"
                                    end  # end of zero_record == "true"
                                    # Update the transaction status based on records are there in ads deliveries table are not
                                    if(zero_record == "true") or (failed_recovery_record == "false")
                                        begin
                                            update_transaction_status = "update analytics_transaction set status = '#{status_val}', time_taken = #{new_time_taken.to_i} where ip = '#{row['ip']}' and database_name = '#{row['database_name']}' and table_name = '#{row['table_name']}' and analytics_table='#{row['analytics_table']}' and start_datetime='#{row['start_datetime']}' and end_datetime='#{row['end_datetime']}' and status = 'Table is locked for reading' and date = '#{row['date']}'"
                                            update_status = @dbconn_select.prepare(update_transaction_status)
                                            update_status.execute
                                            acquire_lock(@dbconn_select,RELEASE_LOCK,REPORTS_RECOVERY)
                                            recovery_record = "true"
                                            # Store the updated records ip address, database name, table name, start datetime, end datetime and status in $records_array
                                            $records_recovery_array<< "<p style='color:#0000FF'>Project: ZESTADZ_SHARDING<br />Job: Reports_Recovery<br />Ip address is: #{row['ip']}<br />Database: #{row['database_name']}<br />Table: #{row['table_name']}<br />Start_time: #{row['start_datetime']}<br />End_time: #{row['end_datetime']}<br />Status: #{status_val}<br /></p>"
                                        rescue Exception =>e  
                                            puts "Error in ClassName: AnalyticsSummarizer MethodName: reports_recovery while updating ErrInfo:#{e.to_s}" 
                                            $error_updation_recovery << "<p style='color:#FF0000'> ERROR :: Analytics Summarizer method (Recovery) for Updation...<br />Project: ANALYTICS_SHARDING<br />Job: Reports_Recovery<br />Ip address is: #{row['ip']}<br />Database: #{row['database_name']}<br />Table: #{row['table_name']}<br />Start_time: #{row['start_datetime']}<br />End_time: #{row['end_datetime']}<br />Failure_Time:#{Time.now}<br />Exception is : #{e.to_s}<br /></p>"
                                            acquire_lock(@dbconn_select,RELEASE_LOCK,REPORTS_RECOVERY)
                                          end # end of begin
                                    end # end of (zero_record == "true") or (recovery_record == "true")
                                    if (recovery_record == "true") 
                                        @dbconn_transaction_hours.do("COMMIT")
                                        #puts "Updated successfully for recovered records"
                                    elsif recovery_record == "false"
                                        #puts "Going to do roll back"
                                        @dbconn_transaction_hours.do("ROLLBACK")
                                    end # end of recovery_record == "true"
                                $ip_array = [] # After updation, reset the ip_array to fetch new set of records
                                @dbconn_transaction_hours.disconnect if @dbconn_transaction_hours != nil
                               end # end of row in $ip_array
                              else
                                acquire_lock(@dbconn_select,RELEASE_LOCK,REPORTS_RECOVERY)
                              end # if check_currtime > Time.parse(curr_datetime)
                            else
                                #puts "No records are there"
                                $records_recovery_array<< "<p style='color:#0000FF'>Project: ANALYTICS_SHARDING<br />Job: Reports_Recovery<br />Ip address is: #{ip}<br />Database: #{$shard_db_name}#{db}<br />Status: No records in analytics_transaction table<br />Processed Time:#{Time.now.strftime('%Y-%m-%d %H:%M:%S')}<br /></p>"
                                acquire_lock(@dbconn_select,RELEASE_LOCK,REPORTS_RECOVERY)
                            end # if(select_status_table.length!=0)
                        else
                            acquire_lock(@dbconn_select,RELEASE_LOCK,REPORTS_RECOVERY)
                        end  # end of @get_lock_stat[0] == 1
                    rescue Exception => e
                        puts "Error in ClassName: AnalyticsSummarizer MethodName: reports_recovery while iterating ErrInfo:#{e.to_s}" 
                        select_records = "false"
                        acquire_lock(@dbconn_select,RELEASE_LOCK,REPORTS_RECOVERY)
                    end # end of begin
                        @dbconn_select.disconnect if @dbconn_select != nil
                end # end of db in $start_db..$maxdb
            end # end of ip in $available_server
        rescue Exception => e
            puts "Error in ClassName: AnalyticsSummarizer MethodName: reports_recovery ErrInfo:#{e.to_s}" 
            #acquire_lock(@dbconn_select,RELEASE_LOCK,REPORTS_RECOVERY)
        end # end of begin
        end # end of reports_recovery method
    end # end of AnalyticsSummarizer class
  
  #------------------------------------------------------------------------------------
  #Class Name: Updates
  #Purpose: The purpose of the class is to extend theAnalyticsSummarizer class and create and run two threads
  #Version: 1.0
  #Author: Ayshwarya
  #Last-Modified: 30-04-2009
  #-------------------------------------------------------------------------------------
  class Updates < AnalyticsSummarizer
    def send_mail(subject,content)
      begin
        results = ""
        obj=Hash.new
        # Giving the recepient email addresses  
        obj["to"]=["s.sathishkumar@mobile-worx.com","shujaudeen@mobile-worx.com","j.viswanathan@mobile-worx.com"]
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
        puts "Error in ComponentName: AnalyticsSummarizer MethodName: send_mail ErrInfo:#{e.to_s}" 
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
          if ($error_selection_summarizer != [] and (@check_mail_option[:sendmail] == "error" or @check_mail_option[:sendmail] == "all"))
            subject = "Error in Analytics summarizer in reports method whilie selecting."
            send_mail(subject,$error_selection_summarizer)
          end    
          if ($error_insertion_summarizer != [] and (@check_mail_option[:sendmail] == "error" or @check_mail_option[:sendmail] == "all")) 
            subject = "Error in Analytics summarizer in reports method whilie inserting."
            send_mail(subject,$error_insertion_summarizer)
          end  
          if($error_updation_summarizer != [] and (@check_mail_option[:sendmail] == "error" or @check_mail_option[:sendmail] == "all"))
            subject = "Error in Analytics summarizer in reports method whilie updating."
            send_mail(subject,$error_updation_summarizer)
          end  
          if($records_array != [] and @check_mail_option[:sendmail].to_s == "all")
            subject = "Status of Reports Summarizer Component."
            #Fetch the  updated records ip address, database name, table name, start datetime, end datetime and status from $records_array.
            send_mail(subject,$records_array)
          end # end of ($records_array != [])
          $records_array = [] # Reset the $records_array to fetch next set of records
          $error_selection_summarizer = []
          $error_insertion_summarizer = []
          $error_updation_summarizer = [] 
        elsif call_from == "reports_recovery"  
          if ($error_selection_recovery != [] and (@check_mail_option[:sendmail] == "error" or @check_mail_option[:sendmail] == "all"))
             subject = "Error in Analytics summarizer in report_recovery method whilie selecting."
             send_mail(subject,$error_selection_recovery)
          end
          if ($error_insertion_recovery != [] and (@check_mail_option[:sendmail] == "error" or @check_mail_option[:sendmail] == "all"))
            subject = "Error in Analytics summarizer in report_recovery method whilie inserting."
            send_mail(subject,$error_insertion_recovery)
          end
          if($error_updation_recovery != [] and (@check_mail_option[:sendmail] == "error" or @check_mail_option[:sendmail] == "all"))
            subject = "Error in Analytics summarizer in report_recovery method whilie updating."
            send_mail(subject,$error_updation_recovery)
          end
          if ($records_recovery_array != [] and @check_mail_option[:sendmail].to_s == "all")
            #Fetch the  updated records ip address, database name, table name, start datetime, end datetime and status from $records_recovery_array
            subject = "Recovered records in Reports Summarizer Component"
            send_mail(subject,$records_recovery_array)
          end # end of ($records_recovery_array != [])
          $records_recovery_array = [] # Reset the $records_recovery_array to fetch next set of records
          $error_selection_recovery = []
          $error_insertion_recovery = []
          $error_updation_recovery = []
        end # end of call_from == "reports"  
      rescue Exception => e
        puts "Error in ComponentName: AnalyticsSummarizer MethodName: chk_send_mail ErrInfo:#{e.to_s}" 
      end   
    end  # end of method chk_send_mail
    
    #-------------------------------------------------------------------------------------
    #Method Name: cronjob
    #Purpose: This action is to run the server continously. Call the reports method for every one hour and reports_recovery method for every 30 minutes
    #Version: 1.0
    #Author: Ayshwarya
    #Last-Modified: 30-04-2009
    #--------------------------------------------------------------------------------------
    def cronjob
      begin
        puts "Analytics summarizer has been started..."
        begin # this begin is for while loop.
          begin  #this begin is used for rescue inside the loop.
          #For the first time, it calls the reports method. After that it will be in sleep state for 1 hour. Again it will call the reports mehtod. This is going to be a continous process
          obj_reports = AnalyticsSummarizer.new 
          obj_reports.reports
          obj_reports = nil
          chk_send_mail("reports") 
          if $ant_process == "multiple"
            obj_multiple_reports = AnalyticsSummarizer.new("parallel") 
            obj_multiple_reports.reports
            obj_multiple_reports = nil
            chk_send_mail("reports") 
          end  
          sleep(300) #Set the sleep state for 25 seconds
          #call the reports recovery method..
          obj_reports_update = AnalyticsSummarizer.new  #Create an object for the AnalyticsSummarizer class 
          obj_reports_update.reports_recovery # Call the reports_recovery method with the object
          chk_send_mail("reports_recovery") 
          obj_reports_update = nil #Set the object as nil
          if $ant_process_rec == "multiple"
            obj_rec_multiple = AnalyticsSummarizer.new("parallel")  
            obj_rec_multiple.reports_recovery
            obj_rec_multiple = nil
            chk_send_mail("reports_recovery") 
          end  
          rescue Exception => e
            puts "Error in ComponentName: AnalyticsSummarizer MethodName: cronjob while iterating ErrInfo:#{e.to_s}" 
          end  
        end while(true)        
      rescue Exception => e
        puts "Error in ComponentName: AnalyticsSummarizer MethodName: cronjob ErrInfo:#{e.to_s}" 
      end 
    end # end of cronjob method
  end # end of Updates class
#Creating the object and call the updation method first
obj = Updates.new()
obj.cronjob

