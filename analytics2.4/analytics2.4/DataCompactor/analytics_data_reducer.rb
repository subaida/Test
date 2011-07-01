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
require 'email_component.rb'
require 'time'
require 'date'
require 'settings.rb'
require 'reducer_query_setting.rb'
#------------------------------------------------------------------------------------
#class Name: AnalyticsDataReducer
#Purpose: The purpose of this class is to check the reducer_transaction table. If no rows are available, then set the status for transaction. Then read all the tables, do the calculations and insert the final results into main analytics table. Finnaly update the status in reducer_transaction table resides in temp_database.
#Version: 1.0
#Author: Md Shujauddeen
#Last-Modified: 25-Jan-2009
#-------------------------------------------------------------------------------------
class AnalyticsDataReducer
    #initialize constant variables used in acquire lock method.
    ACQUIRE_LOCK="GET_LOCK"
    RELEASE_LOCK="RELEASE_LOCK"
    REPORTS_SUMMARIZER = "reducer_reports_string"
    REPORTS_RECOVERY = "reducer_recovery_string"
    @@getsymbol={"&"=>"\\&","%"=>"\\%","'"=>"\\'",","=>""}
    #------------------------------------------------------------------------------------
    #Method Name: initilaize
    #Purpose: This action is to call the re_initialize method for initializing the values to global variables.
    #Version: 1.0
    #Author: Md Shujauddeen
    #Last-Modified: 23-03-2009
    #-------------------------------------------------------------------------------------
    def initialize(*args)
      begin
        #puts "REDUCER INITIALIZE METHOD"
        #call the re_initialize method for initializing the values to global variables.
          re_initialize 
      rescue Exception => e
        puts "Error in ClassName:AnalyticsDataReducer MethodName:initialize ErrInfo:#{e.to_s} " 
      end      
    end   
    
  #------------------------------------------------------------------------------------
  #class Name: AnalyticsDataReducer
  #method name: re_initialize
  #Purpose: The purpose of this method is to re_initialize the class variables when the time comes from even hour to odd hour and vice versa..
  #Version: 1.0
  #Author: Md Shujauddeen
  #Last-Modified by: Md Shujauddeen
  #created-on: 25-Jan-2009
  #Last-Modified: 25-Jan-2009
  #-------------------------------------------------------------------------------------      
  def re_initialize(*args)
    begin
      #puts "Reducers Re-Initialize method..."
        @@analytics_read_ip=AnalyticsDBReadServer::IP
        @@analytics_read_db=AnalyticsDBReadServer::REDUCE_DATABASE
        @@analytics_write_ip=AnalyticsDBWriteServer::IP
        @@analytics_write_db=AnalyticsDBWriteServer::DATABASE
        @@max_id=GetMaxId::MAXID
    rescue Exception => e
      puts "Error in ClassName: AnalyticsDataReducer MethodName: re_initialize ErrInfo:#{e.to_s}" 
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
        puts "Error in ClassName: AnalyticsDataReducer MethodName: acquire_lock ErrInfo:#{e.to_s}" 
      end
    end  #end of method acquire_lock
    #-------------------------------------------------------------------------------------
    #Method Name: reducer
    #Purpose: This method is used to read and group the analytics data from temporary analytics table. And then it inserts the resultant records into main analytics tables.
    #Version: 1.0
    #Author: Md Shujauddeen
    #Last-Modified by: Md Shujauddeen
    #Last-Modified: 30-04-2009
    #--------------------------------------------------------------------------------------
    def reducer
      begin
        obj_tempQuery=ReducerQuerySetting.new()
        @@reducer_array = []
        @@error_selection_reducer = []
        @@error_selection_reducer = []
        @@error_updation_reducer = []
        # Create analytics table array
        table_detail=['reduce_campaigns_summaries','reduce_adv_carriers','reduce_adv_devicesproperties','reduce_adclients_summaries','reduce_pub_channels','reduce_pub_carriers','reduce_pub_urls','adv_geolocations','adv_handsets','pub_geolocations','pub_handsets','devices_summaries']
        for tblname in table_detail
            @@max_id=300000 if tblname=='reduce_pub_urls'
            @@max_id=GetMaxId::MAXID if tblname!='reduce_pub_urls'
            # Here we are going to establish a connection for transaction table to check the availablitiy of rows for the even hour table. 
            @dbconn_selection = DBI.connect("DBI:MYSQL:#{@@analytics_read_db}:#{@@analytics_read_ip}", AnalyticsDBReadServer::USERNAME, AnalyticsDBReadServer::PASSWORD)
              begin
                tx_illegal = "false"
                get_lock= acquire_lock(@dbconn_selection ,ACQUIRE_LOCK,REPORTS_SUMMARIZER)
                if(get_lock == 1)
                  #Check if any records is available from shard database, check any records having the status as Table is locked for reading' or Transaction completed or Transaction completed for zero records. 
                  select_all="select * from reducer_transaction where tablename='#{tblname}' and (status='Transaction completed' or status = 'Table is locked for reading') order by id desc limit 1"
                  select_status_transaction =@dbconn_selection.select_all(select_all)
                  curr_date=((Time.now)-86400).strftime("%Y-%m-%d")
                  created_at=Time.now.strftime("%Y-%m-%d %H:%M:%S") 
                  processing_table=tblname
                  tblname='reduce_campaigns_summaries' if (tblname=='adv_geolocations' || tblname=='adv_handsets')
                  tblname='reduce_adclients_summaries' if (tblname=='pub_geolocations' || tblname=='pub_handsets' || tblname=='devices_summaries')
                  if select_status_transaction.length == 0 # If no records are there for the whole day.
                      select_max_id="select min(id) as min_id,max(id) as max_id from #{tblname} where delivery_date<='#{curr_date}'"
                      max_id_selection =@dbconn_selection.select_all(select_max_id)
                      if max_id_selection.length == 0
                        start_id=0
                        end_id=0
                      elsif (max_id_selection.length > 0) 
                        start_id=max_id_selection[0]['min_id'].to_i
                        end_id=max_id_selection[0]['max_id'].to_i
                        if ((end_id-start_id).to_i>@@max_id.to_i)
                          end_id=start_id.to_i+@@max_id.to_i
                        end
                      end
                  elsif(select_status_transaction.length > 0) 
                    check_updated_time=(Time.now-3600).strftime("%Y-%m-%d %H:%M:%S") 
                    select_max_id="select id as max_id from #{tblname} where last_updated <='#{check_updated_time}' and delivery_date<='#{curr_date}' order by id desc limit 1"
                    max_id_selection =@dbconn_selection.select_all(select_max_id)
                    start_id=select_status_transaction[0]['end_id'].to_i+1
                    end_id=(max_id_selection==nil || max_id_selection[0]==nil) ? 0 : max_id_selection[0]['max_id'].to_i
                    if ((end_id-start_id).to_i>@@max_id.to_i)
                        end_id=start_id.to_i+@@max_id.to_i
                    end
                  end # end of select_status_transaction.length == 0
                  tblname=processing_table
                else
                  tx_illegal = "true"
                end  # end of @get_lock_stat[0] == 1
                if (tx_illegal == "true" or (start_id==0 && end_id==0) or start_id>end_id)
                  acquire_lock(@dbconn_selection ,RELEASE_LOCK,REPORTS_SUMMARIZER)
                else 
                  insert_transaction_query = "insert into reducer_transaction(tablename,start_id, end_id, status,created_at) values('#{tblname}', '#{start_id}', '#{end_id}', 'Table is locked for reading','#{created_at}')"
                  #puts insert_transaction_query
                  insert_status = @dbconn_selection.do(insert_transaction_query)
                  acquire_lock(@dbconn_selection ,RELEASE_LOCK,REPORTS_SUMMARIZER)
                  time_taken=Time.now# Fetch the current time 'seconds' 
                  select_records = "false"
                      begin
                        select_stat=obj_tempQuery.selectReducerQuery(start_id,end_id,tblname)
                        select_query = @dbconn_selection.select_all(select_stat)
                        @dbconn_selection.disconnect if @dbconn_selection != nil    
                        select_records = "true"
                      rescue Exception =>e  
                        puts "Error in ClassName: AnalyticsDataReducer MethodName: reducer while selcting records ErrInfo:#{e.to_s}" 
                        puts @@error_selection_reducer << "<p style='color:#FF0000'> ERROR :: REDUCER method during Selection...<br />Project: ANALYTICS_REDUCER<br />Job: AnalyticsDataReducer<br />Table: #{tblname}<br />Start_id: #{start_id}<br />End_id: #{end_id}<br />Failure_Time:#{Time.now}<br />Exception is : #{e.to_s}<br /></p>"
                      end
                      #Establish a connection to analytics databse to insert the reduced data.
                      @dbconn_transaction = DBI.connect("DBI:MYSQL:#{@@analytics_write_db}:#{@@analytics_write_ip}", AnalyticsDBWriteServer::USERNAME, AnalyticsDBWriteServer::PASSWORD)
                      @dbconn_transaction.do("SET AUTOCOMMIT=0")
                      @dbconn_transaction.do("BEGIN")
                      insert_records = "true"
                      begin
                        if ((select_query.length > 0)  and (select_records == "true"))
                          @mail_status_insert = "true"
                          count=0
                          global_count=0
                          flag=nil
                          requests=0
                          url=''
                          fill_rate=0
                          pub_id=0
                          client_id=0
                          delivery_hour=0
                          delivery_date=''
                          url_flag=true
                          for row in select_query # Insert the selected rows one by one into the REDUCER table resides in master database. 
                           break if  insert_records == "false"
                            begin
                              insert_query="insert into campaigns_summaries(metrics,ad_client_type,impressions,clicks,amount_spent,gross_profit,zestadz_revenue,unique_visitors,advertiser_id,campaign_id,ad_id,delivery_hour,delivery_date) VALUES ('#{row['metrics']}','#{row['ad_client_type']}',#{row['impression']},#{row['click']},#{row['amt_spent']},#{row['grs_profit']},#{row['zest_revenue']},'#{row['uniq_visitors']}',#{row['advertiser_id']},#{row['campaign_id']},#{row['ad_id']},#{row['delivery_hour']},'#{row['delivery_date']}')" if tblname.to_s=='reduce_campaigns_summaries'
                              insert_query="insert into adv_carrier(carriers,requests,advertiser_id,campaign_id,ad_id,delivery_hour,delivery_date) VALUES(\"#{row['operator']}\",#{row['requests']},#{row['advertiser_id']},#{row['campaign_id']},'#{row['ad_id']}',#{row['delivery_hour']},'#{row['delivery_date']}')" if tblname.to_s=='reduce_adv_carriers'
                              insert_query="insert into adv_deviceproperties(properties,requests,advertiser_id,campaign_id,ad_id,delivery_hour,delivery_date) VALUES ('#{row['properties']}','#{row['requests']}',#{row['advertiser_id']},#{row['campaign_id']},#{row['ad_id']},#{row['delivery_hour']},'#{row['delivery_date']}')" if tblname.to_s=='reduce_adv_devicesproperties'
                              insert_query="insert into adclients_summaries(ad_client_type,ad_type,impressions,clicks,fill_rate,requests_unique_visitors,revenue,pub_id,client_id,delivery_hour,delivery_date) VALUES ('#{row['ad_client_type']}','#{row['ad_type']}',#{row['impression']},#{row['click']},#{row['fl_rate']},#{row['sum_visitor']},#{row['sum_revenue']},#{row['pub_id']},#{row['client_id']},#{row['delivery_hour']},'#{row['delivery_date']}')" if tblname.to_s=='reduce_adclients_summaries'
                              insert_query="insert into pub_channels(channel,requests,fill_rate,pub_id,client_id,ad_client_type,delivery_hour,delivery_date) VALUES(\"#{row['channel']}\",#{row['request']},#{row['fl_rate']},#{row['pub_id']},#{row['client_id']},'#{row['ad_client_type']}',#{row['delivery_hour']},'#{row['delivery_date']}')" if tblname.to_s=='reduce_pub_channels'
                              insert_query="insert into pub_carrier(carriers,requests,fill_rate,pub_id,client_id,ad_client_type,delivery_hour,delivery_date) VALUES(\"#{row['operator']}\",#{row['requests']},#{row['fl_rate']},#{row['pub_id']},#{row['client_id']},'#{row['ad_client_type']}',#{row['delivery_hour']},'#{row['delivery_date']}')" if tblname.to_s=='reduce_pub_carriers'
                              if tblname.to_s=='reduce_pub_urls'
                                  global_count+=1
                                  if flag!=nil and flag!=row['client_id'].to_i
                                      if count>5
                                          insert_query="insert into pub_urls(url,requests,fill_rate,pub_id,client_id,delivery_hour,delivery_date) VALUES (\"#{url}\",#{requests},#{fill_rate},#{pub_id},#{client_id},#{delivery_hour},'#{delivery_date}')"
                                          insert_stat = @dbconn_transaction.do(insert_query)
                                      end
                                      count=0
                                      requests=0
                                      fill_rate=0
                                      url=''
                                      pub_id=0
                                      client_id=0
                                      delivery_hour=0
                                      delivery_date=''  
                                  end
                                  flag=row['client_id'].to_i
                                  count+=1
                                  if (count.to_i<=5)
                                      insert_query="insert into pub_urls(url,requests,fill_rate,pub_id,client_id,delivery_hour,delivery_date) VALUES (\"#{row['url']}\",#{row['request']},#{row['fl_rate']},#{row['pub_id']},#{row['client_id']},#{row['delivery_hour']},'#{row['delivery_date']}')"
                                      url_flag=true
                                  else
                                      url_flag=false
                                      requests+=row['request'].to_i
                                      fill_rate+=row['fl_rate'].to_i
                                      url='Others'
                                      pub_id=row['pub_id']
                                      client_id=row['client_id']
                                      delivery_hour=row['delivery_hour']
                                      delivery_date=row['delivery_date']
                                      if(select_query.length.to_i==global_count.to_i)
                                        url_flag=true
                                        insert_query="insert into pub_urls(url,requests,fill_rate,pub_id,client_id,delivery_hour,delivery_date) VALUES (\"#{url}\",#{requests},#{fill_rate},#{pub_id},#{client_id},#{delivery_hour},'#{delivery_date}')"
                                      end
                                  end
                              end
                              insert_query="insert into adv_geolocations(impressions,continent_code ,country_code,advertiser_id,campaign_id,ad_id,delivery_hour,delivery_date) VALUES (#{row['impression']},\"#{row['continent_code']}\" ,\"#{row['country_code']}\",#{row['advertiser_id']},#{row['campaign_id']},#{row['ad_id']},#{row['delivery_hour']},'#{row['delivery_date']}')" if tblname.to_s=='adv_geolocations'
                              insert_query="insert into adv_handsets(impressions,handset,handset_model,advertiser_id,campaign_id,ad_id,delivery_hour,delivery_date) VALUES (#{row['impression']}, \"#{row['handset']}\" ,\"#{row['handset_model']}\",#{row['advertiser_id']},#{row['campaign_id']},#{row['ad_id']},#{row['delivery_hour']},'#{row['delivery_date']}')" if tblname.to_s=='adv_handsets'
                              insert_query="insert into pub_geolocations(ad_client_type,impressions,clicks,fill_rate,revenue,continent_code,country_code,pub_id,client_id,delivery_hour,delivery_date) VALUES ('#{row['ad_client_type']}',#{row['impression']},#{row['click']},#{row['fl_rate']},#{row['sum_revenue']},\"#{row['continent_code']}\",\"#{row['country_code']}\",#{row['pub_id']},#{row['client_id']},#{row['delivery_hour']},'#{row['delivery_date']}')" if tblname.to_s=='pub_geolocations'
                              insert_query="insert into pub_handsets(ad_client_type,impressions,fill_rate,handset,handset_model,pub_id,client_id,delivery_hour,delivery_date) VALUES ('#{row['ad_client_type']}',#{row['impression']},#{row['fl_rate']},\"#{row['handset']}\",\"#{row['handset_model']}\",#{row['pub_id']},#{row['client_id']},#{row['delivery_hour']},'#{row['delivery_date']}')" if tblname.to_s=='pub_handsets'
                              insert_query="insert into devices_summaries(ad_client_type,impressions,fill_rate,handset,user_agent,country_code,continent_code,delivery_hour,delivery_date) VALUES ('#{row['ad_client_type']}',#{row['impression']},#{row['fl_rate']},\"#{row['handset']}\",\"#{row['user_agent']}\",\"#{row['country_code']}\",\"#{row['continent_code']}\",#{row['delivery_hour']},'#{row['delivery_date']}')" if tblname.to_s=='devices_summaries'
                              insert_stat = @dbconn_transaction.do(insert_query) if url_flag==true
                            rescue Exception =>e 
                              insert_records = "false"
                              puts "Error in ClassName: AnalyticsDataReducer MethodName: reducer while inserting records ErrInfo:#{e.to_s}" 
                              if @mail_status_insert == "true" 
                                @@error_selection_reducer << "<p style='color:#FF0000'> ERROR :: REDUCER method during Insertion...<br />Project: ANALYTICS_REDUCER <br />Job: AnalyticsDataReducer <br />Table: #{tblname}<br />Start_id: #{start_id}<br />End_id: #{end_id}<br />Failure_Time:#{Time.now}<br />Exception is : #{e.to_s}<br /></p>"
                                @mail_status_insert = "false"
                              end # end of @mail_status_insert == "true"
                            end
                          end # end of row in select_query
                        end # end of (select_query.length > 0)  and (select_records == "true")
                      rescue Exception => e
                        puts "Error in ClassName: AnalyticsDataReducer MethodName: reducer while checking length ErrInfo:#{e.to_s}" 
                        select_records = "false"
                        insert_records = "false"
                      end # end of begin
                  fetch_new_time=(Time.now)  # Fetch the current time again
                  new_time_taken = fetch_new_time-time_taken # Calculating the difference between two 'seconds'
                  if insert_records == "true"  # if records are there  in ads deliveries table and it has been inserted into REDUCER
                    status_val ="Transaction completed" # set the transaction status as "Transaction completed"
                  end # end of insert_records == "true"
                  # Update the transaction status based on records are there in ads deliveries table are not
                  @dbconn_selection = DBI.connect("DBI:MYSQL:#{@@analytics_read_db}:#{@@analytics_read_ip}", AnalyticsDBReadServer::USERNAME, AnalyticsDBReadServer::PASSWORD)
                  if (insert_records == "true")
                    begin
                      update_transaction_status = "update reducer_transaction set status = '#{status_val}', time_taken = #{new_time_taken.to_i} where tablename = '#{tblname}' and start_id='#{start_id}' and end_id='#{end_id}' and status = 'Table is locked for reading' and created_at = '#{created_at}'"
                      update_status = @dbconn_selection.prepare(update_transaction_status)
                      update_status.execute
                      insert_records = "true"
                      # Store the updated records ip address, database name, table name, start datetime, end datetime and status in @@reducer_array
                      @@reducer_array<< "<p style='color:#0000FF'>Project: ANALYTICS_REDUCER...<br />Job: AnalyticsDataReducer<br />Table: #{tblname}<br />Start_id: #{start_id}<br />End_id: #{end_id}<br />Status: #{status_val}<br /></p>"
                    rescue Exception => e
                      puts "Error in ClassName: AnalyticsDataReducer MethodName: reducer while updating ErrInfo:#{e.to_s}" 
                      @@error_updation_reducer << "<p style='color:#FF0000'> ERROR :: REDUCER method during Updation...<br />Project: ANALYTICS_REDUCER<br />Job: AnalyticsDataReducer<br />Table: #{tblname}<br />Start_id: #{start_id}<br />End_id: #{end_id}<br />Failure_Time:#{Time.now}<br />Exception is : #{e.to_s}<br /></p>"
                       insert_records = "false"
                    end
                  end #end of (zero_record == "true") or (records == "true")
                  if (insert_records == "false")
                    @dbconn_transaction.do("ROLLBACK")
                  elsif (insert_records == "true")
                    @dbconn_transaction.do("COMMIT")   
                  end # end of  (records == "false")
                    @dbconn_transaction.disconnect if @dbconn_transaction != nil
                end # end of tx_illegal == "true" or start_date >  end_date or start_date > curr_datetime   
              rescue Exception =>e  
                @dbconn_transaction.disconnect if @dbconn_transaction != nil
                puts "Error in ClassName: AnalyticsDataReducer MethodName: reducer while iterating ErrInfo:#{e.to_s}" 
                select_records = "false"
                acquire_lock(@dbconn_selection ,RELEASE_LOCK,REPORTS_SUMMARIZER)
              end # end of begin
            @dbconn_selection.disconnect if @dbconn_selection != nil
        end # end of tblname in table_detail
      rescue Exception =>e  
        puts "Error in ClassName: AnalyticsDataReducer MethodName: reducer ErrInfo:#{e.to_s}" 
      end # end of begin 
    end # end of reducer method
    
    #-------------------------------------------------------------------------------------
    #Method Name: reducer_recovery
    #Purpose: This action is to check the reducer transaction status. If it is  "Table is locked for reading" and end time for that particular record exceeds 3 hours, select the records and do the transaction. Finnaly update its status as 'Transaction completed'
    #Version: 1.0
    #Author: Md Shujauddeen
    #Last-Modified by: Md Shujauddeen
    #Last-Modified: 30-04-2009
    #--------------------------------------------------------------------------------------
    def reducer_recovery
        begin
            obj_tempQuery=ReducerQuerySetting.new()
            last_time = Time.now-7200 # Getting current time (3 hours before)
            check_hour = last_time.strftime("%Y-%m-%d %H:%M:%S") # Getting the date and time
            @@reducer_recovery_array = []
            @@error_selection_reducer_recovery = []
            @@error_selection_reducer_recovery = []
            @@error_updation_reducer_recovery = []
            $failed_txn_array = []
            updated_at=Time.now.strftime("%Y-%m-%d %H:%M:%S") 
            # Create analytics table array
            table_detail=['reduce_campaigns_summaries','reduce_adv_carriers','reduce_adv_devicesproperties','reduce_adclients_summaries','reduce_pub_channels','reduce_pub_carriers','reduce_pub_urls','adv_geolocations','adv_handsets','pub_geolocations','pub_handsets','devices_summaries']
                for tblname in table_detail
                    # Here we are going to establish a connection to shard database for transaction table to check any rows is still under the status called 'Table is locked for reading'  based on certain conditions
                    @dbconn_select = DBI.connect("DBI:MYSQL:#{@@analytics_read_db}:#{@@analytics_read_ip}", AnalyticsDBReadServer::USERNAME, AnalyticsDBReadServer::PASSWORD)
                    begin
                        get_lock = acquire_lock(@dbconn_select ,ACQUIRE_LOCK,REPORTS_RECOVERY)
                        if(get_lock == 1)
                            # Select the records based on certain condition
                            select_table = "select * from reducer_transaction where status='Table is locked for reading' and tablename = '#{tblname}' and created_at < '#{check_hour}'"
                            select_status_table = @dbconn_select.select_all(select_table)
                            # If records are available, fetch the ip address, database name, table name, start time and end time. And store the values in failed_txn_array
                            if(select_status_table.length > 0)
                                $failed_txn_array = []
                                for row_table in select_status_table
                                    $failed_txn_array<<row_table
                                end #end of row in select_status_table
                                time_taken = (Time.now)# Fetch the current 'Seconds'
                                select_records = "false"
                                for row in $failed_txn_array # Fetch the records from $failed_txn_array
                                        begin 
                                            select_query_table=obj_tempQuery.selectReducerQuery(row['start_id'],row['end_id'],row['tablename'])
                                            #~ select_query_table = "select hour(delivery_time) as hour, campaign_id, ad_id, client_id, sum(impressions) as impressions, sum(clicks) as clicks, sum(cost) as cost, sum(publisher_revenue) as publisher_revenue, metrics, ad_client_type from #{row['table_name']} where delivery_time>='#{row['start_datetime']}' and delivery_time<='#{row['end_datetime']}' group by hour, ad_id, client_id order by null"
                                            select_recovery_records = @dbconn_select.select_all(select_query_table)
                                            select_records = "true"
                                        rescue Exception => e
                                            puts "Error in ClassName: AnalyticsDataReducer MethodName: reducer_recovery while selcting records ErrInfo:#{e.to_s}" 
                                            puts @@error_selection_reducer_recovery << "<p style='color:#FF0000'> ERROR :: REDUCER method (Recovery) For Selection...<br />Project: ANALYTICS_REDUCER<br />Job: reducer_Recovery<br />Table: #{row['tablename']}<br />Start_id: #{row['start_id']}<br />End_id: #{row['end_id']}<br />Failure_Time:#{Time.now}<br />Exception is : #{e.to_s}<br /></p>"
                                            acquire_lock(@dbconn_select,RELEASE_LOCK,REPORTS_RECOVERY)
                                        end
                                        #Check if any records is avaiable from #{$shard_db_name} database, If it is available, then insert the records into master database and update the transaction status as "Transaction completed" for the corresponding shard database-> analytics_transaction
                                        failed_recovery_record = "false"
                                        @dbconn_transaction_hours = DBI.connect("DBI:MYSQL:#{@@analytics_write_db}:#{@@analytics_write_ip}",AnalyticsDBWriteServer::USERNAME,AnalyticsDBWriteServer::PASSWORD)
                                        @dbconn_transaction_hours.do("SET AUTOCOMMIT=0")
                                        @dbconn_transaction_hours.do("BEGIN")
                                        begin
                                            @dbconn_select.disconnect if @dbconn_select != nil      
                                            if((select_recovery_records.length > 0) and (select_records == "true"))  
                                                @mail_status_insert = "true"
                                                count=0
                                                global_count=0
                                                flag=nil
                                                requests=0
                                                url=''
                                                fill_rate=0
                                                pub_id=0
                                                client_id=0
                                                delivery_hour=0
                                                delivery_date=''
                                                url_flag=true
                                                for row_table in select_recovery_records # Insert the selected rows one by one into the REDUCER table resides in analytics database. 
                                                    begin 
                                                        insert_query="insert into campaigns_summaries(metrics,ad_client_type,impressions,clicks,amount_spent,gross_profit,zestadz_revenue,unique_visitors,advertiser_id,campaign_id,ad_id,delivery_hour,delivery_date) VALUES ('#{row_table['mrow_tableetrics']}','#{row_table['ad_client_type']}',#{row_table['impression']},#{row_table['click']},#{row_table['amt_spent']},#{row_table['grs_profit']},#{row_table['zest_revenue']},'#{row_table['uniq_visitors']}',#{row_table['advertiser_id']},#{row_table['campaign_id']},#{row_table['ad_id']},#{row_table['delivery_hour']},'#{row_table['delivery_date']}')" if tblname.to_s=='reduce_campaigns_summaries'
                                                        insert_query="insert into adv_carrier(carriers,requests,advertiser_id,campaign_id,ad_id,delivery_hour,delivery_date) VALUES(\"#{row_table['operator']}\",#{row_table['requests']},#{row_table['advertiser_id']},#{row_table['campaign_id']},'#{row_table['ad_id']}',#{row_table['delivery_hour']},'#{row_table['delivery_date']}')" if tblname.to_s=='reduce_adv_carriers'
                                                        insert_query="insert into adv_deviceproperties(properties,requests,advertiser_id,campaign_id,ad_id,delivery_hour,delivery_date) VALUES ('#{row_table['properties']}','#{row_table['requests']}',#{row_table['advertiser_id']},#{row_table['campaign_id']},#{row_table['ad_id']},#{row_table['delivery_hour']},'#{row_table['delivery_date']}')" if tblname.to_s=='reduce_adv_devicesproperties'
                                                        insert_query="insert into adclients_summaries(ad_client_type,ad_type,impressions,clicks,fill_rate,requests_unique_visitors,revenue,pub_id,client_id,delivery_hour,delivery_date) VALUES ('#{row_table['ad_client_type']}','#{row_table['ad_type']}',#{row_table['impression']},#{row_table['click']},#{row_table['fl_rate']},#{row_table['sum_visitor']},#{row_table['sum_revenue']},#{row_table['pub_id']},#{row_table['client_id']},#{row_table['delivery_hour']},'#{row_table['delivery_date']}')" if tblname.to_s=='reduce_adclients_summaries'
                                                        insert_query="insert into pub_channels(channel,requests,fill_rate,pub_id,client_id,ad_client_type,delivery_hour,delivery_date) VALUES(\"#{row_table['channel']}\",#{row_table['request']},#{row_table['fl_rate']},#{row_table['pub_id']},#{row_table['client_id']},'#{row_table['ad_client_type']}',#{row_table['delivery_hour']},'#{row_table['delivery_date']}')" if tblname.to_s=='reduce_pub_channels'
                                                        insert_query="insert into pub_carrier(carriers,requests,fill_rate,pub_id,client_id,ad_client_type,delivery_hour,delivery_date) VALUES(\"#{row_table['operator']}\",#{row_table['requests']},#{row_table['fl_rate']},#{row_table['pub_id']},#{row_table['client_id']},'#{row_table['ad_client_type']}',#{row_table['delivery_hour']},'#{row_table['delivery_date']}')" if tblname.to_s=='reduce_pub_carriers'
                                                        if tblname.to_s=='reduce_pub_urls'
                                                            global_count+=1
                                                            if flag!=nil and flag!=row_table['client_id'].to_i
                                                                if count>5
                                                                    insert_query="insert into pub_urls(url,requests,fill_rate,pub_id,client_id,delivery_hour,delivery_date) VALUES (\"#{url}\",#{requests},#{fill_rate},#{pub_id},#{client_id},#{delivery_hour},'#{delivery_date}')"
                                                                    insert_stat = @dbconn_transaction_hours.do(insert_query)
                                                                end
                                                                count=0
                                                                requests=0
                                                                fill_rate=0
                                                                url=''
                                                                pub_id=0
                                                                client_id=0
                                                                delivery_hour=0
                                                                delivery_date=''  
                                                            end
                                                            flag=row_table['client_id'].to_i
                                                            count+=1
                                                            if (count.to_i<=5)
                                                                insert_query="insert into pub_urls(url,requests,fill_rate,pub_id,client_id,delivery_hour,delivery_date) VALUES (\"#{row_table['url']}\",#{row_table['request']},#{row_table['fl_rate']},#{row_table['pub_id']},#{row_table['client_id']},#{row_table['delivery_hour']},'#{row_table['delivery_date']}')"
                                                                url_flag=true
                                                            else
                                                                url_flag=false
                                                                requests+=row_table['request'].to_i
                                                                fill_rate+=row_table['fl_rate'].to_i
                                                                url='Others'
                                                                pub_id=row_table['pub_id']
                                                                client_id=row_table['client_id']
                                                                delivery_hour=row_table['delivery_hour']
                                                                delivery_date=row_table['delivery_date']
                                                                if(select_recovery_records.length.to_i==global_count.to_i)
                                                                  url_flag=true
                                                                  insert_query="insert into pub_urls(url,requests,fill_rate,pub_id,client_id,delivery_hour,delivery_date) VALUES (\"#{url}\",#{requests},#{fill_rate},#{pub_id},#{client_id},#{delivery_hour},'#{delivery_date}')"
                                                                end
                                                            end
                                                        end
                                                        insert_query="insert into adv_geolocations(impressions,continent_code ,country_code,advertiser_id,campaign_id,ad_id,delivery_hour,delivery_date) VALUES (#{row_table['impression']},\"#{row_table['continent_code']}\" ,\"#{row_table['country_code']}\",#{row_table['advertiser_id']},#{row_table['campaign_id']},#{row_table['ad_id']},#{row_table['delivery_hour']},'#{row_table['delivery_date']}')" if tblname.to_s=='adv_geolocations'
                                                        insert_query="insert into adv_handsets(impressions,handset,handset_model,advertiser_id,campaign_id,ad_id,delivery_hour,delivery_date) VALUES (#{row_table['impression']}, \"#{row_table['handset']}\" ,\"#{row_table['handset_model']}\",#{row_table['advertiser_id']},#{row_table['campaign_id']},#{row_table['ad_id']},#{row_table['delivery_hour']},'#{row_table['delivery_date']}')" if tblname.to_s=='adv_handsets'
                                                        insert_query="insert into pub_geolocations(ad_client_type,impressions,clicks,fill_rate,revenue,continent_code,country_code,pub_id,client_id,delivery_hour,delivery_date) VALUES ('#{row_table['ad_client_type']}',#{row_table['impression']},#{row_table['click']},#{row_table['fl_rate']},#{row_table['sum_revenue']},\"#{row_table['continent_code']}\",\"#{row_table['country_code']}\",#{row_table['pub_id']},#{row_table['client_id']},#{row_table['delivery_hour']},'#{row_table['delivery_date']}')" if tblname.to_s=='pub_geolocations'
                                                        insert_query="insert into pub_handsets(ad_client_type,impressions,fill_rate,handset,handset_model,pub_id,client_id,delivery_hour,delivery_date) VALUES ('#{row_table['ad_client_type']}',#{row_table['impression']},#{row_table['fl_rate']},\"#{row_table['handset']}\",\"#{row_table['handset_model']}\",#{row_table['pub_id']},#{row_table['client_id']},#{row_table['delivery_hour']},'#{row_table['delivery_date']}')" if tblname.to_s=='pub_handsets'
                                                        insert_query="insert into devices_summaries(ad_client_type,impressions,fill_rate,handset,user_agent,country_code,continent_code,delivery_hour,delivery_date) VALUES ('#{row_table['ad_client_type']}',#{row_table['impression']},#{row_table['fl_rate']},\"#{row_table['handset']}\",\"#{row_table['user_agent']}\",\"#{row_table['country_code']}\",\"#{row_table['continent_code']}\",#{row_table['delivery_hour']},'#{row_table['delivery_date']}')" if tblname.to_s=='devices_summaries'
                                                        insert_stat = @dbconn_transaction_hours.do(insert_query) if url_flag==true
                                                    rescue Exception =>e  
                                                        puts "Error in ClassName: AnalyticsDataReducer MethodName: reducer_recovery while inserting ErrInfo:#{e.to_s}" 
                                                        if @mail_status_insert == "true"
                                                            @@error_selection_reducer_recovery << "<p style='color:#FF0000'> ERROR :: REDUCER method (Recovery) for Insertion...<br />Project: ANALYTICS_REDUCER<br />Job: reducer_Recovery<br />Table: #{row['tablename']}<br />Start_id: #{row['start_id']}<br />End_id: #{row['end_id']}<br />Failure_Time:#{Time.now}<br />Exception is : #{e.to_s}<br /></p>"
                                                            @mail_status_insert = "false"
                                                            @dbconn_select = DBI.connect("DBI:MYSQL:#{@@analytics_read_db}:#{@@analytics_read_ip}", AnalyticsDBReadServer::USERNAME, AnalyticsDBReadServer::PASSWORD)
                                                            acquire_lock(@dbconn_select,RELEASE_LOCK,REPORTS_RECOVERY)
                                                            @dbconn_select.disconnect if @dbconn_select != nil
                                                        end 
                                                        failed_recovery_record = "true"
                                                    end
                                                end # end of row_table in select_recovery_records
                                            end # end of ((select_recovery_records.length > 0) and (select_records == "true"))
                                        rescue Exception => e
                                            puts "Error in ClassName: AnalyticsDataReducer MethodName: reducer_recovery while checking length ErrInfo:#{e.to_s}" 
                                            select_records = "false"
                                            @dbconn_select = DBI.connect("DBI:MYSQL:#{@@analytics_read_db}:#{@@analytics_read_ip}", AnalyticsDBReadServer::USERNAME, AnalyticsDBReadServer::PASSWORD)
                                            acquire_lock(@dbconn_select,RELEASE_LOCK,REPORTS_RECOVERY)
                                            @dbconn_select.disconnect if @dbconn_select != nil
                                        end # end of begin
                                    #Finnally we are changing the status for the particular table as transaction completed inside analytics_transaction table for each shard database. One processor will go to the next table only if the transaction is complete. If multiple processor try to execute, say first processor is doing the transaction for first table, the second processor will go to the next table and so on.
                                    recovery_record = "false"
                                    fetch_new_time_taken=(Time.now)# Fetch the current time 'seconds' again
                                    new_time_taken = fetch_new_time_taken-time_taken # Calculating the difference between two 'seconds'
                                    if failed_recovery_record == "false"  # if records are there  in ads deliveries table and it has been inserted into REDUCER
                                        status_val ="Transaction completed" # set the transaction status as "Transaction completed"
                                    end  # end of failed_recovery_record == "false"
                                    # Update the transaction status based on records are there in ads deliveries table are not
                                    @dbconn_select = DBI.connect("DBI:MYSQL:#{@@analytics_read_db}:#{@@analytics_read_ip}", AnalyticsDBReadServer::USERNAME, AnalyticsDBReadServer::PASSWORD)
                                    if(failed_recovery_record == "false")
                                        begin
                                            update_transaction_status = "update reducer_transaction set status = '#{status_val}', time_taken = #{new_time_taken.to_i},created_at='#{updated_at}' where tablename = '#{row['tablename']}' and start_id='#{row['start_id']}' and end_id='#{row['end_id']}' and status = 'Table is locked for reading' and created_at = '#{row['created_at']}'"
                                            update_status = @dbconn_select.prepare(update_transaction_status)
                                            update_status.execute
                                            acquire_lock(@dbconn_select,RELEASE_LOCK,REPORTS_RECOVERY)
                                            recovery_record = "true"
                                            # Store the updated records ip address, database name, table name, start datetime, end datetime and status in @@reducer_array
                                            @@reducer_recovery_array<< "<p style='color:#0000FF'>Project: ANALYTICS_REDUCER<br />Job: reducer_Recovery<br />Table: #{row['tablename']}<br />Start_id: #{row['start_id']}<br />End_id: #{row['end_id']}<br />Status: #{status_val}<br /></p>"
                                        rescue Exception =>e  
                                            puts "Error in ClassName: AnalyticsDataReducer MethodName: reducer_recovery while updating ErrInfo:#{e.to_s}" 
                                            @@error_updation_reducer_recovery << "<p style='color:#FF0000'> ERROR :: REDUCER method (Recovery) for Updation...<br />Project: ANALYTICS_REDUCER<br />Job: reducer_Recovery<br />Table: #{row['tablename']}<br />Start_id: #{row['start_id']}<br />End_id: #{row['end_id']}<br />Failure_Time:#{Time.now}<br />Exception is : #{e.to_s}<br /></p>"
                                            acquire_lock(@dbconn_select,RELEASE_LOCK,REPORTS_RECOVERY)
                                        end # end of begin
                                    end # end of  (recovery_record == "true")
                                    if (recovery_record == "true") 
                                        @dbconn_transaction_hours.do("COMMIT")
                                        #puts "Updated successfully for recovered records"
                                    elsif recovery_record == "false"
                                        #puts "Going to do roll back"
                                        @dbconn_transaction_hours.do("ROLLBACK")
                                    end # end of recovery_record == "true"
                                $failed_txn_array = [] # After updation, reset the failed_txn_array to fetch new set of records
                                @dbconn_transaction_hours.disconnect if @dbconn_transaction_hours != nil
                               end # end of row in $failed_txn_array
                            else
                                #puts "No records are there"
                                @@reducer_recovery_array<< "<p style='color:#0000FF'>Project: ANALYTICS_REDUCER<br />Job: reducer_Recovery<br /> Status: No records in analytics_transaction table<br />Processed Time:#{Time.now.strftime('%Y-%m-%d %H:%M:%S')}<br /></p>"
                                acquire_lock(@dbconn_select,RELEASE_LOCK,REPORTS_RECOVERY)
                            end # if(select_status_table.length!=0)
                        else
                            acquire_lock(@dbconn_select,RELEASE_LOCK,REPORTS_RECOVERY)
                        end  # end of @get_lock_stat[0] == 1
                    rescue Exception => e
                        puts "Error in ClassName: AnalyticsDataReducer MethodName: reducer_recovery while iterating ErrInfo:#{e.to_s}" 
                        select_records = "false"
                        acquire_lock(@dbconn_select,RELEASE_LOCK,REPORTS_RECOVERY)
                    end # end of begin
                        @dbconn_select.disconnect if @dbconn_select != nil
                end # end of tblname in table_detail
        rescue Exception => e
            @dbconn_transaction_hours.disconnect if @dbconn_transaction_hours != nil
            puts "Error in ClassName: AnalyticsDataReducer MethodName: reducer_recovery ErrInfo:#{e.to_s}" 
            #acquire_lock(@dbconn_select,RELEASE_LOCK,REPORTS_RECOVERY)
        end # end of begin
        end # end of reducer_recovery method
    end # end of AnalyticsDataReducer class
  
  #------------------------------------------------------------------------------------
  #Class Name: Updates
  #Purpose: The purpose of the class is to extend theAnalyticsDataReducer class and create and run two threads
  #Version: 1.0
  #Author: Ayshwarya
  #Last-Modified: 30-04-2009
  #-------------------------------------------------------------------------------------
  class Updates < AnalyticsDataReducer
    def send_mail(subject,content)
      begin
        results = ""
        obj=Hash.new
        # Giving the recepient email addresses  
        obj["to"]=["barakath@mobile-worx.com","shujaudeen@mobile-worx.com","yasmine@mobile-worx.com"]
        if (content != []) #or (content != "")
          obj["subject"] = subject
          for array_records in content
            results += "#{array_records} "  
          end
        end  
        mail=SendMail.new(obj)
        mailBody = ""
        mailBody += "<table width='100%' style='border: 1px solid #CCCCCC;border-collapse: collapse;' cellpadding='5px'>"
        mailBody += "<tr>" 
        mailBody += "<td width='5%' align='left' valign='top' style='border: 1px solid #CCCCCC; font-family: 'Tahoma'; font-size: 8pt; background-color: #FFFFFF; font-weight: bold;'>#{results}</td>"  # Appending the records inside the body of mail
        mailBody += "</tr>"
        mailBody += "</table>"
        mail.body="#{mailBody}"
        mail.send # Sending the mail
      rescue Exception => e
        puts "Error in ComponentName: AnalyticsDataReducer MethodName: send_mail ErrInfo:#{e.to_s}" 
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
        #open the master config file and check the mail option.
        check_mail_option = MailerSettings::SENDMAIL
        if call_from == "reducer"
          if (@@error_selection_reducer != [] and (check_mail_option == "error" or check_mail_option== "all"))
            subject = "Error in REDUCER in reducer method whilie selecting."
            send_mail(subject,@@error_selection_reducer)
          end    
          if (@@error_selection_reducer != [] and (check_mail_option== "error" or check_mail_option== "all")) 
            subject = "Error in REDUCER in reducer method whilie inserting."
            send_mail(subject,@@error_selection_reducer)
          end  
          if(@@error_updation_reducer != [] and (check_mail_option== "error" or check_mail_option== "all"))
            subject = "Error in REDUCER in reducer method whilie updating."
            send_mail(subject,@@error_updation_reducer)
          end  
          if(@@reducer_array != [] and check_mail_option.to_s == "all")
            subject = "Status of reducer Summarizer Component."
            #Fetch the  updated records ip address, database name, table name, start datetime, end datetime and status from @@reducer_array.
            send_mail(subject,@@reducer_array)
          end # end of ($records_array != [])
          @@reducer_array = [] # Reset the @@reducer_array to fetch next set of records
          @@error_selection_reducer = []
          @@error_selection_reducer = []
          @@error_updation_reducer = [] 
        elsif call_from == "reducer_recovery"  
          if (@@error_selection_reducer_recovery != [] and (check_mail_option == "error" or check_mail_option == "all"))
             subject = "Error in REDUCER in report_recovery method whilie selecting."
             send_mail(subject,@@error_selection_reducer_recovery)
          end
          if (@@error_selection_reducer_recovery != [] and (check_mail_option == "error" or check_mail_option == "all"))
            subject = "Error in REDUCER in report_recovery method whilie inserting."
            send_mail(subject,@@error_selection_reducer_recovery)
          end
          if(@@error_updation_reducer_recovery != [] and (check_mail_option == "error" or check_mail_option == "all"))
            subject = "Error in REDUCER in report_recovery method whilie updating."
            send_mail(subject,@@error_updation_reducer_recovery)
          end
          if (@@reducer_recovery_array != [] and check_mail_option.to_s == "all")
            #Fetch the  updated records ip address, database name, table name, start datetime, end datetime and status from @@reducer_recovery_array
            subject = "Recovered records in reducer Summarizer Component"
            send_mail(subject,@@reducer_recovery_array)
          end # end of ($records_recovery_array != [])
          @@reducer_recovery_array = [] # Reset the @@reducer_recovery_array to fetch next set of records
          @@error_selection_reducer_recovery = []
          @@error_selection_reducer_recovery = []
          @@error_updation_reducer_recovery = []
        end # end of call_from == "reducer"  
      rescue Exception => e
        puts "Error in ComponentName: AnalyticsDataReducer MethodName: chk_send_mail ErrInfo:#{e.to_s}" 
      end   
    end  # end of method chk_send_mail
    
    #-------------------------------------------------------------------------------------
    #Method Name: cronjob
    #Purpose: This action is to run the server continously. Call the reducer method for every one hour and reducer_recovery method for every 30 minutes
    #Version: 1.0
    #Author: Md Shujauddeen
    #Last-Modified: 30-04-2009
    #--------------------------------------------------------------------------------------
    def cronjob
      begin
        puts "REDUCER has been started..."
        begin # this begin is for while loop.
          begin  #this begin is used for rescue inside the loop.
          #For the first time, it calls the reducer method. After that it will be in sleep state for 1 hour. Again it will call the reducer mehtod. This is going to be a continous process
          curr_hour= Time.now.strftime("%H").to_i
          if curr_hour>=4
              obj_reducer = AnalyticsDataReducer.new 
              obj_reducer.reducer
              obj_reducer = nil
              chk_send_mail("reducer")
              curr_min= Time.now.strftime("%M").to_i
              sleep_min=  (60-curr_min)
              sleep_min=sleep_min.to_i
              curr_hr = Time.now.strftime("%H").to_i
              sleep_hr=3-(curr_hr%4)
              sleep((sleep_min*60)+(3600*sleep_hr)) #Set the sleep state for 4 hour
              
              #call the reducer recovery method..
              obj_reducer_update = AnalyticsDataReducer.new  #Create an object for the AnalyticsDataReducer class 
              obj_reducer_update.reducer_recovery # Call the reducer_recovery method with the object
              chk_send_mail("reducer_recovery") 
              obj_reducer_update = nil #Set the object as nil
          else
              sleep(600)
          end
          rescue Exception => e
            puts "Error in ComponentName: AnalyticsDataReducer MethodName: cronjob while iterating ErrInfo:#{e.to_s}" 
          end  
        end while(true)        
      rescue Exception => e
        puts "Error in ComponentName: AnalyticsDataReducer MethodName: cronjob ErrInfo:#{e.to_s}" 
      end 
    end # end of cronjob method
  end # end of Updates class
#Creating the object and call the updation method first
obj = Updates.new()
obj.cronjob
