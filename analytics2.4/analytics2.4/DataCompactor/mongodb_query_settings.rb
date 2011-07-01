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
# * Modified Date : 20/Aug/09
# * Modified Note : Required  the setting.rb file and used the username and password module.

class MongodbQuerySetting
  
    #------------------------------------------------------------------------------------
    #class Name: AnalyticsQuerySetting
    #method name: selectAnalyticsQuery
    #Purpose: The purpose of this method is to return a query to fecth data from shard db..
    #Version: 1.0
    #Author: Md Shujauddeen
    #created-on: 20-Aug-2009
    #Last-Modified:
    #-------------------------------------------------------------------------------------    
  def selectMongodbQuery(*args)
      begin
        tablename=args[0].to_s + args[1].to_s + args[2].to_s
        start_date=args[3].to_s
        end_date=args[4].to_s
        checkQuery=args[5].to_s
        selectQuery1="select SQL_NO_CACHE campaign_id,client_id,publisher_payments_id as pub_id,count(id) as fraud_click,delivery_time from #{tablename} where delivery_time>='#{start_date}' and delivery_time<='#{end_date}' and status='FC' group by campaign_id,client_id"
        selectQuery2="select SQL_NO_CACHE client_id,publisher_payments_id as pub_id,country_code,continent_code,count(id) as impressions,delivery_time from #{tablename} where (impressions=0 and clicks=0) and delivery_time>='#{start_date}' and delivery_time<='#{end_date}' group by client_id,continent_code,country_code"
        selectQuery3="select SQL_NO_CACHE publisher_payments_id as pub_id,client_id,count(id) as impressions,delivery_time,status as reason,continent_code,country_code,carrier_name,device_name,mobile_model from #{tablename} where (impressions=0 and clicks=0) and delivery_time>='#{start_date}' and delivery_time<='#{end_date}' group by client_id,reason,continent_code,country_code,carrier_name,device_name,mobile_model"
        selectQuery4="select SQL_NO_CACHE carrier_name,country_code,count(id) as impressions,continent_code,delivery_time from #{tablename} where (impressions=0 and clicks=0) and delivery_time>='#{start_date}' and delivery_time<='#{end_date}' group by carrier_name,country_code,continent_code"
        selectQuery5="select SQL_NO_CACHE campaign_id,client_id,publisher_payments_id as pub_id,sum(impressions) as filled,(count(id)-(sum(impressions)+sum(clicks)))as unfilled,delivery_time from #{tablename} where delivery_time>='#{start_date}' and delivery_time<='#{end_date}' and currency_symbol='Wifi' group by campaign_id,client_id"
        selectQuery6="select SQL_NO_CACHE campaign_id,publisher_payments_id as pub_id,client_id,ipaddress,user_agent,delivery_time,carrier_name,status,country_code,continent_code,currency_symbol from #{tablename} where (impressions=0 and clicks=0) and delivery_time>='#{start_date}' and delivery_time<='#{end_date}' group by client_id,campaign_id,ipaddress,user_agent,carrier_name,country_code,continent_code,status"
        selectQuery7="select advertiser_id,campaign_id,publisher_payments_id as pub_id,client_id,sum(impressions) as impression,sum(clicks) as click,sum(cost) as spent,sum(publisher_revenue) as revenue,delivery_time from #{tablename} where (impressions>0 or clicks>0) and delivery_time>='#{start_date}' and delivery_time<='#{end_date}' group by campaign_id,client_id"
        selectQuery8="select ipaddress,ua,carrier_name,advertiser_id,client_id,sum(clicks) as click,sum(cost) as cost,delivery_time from #{tablename} where clicks>0 and delivery_time>='#{start_date}' and delivery_time<='#{end_date}' group by advertiser_id,client_id"
        selectQuery9="select advertiser_id,campaign_id,city,sum(impressions) as filled,sum(clicks) as click,delivery_time from #{tablename} where country_code='US' and (impressions>0 or clicks>0) and delivery_time>='#{start_date}' and delivery_time<='#{end_date}' group by campaign_id,city"
        selectQuery10="select publisher_payments_id as pub_id,client_id,city,sum(impressions) as filled,(count(id)-sum(impressions)) as unfilled,sum(clicks) as click,delivery_time from #{tablename} where country_code='US' and delivery_time>='#{start_date}' and delivery_time<='#{end_date}' group by client_id,city"
        getQuery = case checkQuery
                 when "fraud_clicks" : selectQuery1
                 when "unfilled_ips" : selectQuery2
                 when "why_no_ads" : selectQuery3
                 when "owner_summaries" : selectQuery4
                 when "wifi_summaries" : selectQuery5
                 when "ip_details" : selectQuery6
                 when "campaigns_breakdown" : selectQuery7
                 when "click_logs" : selectQuery8
                 when "us_geostats" : selectQuery9
                 when "pub_us_geostats" : selectQuery10
               end
            return getQuery
      rescue Exception=>e
           puts "Error in ClassName: MongodbQuerySetting MethodName: selectMongodbQuery ErrInfo:#{e.to_s}" 
      end
    end
    
  end
