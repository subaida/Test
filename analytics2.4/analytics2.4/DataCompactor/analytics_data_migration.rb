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
# *     of United States of America & Republic of India
# *
# *
# * Contact us at 
# * info@mobile-worx.com
# *
# * Notes
# * Version: 1.0
# * Note: This class read the shard database adsdeliveries table and do the transaction in Advertiser and publisher.It will read the master db
# *           and update the vlaues in shard database.
# * Modified Date : 6/Jul/09
# * Modified Note :  Required  the setting.rb file and used the username and password module.

require 'dbi'
require 'rubygems' 
require 'yaml'
require 'time'
require 'email_component.rb'
require 'mysql'
require 'settings.rb'
#setting the path to load the config files.
PATH= PathSettings::DB_TEMP_FILE
PATH_MASTER= PathSettings::DB_MASTER_FILE

#------------------------------------------------------------------------------------
#class Name: AnalyticsDataMigration
#Purpose: The purpose of this class is to select the datas from master database, and insert the values into master database and shard database and vice versa.
#Version: 1.0
#Author: S.Sathihskumar
#Last-Modified: 23-03-2009
#-------------------------------------------------------------------------------------
class AnalyticsDataMigration
    #initialize global variable for creating seperate thread in the cron job.
    #------------------------------------------------------------------------------------
    #Method Name: initilaize
    #Purpose: This action is to call the re_initialize method for initializing the values to global variables.
    #Version: 1.0
    #Author: S.Sathish kumar  
    #Last-Modified: 23-03-2009
    #-------------------------------------------------------------------------------------
    @@getsymbol={"&"=>"\\&","%"=>"\\%","'"=>"\\'",","=>""}
    def initialize(*args)
      begin
        #puts "analytics data migration initialize method"
        #call the re_initialize method for initializing the values to global variables.
        if args[0] == nil
          re_initialize 
        elsif args[0] == "parallel"  
          re_initialize(args[0])  
        else
          puts "Command not match in report summarizer and initialize method."          
        end
      rescue Exception => e
        puts "Error in ClassName:AnalyticsDataMigration MethodName:initialize ErrInfo:#{e.to_s} " 
      end      
    end
    #------------------------------------------------------------------------------------
    #Method Name: wirteShardDB
    #Purpose: This action is to select the values form master database and update the values into shard database. 
    #Version: 1.0
    #Author: Ayshwarya
    #Last-Modified: 23-03-2009
    #-------------------------------------------------------------------------------------
    def writeAnalyticsDB
     begin
        #require the mysql for inserting values in advertiseraccounts.
        #puts "WIRTE SHARD DB"
        @selection_adClients_array = []
        @selection_ads_array = []
        @selection_campaign_array = []
        @selection_publishers_array = []
        @selection_advertiser_array = []
        @selection_user_array = []
        @adClient_results_array = []
        @ads_results_array = []
        @campaigns_results_array = []
        @publishers_results_array = []
        @advertiser_results_array = []
        @user_results_array = []
        #global variable for send mail.
        $error_wirteAnalyticsDB = []
        $chk_error_wirteAnalyticsDB = []
        $update_success_write = []
        $success_write_records = [] 
        #Establish a connection to the master database
        @dbconn_select_masterDb = DBI.connect("DBI:MYSQL:#{$master_db}:#{$master_ip}", WriteDBServer::USERNAME, WriteDBServer::PASSWORD)
        #Select the campaigns table from master database based on certain condition
        select_campaign_query = "select SQL_NO_CACHE id,campaign_name,status,channels,country,carriers,cost_metrics,device_models,bid_range_avg from campaigns where status= 'Approved'"
        #Select the ads table from master database based on certain condition
        select_ads_query = "select SQL_NO_CACHE * from ads where status='Approved'"
        #Select the adclients table from master database based on certain condition
        select_adClients_query = "select SQL_NO_CACHE id as adclient_id,app_name, channel, status,ads_approval_type,cid from adclients"
        select_publishers_query = "select SQL_NO_CACHE id,publisher_name,status from publishers"
        select_advertiser_query = "select SQL_NO_CACHE id,name,status from advertisers"
        select_user_query="select SQL_NO_CACHE id,username,access_on_analytics,password,email,status from users"
        selection_campaign = @dbconn_select_masterDb.select_all(select_campaign_query)
        selection_ads = @dbconn_select_masterDb.select_all(select_ads_query)
        selection_adClients = @dbconn_select_masterDb.select_all(select_adClients_query)
        selection_publishers = @dbconn_select_masterDb.select_all(select_publishers_query)
        selection_advertiser = @dbconn_select_masterDb.select_all(select_advertiser_query)
        selection_user = @dbconn_select_masterDb.select_all(select_user_query)
        # Store the selected rows from adclents table inside array
        for row in selection_adClients
          row.map!{|r| r.nil? ? '' :r} # If any collumn contains nil value, then reassign the value as " "
          @selection_adClients_array << row
        end # end of row in selection_adClients
         # Store the selected rows from ads table inside array
        for row in selection_ads
          row.map!{|r| r.nil? ? '' :r} # If any collumn contains nil value, then reassign the value as " "
          @selection_ads_array << row
        end # end of row in selection_ads
        for row in selection_campaign
          row.map!{|r| r.nil? ? '' :r} # If any collumn contains nil value, then reassign the value as " "
          @selection_campaign_array << row #Store the selected rows from campaigns table inside array
        end # end of row in selection_campaign
        for row in selection_publishers
          row.map!{|r| r.nil? ? '' :r} # If any collumn contains nil value, then reassign the value as " "
          @selection_publishers_array << row
        end # end of row in selection_publishers
        for row in selection_advertiser
          row.map!{|r| r.nil? ? '' :r} # If any collumn contains nil value, then reassign the value as " "
          @selection_advertiser_array << row  # Store the selected rows from advertiser  table inside array.
        end # end of row in selection_adv
        for row in selection_user
          row.map!{|r| r.nil? ? '' :r} # If any collumn contains nil value, then reassign the value as " "
          @selection_user_array << row  # Store the selected rows from users table inside array.
        end # end of row in selection_user
        # Select the maximum id from ads, adclients, advertiser accounts, campaigns, publisher payments and publishers tables resides inside master database.
        select_max_query = "select SQL_NO_CACHE (select max(ad.id) from adclients ad) as max_ad_id,(select max(a.id) from ads a)as max_a_id, (select max(c.id) from campaigns c)as max_camp_id, (select max(pub.id) from publishers pub)as max_pub_id,(select max(advert.id) from advertisers  advert) as max_advertiser,(select max(usr.id) from users usr) as max_user from dual"
        max_query_masterDb = @dbconn_select_masterDb.select_all(select_max_query)
        # Store maximum id of all the tables inside global variable
        max_query_masterDb.each do|row|
          @max_adClient_id_master_db = row['max_ad_id'].to_i
          @max_ads_id_master_db = row['max_a_id'].to_i
          @max_campaign_id_master_db = row['max_camp_id'].to_i
          @max_publishers_id_master_db = row['max_pub_id'].to_i
          @max_advertiser_id_master_db  = row['max_advertiser'].to_i 
          @max_user_id_master_db=row['max_user'].to_i
        end
        #~ puts "MASTER ADCLIENT::#{@max_adClient_id_master_db}"
        #~ puts "MASTER max_ads_id_master_db::#{@max_ads_id_master_db}"
        #~ puts "MASTER max_campaign_id_master_db::#{@max_campaign_id_master_db}"
        #~ puts "MASTER max_adv_acc_id_master_db::#{@max_adv_acc_id_master_db}"
        #~ puts "MASTER max_campaign_bids_master_db::#{@max_campaign_bids_master_db}"
        #~ puts "MASTER max_publishers_id_master_db::#{@max_publishers_id_master_db}"
        @dbconn_select_masterDb.disconnect unless @dbconn_select_masterDb == nil
        @dbconn_select_masterDb = nil
        #Establish a connection to the shard database
        @dbconn_select_max_shardDb = DBI.connect("DBI:MYSQL:#{$analytics_db}:#{$analytics_ip}", WriteDBServer::USERNAME,  WriteDBServer::PASSWORD)
        # Select the maximum id from ads, adclients, advertiser accounts, campaigns, publisher payments and publishers tables resides inside shard database
        select_max_query = "select SQL_NO_CACHE (select max(ad.id) from adclients ad) as max_ad_id,(select max(a.id) from ads a)as max_a_id, (select max(c.id) from campaigns c)as max_camp_id, (select max(pub.id) from publishers pub)as max_pub_id, (select max(advert.id) from advertisers  advert) as max_advertiser,(select max(usr.id) from users usr) as max_user from dual"
        max_query_shardDb = @dbconn_select_max_shardDb.select_all(select_max_query)
        @dbconn_select_max_shardDb.disconnect unless @dbconn_select_masterDb == nil 
        @dbconn_select_masterDb = nil
        # Store maximum id of all the tables inside global variable
        max_query_shardDb.each do|row|
          @max_adClient_id_shard_db = row['max_ad_id'].to_i
          @max_ads_id_shard_db = row['max_a_id'].to_i
          @max_campaign_id_shard_db = row['max_camp_id'].to_i
          @max_publishers_id_shard_db =  row['max_pub_id'].to_i
          @max_advertiser_id_shard_db  = row['max_advertiser'].to_i 
          @max_user_id_shard_db  = row['max_user'].to_i 
        end
        #~ puts "SHARD ADCLIENT::#{@max_adClient_id_shard_db}"
        #~ puts "SHARD max_ads_id_shard_db::#{@max_ads_id_shard_db}"
        #~ puts "SHARD max_campaign_id_shard_db::#{@max_campaign_id_shard_db}"
        #~ puts "SHARD max_adv_acc_id_shard_db::#{@max_adv_acc_id_shard_db}"
        #~ puts "SHARD max_campaign_bids_shard_db::#{@max_campaign_bids_shard_db}"
        #~ puts "SHARD max_publishers_id_shard_db::#{@max_publishers_id_shard_db}"
        #Establish a connection to the master database
        @dbconn_masterDb = DBI.connect("DBI:MYSQL:#{$master_db}:#{$master_ip}", WriteDBServer::USERNAME, WriteDBServer::PASSWORD)
        #Select all the collumns from  ads, adclients, advertiser accounts, campaigns, publisher payments and publishers tables resides inside master database based on certain condition
        if(@max_adClient_id_master_db > @max_adClient_id_shard_db)
          select_query_adClient = "select SQL_NO_CACHE * from adclients where id > '#{@max_adClient_id_shard_db}'"
          adClient_results = @dbconn_masterDb.select_all(select_query_adClient)
          for row in adClient_results
            row.map!{|r| r.nil? ? '' :r} # If any collumn contains nil value, then reassign the value as " "
            @adClient_results_array << row # Store the selected rows from adclient table inside array
          end # end of row in adClient_results
        end # end of (@max_adClient_id_master_db > @max_adClient_id_shard_db)
        if(@max_ads_id_master_db > @max_ads_id_shard_db) # If table values inside master database is greater than values in shard database table     
          select_query_ads = "select SQL_NO_CACHE * from ads where id > '#{@max_ads_id_shard_db}'"
          ads_results =  @dbconn_masterDb.select_all(select_query_ads)
          for row in ads_results
            row.map!{|r| r.nil? ? '' :r} # If any collumn contains nil value, then reassign the value as " "
            @ads_results_array << row # Store the selected rows from ads table inside array
          end # end of row in ads_results
        end # end of (@max_ads_id_master_db > @max_ads_id_shard_db)
        if(@max_campaign_id_master_db > @max_campaign_id_shard_db) # If table inside master database is greater than table in shard database
          select_query_campaigns = "select SQL_NO_CACHE * from campaigns where id > '#{@max_campaign_id_shard_db}'"
          campaigns_results = @dbconn_masterDb.select_all(select_query_campaigns)
          for row in campaigns_results
            row.map!{|r| r.nil? ? '' :r} # If any collumn contains nil value, then reassign the value as " "
            @campaigns_results_array << row # Store the selected rows from campaigns table inside array
          end # end of row in campaigns_results
        end # end of (@max_campaign_id_master_db > @max_campaign_id_shard_db)
         if(@max_publishers_id_master_db > @max_publishers_id_shard_db)  # If table inside master database is greater than table in shard database
          select_query_pub = "select SQL_NO_CACHE * from publishers where id > '#{@max_publishers_id_shard_db}'"
          publishers_results = @dbconn_masterDb.select_all(select_query_pub)
          for row in publishers_results
            row.map!{|r| r.nil? ? '' :r} # If any collumn contains nil value, then reassign the value as " "
            @publishers_results_array << row # Store the selected rows from publishers table inside array
          end # end of row in publishers_results
        end # end of (@max_publishers_id_master_db > @max_publishers_id_shard_db)
         # this code is used for adverisers inserts.
         if(@max_advertiser_id_master_db > @max_advertiser_id_shard_db)  # If table inside master database is greater than table in shard database
          select_query_advertiser = "select SQL_NO_CACHE * from advertisers where id > '#{@max_advertiser_id_shard_db}'"
          advertiser_results = @dbconn_masterDb.select_all(select_query_advertiser)
          for row in advertiser_results 
            row.map!{|r| r.nil? ? '' : r} # If any collumn contains nil value, then reassign the value as " "
            @advertiser_results_array << row # Store the selected rows from advertiser table inside array
          end # end of row in publishers_results
        end # end of (@max_advertiser_id_master_db > @max_advertiser_id_shard_db) 
         # this code is used for adverisers inserts.
         if(@max_user_id_master_db > @max_user_id_shard_db)  # If table inside master database is greater than table in shard database
          select_query_user = "select SQL_NO_CACHE id,role_id,username,password,access_on_analytics,password,retype_password,first_name,email,alternate_email,status,country_code,phone,country,company,agree,sms_access,email_alerts,last_name,show_bid,allow_admin_email from users where id > '#{@max_user_id_shard_db}'"
          user_results = @dbconn_masterDb.select_all(select_query_user)
          for row in user_results 
            row.map!{|r| r.nil? ? '' : r } # If any collumn contains nil value, then reassign the value as " "
            #puts "INTERMI for loop"
            @user_results_array << row # Store the selected rows from user table inside array
          end # end of row in user_result
        end # end of (@max_user_id_master_db > @max_user_id_shard_db) 
        @dbconn_masterDb.disconnect  unless @dbconn_masterDb == nil
        @dbconn_masterDb = nil
            begin
            #Establish a connection to the shard database
            @dbconn_insert_update = DBI.connect("DBI:MYSQL:#{$analytics_db}:#{$analytics_ip}", AnalyticsDBServer::USERNAME,  AnalyticsDBServer::PASSWORD)
            @mysql_db = Mysql.real_connect("#{$analytics_ip}", AnalyticsDBServer::USERNAME,  AnalyticsDBServer::PASSWORD, "#{$analytics_db}")
            #puts "Before update adclients "
            chk_adclient = []
            chk_adclient[0] = "true"
            if (@max_adClient_id_master_db == @max_adClient_id_shard_db) # Check if maximum id of adclients table for both master and shard database are equal
              for row in @selection_adClients_array # If it is equal, do the updations for the old records
                row.map!{|r| r.nil? ? ' ' :r} # If any collumn contains nil value, then reassign the value as " "
                begin
                  app_name = @mysql_db.escape_string("#{row['app_name']}")
                  update_query = "update adclients set app_name = '#{app_name}' , channel = \"#{row['channel'].to_s}\", status = '#{row['status'].to_s}' , ads_approval_type = '#{row['ads_approval_type'].to_s}', cid = '#{row['cid']}' where id = #{row['adclient_id'].to_i}"
                  update_adClients = @dbconn_insert_update.prepare(update_query)
                  update_adClients.execute
                rescue Exception => e
                  puts "Error in ClassName:AnalyticsDataMigration MethodName:writeAnalyticsDB whilie update adclients ErrInfo:#{e.to_s} " 
                  chk_adclient[0] = "false"
                  chk_adclient[1] = e.to_s
                end
              end # end of row in @selection_adClients_array
            elsif @max_adClient_id_master_db > @max_adClient_id_shard_db # Check if maximum id of adclients table for both master and shard database are not equal
              for row in @adClient_results_array  # If table inside master database is greater than table in shard database, then insert the new records into shard database adclients table
                row.map!{|r| r.nil? ? '' :r} # If any collumn contains nil value, then reassign the value as " "
                begin
                  insert_query = "insert into adclients values(#{row['id'].to_i}, \"#{row['app_name'].to_s}\", #{row['publisher_id'].to_i}, '#{row['client_type'].to_s}', '#{row['ad_type'].to_s}', '#{row['screen_size'].to_s}', '#{row['status_reason'].to_s}', \"#{row['path'].to_s}\", \"#{row['meta_information'].to_s}\", \"#{row['channel'].to_s}\", '#{row['ads_approval_type'].to_s}', '#{row['status'].to_s}', \"#{row['description'].to_s}\",'#{row['outside_ads']}',\"#{row['cid']}\")"
                  insert = @dbconn_insert_update.prepare(insert_query)
                  insert.execute
                rescue Exception => e
                  puts "Error in ClassName:AnalyticsDataMigration MethodName:writeAnalyticsDB whilie insert adclients ErrInfo:#{e.to_s} " 
		  puts insert_query
                  chk_adclient[0] = "false"
                  chk_adclient[1] = e.to_s
                end
              end # end of row in @adClient_results_array
              # After inserting new values into shard database, do the updation for the old records
              for row in @selection_adClients_array
                row.map!{|r| r.nil? ? '' :r} # If any collumn contains nil value, then reassign the value as " ".
                  begin                
                    app_name = @mysql_db.escape_string("#{row['app_name']}")
                    update_query = "update adclients set app_name = '#{app_name}' , channel = \"#{row['channel'].to_s}\", status = '#{row['status'].to_s}' , ads_approval_type = '#{row['ads_approval_type'].to_s}', cid = '#{row['cid']}' where id = #{row['adclient_id'].to_i}"
                    update_adClients = @dbconn_insert_update.prepare(update_query)
                    update_adClients.execute
                  rescue Exception => e
                    puts "Error in ClassName:AnalyticsDataMigration MethodName:writeAnalyticsDB whilie update adclients ErrInfo:#{e.to_s} " 
                    chk_adclient[0] = "false"
                    chk_adclient[1] = e.to_s
                  end
              end # end of row in @selection_adClients_array
            end # end of (@max_adClient_id_master_db == @max_adClient_id_shard_db)
            if chk_adclient[0] == "true"
              $success_write_records << "<p style='color:#0000FF'>Project: ANALYTICS_SHARDING...<br />Job: analytics_data_migration<br />Ip address is:#{$analytics_ip}<br />Database: #{$analytics_db}<br />Table: Adclients <br />Processed Time: #{Time.now.strftime('%Y-%m-%d %H:%M:%S')} <br /></p>" 
            elsif chk_adclient[0] == "false"
              $chk_error_wirteAnalyticsDB <<  "<p style='color:#FF0000'>ERROR :: ANALYTICS_SHARDING...<br />Job: analytics_data_migration<br />Ip address is:#{$analytics_ip}<br />Database: #{$analytics_db}<br />Table: Adclients <br />Failure_Time:#{Time.now.strftime('%Y-%m-%d %H:%M:%S')} <br />Exception is : #{chk_adclient[1]}</p>"    
            end         
            #~ puts "After update adclients "
            #~ puts "Before updte ads::"
            #~ puts "#{@ads_results_array.inspect}"
            chk_ads = []
            chk_ads[0] = "true"
            if(@max_ads_id_master_db == @max_ads_id_shard_db) # Check if maximum id of ads table for both master and shard database are equal
              for row in @selection_ads_array  # If it is equal, do the updations for the old records
                if row['approved_on'] == '' or row['approved_on'] == nil or row['approved_on'] == ' ' or row['approved_on'].to_s == "NULL" # If collumn value is of date datatype, if that contains no records, update value as NULL
                   approved_loc = 'NULL'
                else
                   approved_loc= "'#{row['approved_on']}'" # Else return the value
                  #row.map!{|r| r.nil? ? '' :r}
                end # end of if statement
                  begin 
                      update_query = "update ads set advertiser_id = #{row['advertiser_id'].to_i}, campaign_id = #{row['campaign_id'].to_i}, name = \"#{row['name'].to_s}\", ad_type = '#{row['ad_type'].to_s}', ad_text = \"#{row['ad_text'].to_s}\", ad_small = '#{row['ad_small'].to_s}', ad_medium = '#{row['ad_medium'].to_s}', ad_large = '#{row['ad_large'].to_s}', ad_xlarge = '#{row['ad_xlarge'].to_s}', status = '#{row['status'].to_s}', microsite_id = #{row['microsite_id'].to_i}, forbidden_adclients = '#{row['forbidden_adclients'].to_s}', adclient_campaigns = '#{row['adclient_campaigns'].to_s}', redirect_type = \"#{row['redirect_type'].to_s}\",  ad_picture = '#{row['ad_picture'].to_s}', approved_on = #{approved_loc},rich_ad_type='#{row['rich_ad_type']}'  where id= #{row['id'].to_i}"
                      update_ads = @dbconn_insert_update.prepare(update_query)
                      update_ads.execute
                  rescue Exception => e
                    puts "Error in ClassName:AnalyticsDataMigration MethodName:writeAnalyticsDB whilie update ads ErrInfo:#{e.to_s} " 
                    chk_ads[0] = "false"
                    chk_ads[1] = e.to_s
                  end
              end # end of row in @selection_ads_array
            elsif(@max_ads_id_master_db > @max_ads_id_shard_db) # If table inside master database is greater than table in shard database, then insert the new records into shard database ads table
              for row in @ads_results_array 
                if row['approved_on'] == '' or row['approved_on'] == nil or row['approved_on'] == ' ' or row['approved_on'].to_s == "NULL" # If collumn value is of date datatype, if that contains no records, update value as NULL
                  approved_loc = 'NULL'
                else
                  approved_loc=  "'#{row['approved_on']}'"  # Else return the value
                  #row.map!{|r| r.nil? ? '' :r}
                end # end of if statement
                row.map!{|r| r.nil? ? '' :r}  # If any collumn contains nil value, then reassign the value as " "
                begin
                  insert_query = "insert into ads values(#{row['id'].to_i}, #{row['advertiser_id'].to_i}, #{row['campaign_id'].to_i}, \"#{row['name'].to_s}\", '#{row['ad_type'].to_s}', \"#{row['ad_text'].to_s}\", '#{row['ad_small'].to_s}', '#{row['ad_medium'].to_s}', '#{row['ad_large'].to_s}', '#{row['ad_xlarge'].to_s}', '#{row['status'].to_s}', #{row['microsite_id'].to_i}, '#{row['forbidden_adclients'].to_s}', '#{row['adclient_campaigns'].to_s}', \"#{row['redirect_type'].to_s}\", '#{row['ad_picture'].to_s}', #{approved_loc},'#{row['domain']}','#{row['rich_ad_type']}','#{row['rich_ad_medium']}' )"
                  insert = @dbconn_insert_update.prepare(insert_query)
                  insert.execute
                rescue Exception => e
                 puts "Error in ClassName:AnalyticsDataMigration MethodName:writeAnalyticsDB whilie insert ads ErrInfo:#{e.to_s} " 
                 chk_ads[0] = "false"
                 chk_ads[1] = e.to_s
                end
              end # end of row in @ads_results_array 
              # After inserting new values into shard database, do the updation for the old records
              for row in @selection_ads_array
                if row['approved_on'] == '' or row['approved_on'] == nil or row['approved_on'] == ' ' or row['approved_on'].to_s == "NULL"  # If collumn value is of date datatype, if that contains no records, update value as NULL
                  approved_loc = 'NULL'
                else
                  approved_loc =  "'#{row['approved_on']}'"  # Else return the value
                  #row.map!{|r| r.nil? ? '' :r}
                end # end of if statement
                begin
                  update_query = "update ads set advertiser_id = #{row['advertiser_id'].to_i}, campaign_id = #{row['campaign_id'].to_i}, name = \"#{row['name'].to_s}\", ad_type = '#{row['ad_type'].to_s}', ad_text = \"#{row['ad_text'].to_s}\", ad_small = '#{row['ad_small'].to_s}', ad_medium = '#{row['ad_medium'].to_s}', ad_large = '#{row['ad_large'].to_s}', ad_xlarge = '#{row['ad_xlarge'].to_s}', status = '#{row['status'].to_s}', microsite_id = #{row['microsite_id'].to_i}, forbidden_adclients = '#{row['forbidden_adclients'].to_s}', adclient_campaigns = '#{row['adclient_campaigns'].to_s}', redirect_type = \"#{row['redirect_type'].to_s}\",  ad_picture = '#{row['ad_picture'].to_s}', approved_on = #{approved_loc},rich_ad_type='#{row['rich_ad_type']}'  where id= #{row['id'].to_i}"
                  update_ads = @dbconn_insert_update.prepare(update_query)
                  update_ads.execute
                rescue Exception => e
                  puts "Error in ClassName:AnalyticsDataMigration MethodName:writeAnalyticsDB whilie update ads ErrInfo:#{e.to_s} " 
                  chk_ads[0] = "false"
                  chk_ads[1] = e.to_s
                end  
              end # end of row in @selection_ads_array
            end # end of (@max_ads_id_master_db == @max_ads_id_shard_db)
              #puts "4"
            if chk_ads[0] == "true"
              $success_write_records << "<p style='color:#0000FF'>Project: ANALYTICS_SHARDING...<br />Job: analytics_data_migration<br />Ip address is:#{$analytics_ip}<br />Database: #{$analytics_db}<br />Table: Ads <br />Processed Time: #{Time.now.strftime('%Y-%m-%d %H:%M:%S')} <br /></p>" 
            elsif chk_ads[0] == "false"
              $chk_error_wirteAnalyticsDB <<  "<p style='color:#FF0000'>ERROR :: ANALYTICS_SHARDING...<br />Job: analytics_data_migration<br />Ip address is:#{$analytics_ip}<br />Database: #{$analytics_db}<br />Table: Ads <br />Failure_Time:#{Time.now.strftime('%Y-%m-%d %H:%M:%S')} <br />Exception is : #{chk_ads[1]}</p>"    
            end    
             #~ puts "After update ads" 
             #~ puts "Before update campaigns"
            chk_campaign = []
            chk_campaign[0] = "true"
            if(@max_campaign_id_master_db == @max_campaign_id_shard_db) # Check if maximum id of campaigns table for both master and shard database are equal
              for row in @selection_campaign_array # If it is equal, do the updations for the old records
                row.map!{|r| r.nil? ? '' :r}  # If any collumn contains nil value, then reassign the value as " "
                begin
                  campaign_name = @mysql_db.escape_string("#{row['campaign_name']}") 
                  update_query = "update campaigns set campaign_name = '#{campaign_name}', status = '#{row['status']}',channels = '#{row['channels']}',country = \"#{row['country']}\",carriers = \"#{row['carriers']}\",cost_metrics = '#{row['cost_metrics']}',bid_range_avg=#{row['bid_range_avg'].to_f},device_models =\"#{(row['device_models']!=nil && row['device_models']!='') ? row['device_models'].to_s.gsub(/([&%,'])/) do|s| @@getsymbol["#{s}"] end : row['device_models']}\" where id = #{row['id']}"
                  update_campaigns =@dbconn_insert_update.prepare(update_query)
                  update_campaigns.execute
                rescue Exception => e
                  puts "Error in ClassName:AnalyticsDataMigration MethodName:writeAnalyticsDB whilie update campaigns ErrInfo:#{e.to_s} " 
                  chk_campaign[0] = "false"
                  chk_campaign[1] = e.to_s
                end  
              end # end of row in @selection_campaign_array
            elsif(@max_campaign_id_master_db > @max_campaign_id_shard_db) # If table inside master database is greater than table in shard database, then insert the new records into shard database campaigns table
              for row in @campaigns_results_array
                  update_time = 'NULL'
                row.map!{|r| r.nil? ? '' :r} # If any collumn contains nil value, then reassign the value as " "
                begin
                  insert_query = "insert into campaigns values(#{row['id'].to_i}, \"#{row['campaign_name'].to_s}\", '#{row['ad_medium'].to_s}', #{row['advertiser_id'].to_i}, '#{row['starting_on']}', '#{row['ending_on']}', #{row['max_budget'].to_f}, #{row['budget_per_day'].to_f}, #{row['amount_spent'].to_f}, '#{row['cost_metrics'].to_s}', '#{row['status'].to_s}', \"#{(row['keywords']!=nil && row['keywords']!='') ? row['keywords'].to_s.gsub(/([&%,'])/) do|s| @@getsymbol["#{s}"] end : row['keywords']}\", #{row['bid_range'].to_f}, #{row['CPC'].to_f}, #{row['bid_range_avg'].to_f}, #{row['CPM'].to_f}, \"#{row['demographics'].to_s}\", \"#{row['sms_location'].to_s}\", \'#{(row['mobile_property']!=nil && row['mobile_property']!='') ? row['mobile_property'].to_s.gsub(/([&%,'])/) do|s| @@getsymbol["#{s}"] end : row['mobile_property']}\', '#{row['forbidden_ad_clients'].to_s}', '#{row['adclient_campaigns'].to_s}', \"#{row['channels'].to_s}\", \'#{(row['country']!=nil && row['country']!='') ? row['country'].to_s.gsub(/([&%,'])/) do|s| @@getsymbol["#{s}"] end : row['country']}\', \'#{(row['carriers']!=nil && row['carriers']!='') ? row['carriers'].to_s.gsub(/([&%,'])/) do|s| @@getsymbol["#{s}"] end : row['carriers']}\', \'#{(row['devices']!=nil && row['devices']!='') ? row['devices'].to_s.gsub(/([&%,'])/) do|s| @@getsymbol["#{s}"] end : row['devices']}\',\'#{(row['device_models']!=nil && row['device_models']!='') ? row['device_models'].to_s.gsub(/([&%,'])/) do|s| @@getsymbol["#{s}"] end : row['device_models']}\', #{row['daily_amount_spent'].to_f}, '#{row['daily_budget_status'].to_s}', #{row['flag'].to_i}, #{update_time}, \"#{row['target'].to_s}\", \"#{row['capabilities'].to_s}\",'#{row['click_validation'].to_i}','#{(row['device_specification']!=nil && row['device_specification']!='') ? row['device_specification'].to_s.gsub(/([&%,'])/) do|s| @@getsymbol["#{s}"] end : row['device_specification']}','#{row['rich_campaign_medium']}')"
                  insert = @dbconn_insert_update.prepare(insert_query)
                  insert.execute
                rescue Exception => e
                  puts "Error in ClassName:AnalyticsDataMigration MethodName:writeAnalyticsDB whilie insert campaigns ErrInfo:#{e.to_s} " 
                  chk_campaign[0] = "false"
                  chk_campaign[1] = e.to_s
                end
              end # end of row in @campaigns_results_array
              # After inserting new values into shard database, do the updation for the old records
              for row in @selection_campaign_array
                begin
                  campaign_name = @mysql_db.escape_string("#{row['campaign_name']}") 
                  update_query = "update campaigns set campaign_name = '#{campaign_name}', status = '#{row['status']}',channels = '#{row['channels']}',country = \"#{row['country']}\",carriers = \"#{row['carriers']}\",cost_metrics = '#{row['cost_metrics']}',device_models =\"#{row['device_models']}\" where id = #{row['id']}"
                  update_campaigns =@dbconn_insert_update.prepare(update_query)
                  update_campaigns.execute
                rescue Exception => e
                  puts "Error in ClassName:AnalyticsDataMigration MethodName:writeAnalyticsDB whilie update campaigns ErrInfo:#{e.to_s} " 
                  chk_campaign[0] = "false"
                  chk_campaign[1] = e.to_s
                end  
              end # end of row in @selection_campaign_array
            end # end of (@max_campaign_id_master_db == @max_campaign_id_shard_db)
              #puts "CAMPAIGN INACTIVE ============="
            if chk_campaign[0] == "true"
              $success_write_records << "<p style='color:#0000FF'>Project: ANALYTICS_SHARDING...<br />Job: analytics_data_migration<br />Ip address is:#{$analytics_ip}<br />Database: #{$analytics_db}<br />Table: Campaigns <br />Processed Time: #{Time.now.strftime('%Y-%m-%d %H:%M:%S')} <br /></p>" 
            elsif chk_campaign[0] == "false"
              $chk_error_wirteAnalyticsDB <<  "<p style='color:#FF0000'>ERROR :: ANALYTICS_SHARDING...<br />Job: analytics_data_migration<br />Ip address is:#{$analytics_ip}<br />Database: #{$analytics_db}<br />Table: Campaigns <br />Failure_Time:#{Time.now.strftime('%Y-%m-%d %H:%M:%S')} <br />Exception is : #{chk_campaign[1]}</p>"    
            end 
              #~ puts "After update campaigns"
            #~ puts "Before update publisher"
            chk_publisher  = []
            chk_publisher[0] = "true"
            if(@max_publishers_id_master_db == @max_publishers_id_shard_db) # Check if maximum id of publishers table for both master and shard database are equal
              for row in @selection_publishers_array # If it is equal, do the updations for the old records
                begin
                  publisher_name = @mysql_db.escape_string("#{row['publisher_name']}")
                  update_query = "update publishers set publisher_name = '#{publisher_name}',status = \"#{row['status']}\" where id = #{row['id']}"
                  update_publishers = @dbconn_insert_update.prepare(update_query)
                  update_publishers.execute
                rescue Exception => e
                  puts "Error in ClassName:AnalyticsDataMigration MethodName:writeAnalyticsDB whilie update publishers ErrInfo:#{e.to_s} " 
                  chk_publisher[0] = "false"
                  chk_publisher[1] = e.to_s
                end   
                #puts "Updtaed publishers"
              end # end of row in @selection_publishers_array
            elsif(@max_publishers_id_master_db > @max_publishers_id_shard_db) # If table inside master database is greater than table in shard database, then insert the new records into shard database publishers table
              for row in @publishers_results_array
                  created_on= 'NULL'
                row.map!{|r| r.nil? ? '' :r} # If any collumn contains nil value, then reassign the value as " "
                begin
                  insert_query = "insert into publishers values(#{row['id'].to_i}, \"#{row['publisher_name'].to_s}\", #{row['user_id']}, \"#{row['payment_type'].to_s}\", #{row['percentage'].to_f}, '#{row['status'].to_s}', #{created_on}, #{row['sms_charge'].to_f}, \"#{row['demographic'].to_s}\", \"#{row['paypal_id'].to_s}\", #{row['agree'].to_i}, \"#{row['account_name'].to_s}\", \"#{row['address'].to_s}\", \"#{row['wire_transfer'].to_s.gsub('"','')}\")"
                  insert = @dbconn_insert_update.prepare(insert_query)
                  insert.execute
                rescue Exception => e
                  puts "Error in ClassName:AnalyticsDataMigration MethodName:writeAnalyticsDB whilie insert publishers ErrInfo:#{e.to_s} " 
                  chk_publisher[0] = "false"
                  chk_publisher[1] = e.to_s
                end
              end # end of row in @publishers_results_array
              # After inserting new values into shard database, do the updation for the old records
              for row in @selection_publishers_array
                begin
                  publisher_name = @mysql_db.escape_string("#{row['publisher_name']}")
                  update_query = "update publishers set publisher_name = '#{publisher_name}',status = \"#{row['status']}\" where id = #{row['id']}"
                  update_publishers = @dbconn_insert_update.prepare(update_query)
                  update_publishers.execute
                rescue Exception => e
                  puts "Error in ClassName:AnalyticsDataMigration MethodName:writeAnalyticsDB whilie update publishers ErrInfo:#{e.to_s} " 
                  chk_publisher[0] = "false"
                  chk_publisher[1] = e.to_s
                end  
              end # end of row in @selection_publishers_array
            end # end of (@max_publishers_id_master_db == @max_publishers_id_shard_db)
            if chk_publisher[0] == "true"
              $success_write_records << "<p style='color:#0000FF'>Project: ANALYTICS_SHARDING...<br />Job: analytics_data_migration<br />Ip address is:#{$analytics_ip}<br />Database: #{$analytics_db}<br />Table: Publishers <br />Processed Time: #{Time.now.strftime('%Y-%m-%d %H:%M:%S')} <br /></p>" 
            elsif chk_publisher[0] == "false"
              $chk_error_wirteAnalyticsDB <<  "<p style='color:#FF0000'>ERROR :: ANALYTICS_SHARDING...<br />Job: analytics_data_migration<br />Ip address is:#{$analytics_ip}<br />Database: #{$analytics_db}<br />Table: Publishers <br />Failure_Time:#{Time.now.strftime('%Y-%m-%d %H:%M:%S')} <br />Exception is : #{chk_publisher[1]}</p>"    
            end
            #this will update the shard database advertiser table.
            chk_advertiser  = []
            chk_advertiser[0] = "true"
            if(@max_advertiser_id_master_db == @max_advertiser_id_shard_db) # Check if maximum id of publishers table for both master and shard database are equal
              #puts "Only update Values"
              for row in @selection_advertiser_array # If it is equal, do the updations for the old records
                begin
                  adv_name = @mysql_db.escape_string("#{row['name']}")
                  update_query = "update advertisers set name = '#{adv_name}',status='#{row['status']}' where id = #{row['id']}"
                  update_advertiser = @dbconn_insert_update.prepare(update_query)
                  update_advertiser.execute
                rescue Exception => e
                  puts "Error in ClassName:AnalyticsDataMigration MethodName:writeAnalyticsDB whilie update advertisers ErrInfo:#{e.to_s}" 
                  chk_advertiser[0] = "false"
                  chk_advertiser[1] = e.to_s
                end   
                #puts "Updtaed publishers"
              end # end of row in @selection_advertiser_array
            elsif(@max_advertiser_id_master_db > @max_advertiser_id_shard_db) # If table inside master database is greater than table in shard database, then insert the new records into shard database publishers table
              for row in @advertiser_results_array
                #puts "While insert"
                  created_on= 'NULL'
                row.map!{|r| r.nil? ? '' :r} # If any collumn contains nil value, then reassign the value as " "
                begin
                  adv_name = @mysql_db.escape_string("#{row['name']}")
                  insert_query = "insert into advertisers values(#{row['id'].to_i}, '#{adv_name}', '#{row['user_id'].to_i}' , '#{row['phone'].to_i}',  '#{row['status'].to_s}', '#{row['agree'].to_i}', #{created_on})"
                  insert = @dbconn_insert_update.prepare(insert_query)
                  insert.execute
                rescue Exception => e
                  puts "Error in ClassName:AnalyticsDataMigration MethodName:writeAnalyticsDB whilie insert advertisers ErrInfo:#{e.to_s} " 
                  chk_advertiser[0] = "false"
                  chk_advertiser[1] = e.to_s
                end
              end # end of row in @publishers_results_array
              # After inserting new values into shard database, do the updation for the old records
              #puts "After insert update Values"
               for row in @selection_advertiser_array # If it is equal, do the updations for the old records
                begin
                  adv_name = @mysql_db.escape_string("#{row['name']}")
                  update_query = "update advertisers set name = '#{adv_name}',status='#{row['status']}' where id = #{row['id']}"
                  update_advertiser = @dbconn_insert_update.prepare(update_query)
                  update_advertiser.execute
                rescue Exception => e
                  puts "Error in ClassName:AnalyticsDataMigration MethodName:writeAnalyticsDB whilie update advertisers ErrInfo:#{e.to_s}" 
                  chk_advertiser[0] = "false"
                  chk_advertiser[1] = e.to_s
                end   
                #puts "Updtaed publishers"
              end # end of row in @selection_advertiser_array
            end # end of @max_advertiser_id_master_db == @max_advertiser_id_shard_db)
            
             if chk_advertiser[0] == "true"
              $success_write_records << "<p style='color:#0000FF'>Project: ANALYTICS_SHARDING...<br />Job: analytics_data_migration<br />Ip address is:#{$analytics_ip}<br />Database: #{$analytics_db}<br />Table: Advertisers <br />Processed Time: #{Time.now.strftime('%Y-%m-%d %H:%M:%S')} <br /></p>" 
            elsif chk_advertiser[0] == "false"
              $chk_error_wirteAnalyticsDB <<  "<p style='color:#FF0000'>ERROR :: ANALYTICS_SHARDING...<br />Job: analytics_data_migration<br />Ip address is:#{$analytics_ip}<br />Database: #{$analytics_db}<br />Table: Advertisers <br />Failure_Time:#{Time.now.strftime('%Y-%m-%d %H:%M:%S')} <br />Exception is : #{chk_advertiser[1]}</p>"    
            end
            #this will update the shard database advertiser table.
            chk_user  = []
            chk_user[0] = "true"
            if(@max_user_id_master_db == @max_user_id_shard_db) # Check if maximum id of publishers table for both master and shard database are equal
              #puts "Only update Values"
              for row in @selection_user_array # If it is equal, do the updations for the old records
                begin
                  user_name = @mysql_db.escape_string("#{row['username']}")
                  update_query = "update users set username = '#{user_name}',access_on_analytics='#{row['access_on_analytics']}',password='#{row['password']}',email='#{row['email']}',status='#{row['status']}'where id = #{row['id']}"
                  update_user = @dbconn_insert_update.prepare(update_query)
                  update_user.execute
                rescue Exception => e
                  puts "Error in ClassName:AnalyticsDataMigration MethodName:writeAnalyticsDB whilie update users ErrInfo:#{e.to_s}" 
                  chk_user[0] = "false"
                  chk_user[1] = e.to_s
                end   
                #puts "Updtaed publishers"
              end # end of row in @selection_advertiser_array
              
            elsif(@max_user_id_master_db > @max_user_id_shard_db) # If table inside master database is greater than table in shard database, then insert the new records into shard database publishers table
              for row in @user_results_array
                #puts "While insert"
                  updated_at= 'NULL'
                  created_at= 'NULL'#(Time.now).strftime("%Y-%m-%d %H:%M:%S")
                  date_of_creation= 'NULL'
                row.map!{|r| r.nil? ? '' :r} # If any collumn contains nil value, then reassign the value as " "
                begin
                  user_name = @mysql_db.escape_string("#{row['username']}")
                  first_name = @mysql_db.escape_string("#{row['first_name']}")
                  last_name = @mysql_db.escape_string("#{row['last_name']}")
                  insert_query = "insert into users values(#{row['id'].to_i},'#{row['role_id'].to_i}','#{user_name}','#{row['access_on_analytics'].to_s}','#{row['password'].to_s}','#{row['retype_password'].to_s}', '#{first_name}','#{row['email'].to_s}','#{row['alternate_email'].to_s}','#{row['status'].to_s}',#{created_at},'#{row['country_code'].to_i}','#{row['phone'].to_s}','#{row['country'].to_s}',#{date_of_creation},'#{row['company'].to_s}',#{updated_at},'#{row['agree'].to_s}','#{row['sms_access'].to_i}','#{row['email_alerts'].to_s}','#{last_name}','NULL','NULL','#{row['show_bid'].to_i}','#{row['allow_admin_email'].to_s}')"
                  insert = @dbconn_insert_update.prepare(insert_query)
                  insert.execute
                rescue Exception => e
                  puts "Error in ClassName:AnalyticsDataMigration MethodName:writeAnalyticsDB whilie insert users ErrInfo:#{e.to_s} " 
                  chk_user[0] = "false"
                  chk_user[1] = e.to_s
                end
              end # end of row in @publishers_results_array
              # After inserting new values into shard database, do the updation for the old records
              #puts "After insert update Values"
               for row in @selection_user_array # If it is equal, do the updations for the old records
                begin
                  user_name = @mysql_db.escape_string("#{row['username']}")
                  update_query = "update users set username = '#{user_name}',access_on_analytics='#{row['access_on_analytics']}',password='#{row['password']}',email='#{row['email']}',status='#{row['status']}'where id = #{row['id']}"
                  update_user = @dbconn_insert_update.prepare(update_query)
                  update_user.execute
                rescue Exception => e
                  puts "Error in ClassName:AnalyticsDataMigration MethodName:writeAnalyticsDB whilie update users ErrInfo:#{e.to_s}" 
                  chk_user[0] = "false"
                  chk_user[1] = e.to_s
                end   
                #puts "Updtaed publishers"
              end # end of row in @selection_advertiser_array
            end # end of @max_advertiser_id_master_db == @max_advertiser_id_shard_db)
            
             if chk_user[0] == "true"
              $success_write_records << "<p style='color:#0000FF'>Project: ANALYTICS_SHARDING...<br />Job: analytics_data_migration<br />Ip address is:#{$analytics_ip}<br />Database: #{$analytics_db}<br />Table: Users <br />Processed Time: #{Time.now.strftime('%Y-%m-%d %H:%M:%S')} <br /></p>" 
            elsif chk_user[0] == "false"
              $chk_error_wirteAnalyticsDB <<  "<p style='color:#FF0000'>ERROR :: ANALYTICS_SHARDING...<br />Job: analytics_data_migration<br />Ip address is:#{$analytics_ip}<br />Database: #{$analytics_db}<br />Table: Users <br />Failure_Time:#{Time.now.strftime('%Y-%m-%d %H:%M:%S')} <br />Exception is : #{chk_user[1]}</p>"    
            end
          rescue Exception => e
            puts "Error in analytics_data_migration class of writeAnalyticsDB method while insert in shard DB:"+e.to_s
          end
          @dbconn_insert_update.disconnect unless @dbconn_insert_update == nil
          @dbconn_insert_update = nil
          @mysql_db.close unless @mysql_db == nil 
          @mysql_db = nil
        $update_success_write << $success_write_records
        $error_wirteAnalyticsDB << $chk_error_wirteAnalyticsDB
      rescue Exception =>e  
        @dbconn_select_masterDb.disconnect if @dbconn_select_masterDb !=nil 
        @dbconn_select_masterDb = nil
        @dbconn_select_max_shardDb.disconnect if @dbconn_select_max_shardDb !=nil 
        @dbconn_select_max_shardDb = nil
        puts "Error in ClassName:AnalyticsDataMigration MethodName:writeAnalyticsDB ErrInfo:#{e.to_s}" 
        $chk_error_wirteAnalyticsDB << "<p style='color:#FF0000'> ERROR :: analytics data migration wirteShardDB method <br />Project: ANALYTICS_SHARDING<br />Job: analytics_data_migration<br />Failure_Time:#{Time.now.strftime('%Y-%m-%d %H:%M:%S')}<br />Exception is : #{e.to_s}</p>"
        $error_wirteAnalyticsDB << $chk_error_wirteAnalyticsDB
        $update_success_write << $success_write_records
      end # end of begin
    end  # end of method  
  #------------------------------------------------------------------------------------
  #class Name: analytics_data_migration
  #method name: re_initialize
  #Purpose: The purpose of this method is to re_initialize the global variables when the time comes from even hour to odd hour and vice versa..
  #Version: 1.0
  #Author: S.Sathish kumar
  #created-on: 06-03-2009
  #Last-Modified:
  #-------------------------------------------------------------------------------------      
  def re_initialize(*args)
    begin
      #puts "analytics data migration Re-Initialize method..."
      config = YAML::load(File.open("#{PATH}"))
      database_name = config[:active_server][:active_database]
      if args[0] == nil
        chk_parallel = " "
      elsif args[0] == "parallel"
        #puts "Campaign Condition pass parallel"
        chk_parallel = args[0]
      else
        puts "Command not match in analytics data migration and re_initialize method."                  
      end   
      if database_name == "single" or chk_parallel == "parallel"
        $master_ip = config[:localhost][:master_ip]
        $master_db = config[:localhost][:master_db]
        $analytics_ip=AnalyticsDBServer::IP
        $analytics_db='zestadz_analytics'
      elsif database_name == "multiple"
        $master_ip = config[:old_localhost][:old_master_ip]
        $master_db = config[:old_localhost][:old_master_db]
        $analytics_ip=AnalyticsDBServer::IP
        $analytics_db='zestadz_analytics'
      else
        puts "Error::analytics data migration re_initialize method Command not matched.."           
      end  
    rescue Exception => e
      puts "Error in ClassName:AnalyticsDataMigration MethodName:re_initialize ErrInfo:#{e.to_s}" 
    end
  end  

    
 end # End of class 
#------------------------------------------------------------------------------------
  #Class Name: MigrateData
  #Purpose: The purpose of the class is to extend the SortingAd class and create and run two threads
  #Version: 1.0
  #Author: Ayshwarya
  #Last-Modified: 23-03-2009
#-------------------------------------------------------------------------------------
class MigrateData < AnalyticsDataMigration
  #------------------------------------------------------------------------------------s
  #Method Name: cronjob
  #Purpose: This action is to run the two threads based time intervals
  #Version: 1.0
  #Author: S.Sathish kumar
  #Last-Modified: 23-03-2009
  #-------------------------------------------------------------------------------------
    def cronjob
      begin
        puts "analytics data migration has been started..."
        begin # this begin is for while loop.
          begin  #this begin is used for rescue inside the loop.
          obj_sorting_update = AnalyticsDataMigration.new  
          obj_sorting_update.writeAnalyticsDB #Call the wirteShardDB method with the object.
          chk_send_mail("writeAnalyticsDB") 
          #puts "Write shard method After call chk_sed mail"
          obj_sorting_update = nil #Set the object as nil
          sleep(3600) #Set the sleep state for an hour
         rescue Exception => e
            puts "Error in ComponentName: AnalyticsDataMigration MethodName: cronjob while iterating ErrInfo:#{e.to_s}" 
          end   
        end while(true)
      rescue Exception => e
        puts "Error in ComponentName: AnalyticsDataMigration MethodName:cronjob ErrInfo:#{e.to_s}" 
      end 
    end # end of  cron job method
    #------------------------------------------------------------------------------------
    #Method Name: chk_send_mail
    #Purpose: This method is used to check the global variables for sending the mail.
    #Version: 1.0
    #Author: S.Sathish kumar
    #Last-Modified: 23-03-2009
    #-------------------------------------------------------------------------------------
    def chk_send_mail(call_from)
      #puts "CAll from---#{call_from}"
      begin
        @check_mail_option = YAML::load(File.open("#{PATH_MASTER}"))
        @check_mail_option[:sendmail]
        if call_from == "writeAnalyticsDB"  
          if ($update_success_write != [[]] and @check_mail_option[:sendmail].to_s == "all")
            #puts "UPDATE WRITE SUCESS MAIL SEND"
            subject = "Status of wirteAnalyticsDB method of analytics_data_migration component."
            send_mail(subject,$update_success_write)
          end  
          if ($error_wirteAnalyticsDB != [[]] and (@check_mail_option[:sendmail].to_s == "error" or @check_mail_option[:sendmail].to_s == "all"))
            #puts "ERROR WRITE READ SUCESS MAIL SEND"
            subject = "Error in writeAnalyticsDB method of analytics_data_migration component."
            send_mail(subject,$error_wirteAnalyticsDB)
          end  
       end # end of call_from == "campaign_tx"
      rescue Exception => e
        puts "Error in ComponentName: AnalyticsDataMigration MethodName:chk_send_mail ErrInfo:#{e.to_s}" 
      end 
    end # end of chk_send_mail
      
    #------------------------------------------------------------------------------------
    #Method Name: send_mail
    #Purpose: This method is used to sendd the mail.
    #Version: 1.0
    #Author: S.Sathish kumar
    #Last-Modified: 23-03-2009
    #-------------------------------------------------------------------------------------
    def send_mail(subject,content)
      begin
        #puts "send mail method"
        results = ""
        obj=Hash.new
        # Giving the recepient email addresses  
        obj["to"]=["s.sathishkumar@mobile-worx.com","jeyan@mobile-worx.com","j.viswanathan@mobile-worx.com","barakath@mobile-worx.com"]
        if (content != [])
          obj["subject"] = subject
          for array_records in content
            results += "#{array_records} "  
          end
        end  
        mail=SendMail.new(obj)
        mailBody = ""
        mailBody += "<table width='100%' style='border: 1px solid #CCCCCC;border-collapse: collapse;' cellpadding='5px'>"
        mailBody += "<tr>" # style='background-color: #B2DCF4; color: #333333;'>"
        mailBody += "<td align='left' valign='top' style='border: 1px solid #CCCCCC; font-family: 'Tahoma'; font-size: 8pt; background-color: #FFFFFF; font-weight: bold;'>#{results}</td>"  # Appending the records inside the body of mail
        mailBody += "</tr>"
        mailBody += "</table>"
        mail.body="#{mailBody}"  # Appending the records inside the body of mail.
        mail.send # Sending the mail.
      rescue Exception => e
        puts "Error in ComponentName: AnalyticsDataMigration MethodName:send_mail ErrInfo:#{e.to_s}" 
      end
    end  
  end # end of class

migrate=MigrateData.new   #Create an object for the MigrateData class 
migrate.cronjob #Call the cronjob method with the object

