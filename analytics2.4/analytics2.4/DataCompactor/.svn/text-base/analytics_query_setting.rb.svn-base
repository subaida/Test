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

class AnalyticsQuerySetting
  
    #------------------------------------------------------------------------------------
    #class Name: AnalyticsQuerySetting
    #method name: selectAnalyticsQuery
    #Purpose: The purpose of this method is to return a query to fecth data from shard db..
    #Version: 1.0
    #Author: Md Shujauddeen
    #created-on: 20-Aug-2009
    #Last-Modified:
    #-------------------------------------------------------------------------------------    
  def selectAnalyticsQuery(*args)
      begin
        tablename=args[0].to_s + args[1].to_s + args[2].to_s
        start_date=args[3].to_s
        end_date=args[4].to_s
        checkQuery=args[5].to_s
        selectQuery1="select SQL_NO_CACHE metrics as metrics, ad_client_type as ad_client_type, sum(impressions) as impressions, sum(clicks) as clicks, sum(cost) as amount_spent,sum(gross_profit) as gross_profit,sum(zestadz_revenue) as zestadz_revenue, device_name as handset,mobile_model as handset_model,count(distinct(ipaddress)) as unique_visitors,advertiser_id as advertiser_id,campaign_id as campaign_id,ad_id as ad_id,continent_code,country_code,hour(delivery_time) as delivery_hour,date(delivery_time) as delivery_date from #{tablename} where ad_client_type='WAP' and delivery_time>='#{start_date}' and delivery_time<='#{end_date}' group by delivery_date, delivery_hour, ad_id,continent_code,country_code,handset order by null"
        selectQuery2="select SQL_NO_CACHE carrier_name as owner,count(carrier_name) as requests,advertiser_id,campaign_id,ad_id,hour(delivery_time) as delivery_hour,date(delivery_time) as delivery_date from #{tablename} where delivery_time>='#{start_date}' and delivery_time<='#{end_date}' and impressions=1 group by delivery_date, delivery_hour, ad_id,owner order by null"
        selectQuery3="select SQL_NO_CACHE user_agent as user_agent,count(user_agent) as requests,device_name as handset,mobile_model as handset_model,advertiser_id,campaign_id,ad_id,hour(delivery_time) as delivery_hour,date(delivery_time) as delivery_date from #{tablename} where delivery_time>='#{start_date}' and delivery_time<='#{end_date}' and impressions=1 group  by delivery_date, delivery_hour, ad_id,handset,handset_model order by null"
        selectQuery4="select SQL_NO_CACHE ad_client_type as ad_client_type,ad_type as ad_type,sum(impressions) as impressions,sum(clicks) as clicks,(count(id)-sum(impressions)-sum(clicks)) as fill_rate,count(distinct(ipaddress)) as requests_unique_visitors,sum(publisher_revenue) as revenue,state as adclient_name,device_name as handset,mobile_model as handset_model,user_agent,publisher_payments_id as pub_id,client_id as client_id,continent_code as continent_code,country_code as country_code,hour(delivery_time) as delivery_hour,date(delivery_time) as delivery_date from #{tablename} where ad_client_type='WAP' and delivery_time>='#{start_date}' and delivery_time<='#{end_date}' group by delivery_date, delivery_hour, client_id,continent_code,country_code,handset order by null"
        selectQuery5="select SQL_NO_CACHE cl.channel as chan,sum(a.impressions) as requests,(count(a.id)-sum(a.impressions)-sum(a.clicks)) as fill_rate,publisher_payments_id as pub_id,a.client_id as client_id, a.ad_client_type as ad_client_type,hour(a.delivery_time) as delivery_hour,date(a.delivery_time) as delivery_date from #{tablename} a ,channel_lists cl where delivery_time>='#{start_date}' and delivery_time<='#{end_date}' and a.channels like concat('%',cl.channel,'%')  group by delivery_date, delivery_hour, client_id,chan order by null"
        selectQuery6="select SQL_NO_CACHE carrier_name as owner,sum(impressions) as requests,(count(id)-sum(impressions)-sum(clicks)) as fill_rate,publisher_payments_id as pub_id,client_id as client_id,ad_client_type as ad_client_type,hour(delivery_time) as delivery_hour,date(delivery_time) as delivery_date from #{tablename} where delivery_time>='#{start_date}' and delivery_time<='#{end_date}' group by delivery_date, delivery_hour, client_id,owner order by null"
        selectQuery7="select SQL_NO_CACHE url as url,sum(impressions) as requests,(count(id)-sum(impressions)-sum(clicks)) as fill_rate,publisher_payments_id as pub_id,client_id as client_id, hour(delivery_time) as delivery_hour,date(delivery_time) as delivery_date from #{tablename} where delivery_time>='#{start_date}' and delivery_time<='#{end_date}' group by delivery_date, delivery_hour, client_id,url order by null"
        getQuery = case checkQuery
                 when "temp_campaigns_summaries" : selectQuery1
                 when "temp_adv_carriers" : selectQuery2
                 when "temp_adv_devicesproperties" : selectQuery3
                 when "temp_adclients_summaries" : selectQuery4
                 when "temp_pub_channels" : selectQuery5
                 when "temp_pub_carriers" : selectQuery6
                 when "temp_pub_urls" : selectQuery7
               end
            return getQuery
      rescue Exception=>e
           puts "Error in ClassName: AnalyticsSummarizer MethodName: selectQuery ErrInfo:#{e.to_s}" 
      end
    end
    
  end

