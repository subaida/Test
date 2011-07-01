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

class ReducerQuerySetting
  
    #------------------------------------------------------------------------------------
    #class Name: AnalyticsQuerySetting
    #method name: selectAnalyticsQuery
    #Purpose: The purpose of this method is to return a query to fecth data from shard db..
    #Version: 1.0
    #Author: Md Shujauddeen
    #created-on: 20-Aug-2009
    #Last-Modified:
    #-------------------------------------------------------------------------------------    
  def selectReducerQuery(*args)
      begin
        start_id=args[0].to_s
        end_id=args[1].to_s
        checkQuery=args[2].to_s
        selectQuery1="select SQL_NO_CACHE metrics, ad_client_type, sum(impressions) impression, sum(clicks) as click, sum(amount_spent) as amt_spent,sum(gross_profit) as grs_profit, sum(zestadz_revenue) as zest_revenue,sum(unique_visitors) as uniq_visitors, advertiser_id, campaign_id, ad_id,delivery_hour, delivery_date from reduce_campaigns_summaries where id>=#{start_id} and id<=#{end_id} group by delivery_date, ad_id order by null"
        selectQuery2="select SQL_NO_CACHE own.operator as operator ,sum(carr.requests) as requests, advertiser_id, campaign_id, ad_id, delivery_hour, delivery_date from reduce_adv_carriers carr, owners own where carr.owner=own.carrier and carr.id>=#{start_id} and carr.id<=#{end_id} group by operator,ad_id order by null"
        selectQuery3="select SQL_NO_CACHE if(wc.name like '%InVideo%','video',wc.name) as properties,sum(ad.requests) as requests, advertiser_id,campaign_id,ad_id,delivery_hour,delivery_date  from reduce_adv_devicesproperties ad, analytics_wurfl_devices wd,  analytics_wurfl_capabilities wc where ad.id>=#{start_id} and ad.id<=#{end_id} and  wd.vendor=ad.handset and wd.model=ad.handset_model  and wc.wurfl_device_id=wd.id  group by properties,ad.ad_id order by null"
        selectQuery4="select SQL_NO_CACHE ad_client_type, ad_type, sum(impressions) as impression, sum(clicks) as click, sum(fill_rate) as fl_rate, sum(requests_unique_visitors) as sum_visitor, sum(revenue) as sum_revenue,pub_id, client_id, delivery_hour, delivery_date from reduce_adclients_summaries where id>=#{start_id} and id<=#{end_id} group by delivery_date,pub_id,client_id order by null"
        selectQuery5="select SQL_NO_CACHE channel, sum(requests) as request,sum(fill_rate) as fl_rate, pub_id, client_id, ad_client_type, delivery_hour, delivery_date from reduce_pub_channels where id>=#{start_id} and id<=#{end_id} group by delivery_date,pub_id,client_id,channel order by null"
        selectQuery6="select SQL_NO_CACHE own.operator as operator ,sum(carr.requests) as requests,sum(fill_rate) as fl_rate, pub_id, client_id, ad_client_type, delivery_hour, delivery_date from reduce_pub_carriers carr, owners own where carr.owner=own.carrier and carr.id>=#{start_id} and carr.id<=#{end_id} group by operator,pub_id,client_id order by null"
        selectQuery7="select SQL_NO_CACHE delivery_date, delivery_hour, pub_id, client_id, url, sum(requests) as request,sum(fill_rate) as fl_rate from reduce_pub_urls where id>=#{start_id} and id<=#{end_id} and (requests > 0 or fill_rate > 0) group by delivery_date, client_id, url order by client_id,request desc"
        selectQuery8="select SQL_NO_CACHE sum(impressions) impression, continent_code ,country_code, advertiser_id, campaign_id, ad_id,delivery_hour, delivery_date from reduce_campaigns_summaries where id>=#{start_id} and id<=#{end_id} group by delivery_date, ad_id,continent_code,country_code order by null"
        selectQuery9="select SQL_NO_CACHE sum(impressions) impression, handset ,handset_model, advertiser_id, campaign_id, ad_id,delivery_hour,delivery_date from reduce_campaigns_summaries where id>=#{start_id} and id<=#{end_id} group by delivery_date, ad_id,handset order by null"
        selectQuery10="select SQL_NO_CACHE ad_client_type, sum(impressions) impression,sum(clicks) as click,sum(fill_rate) as fl_rate,sum(revenue) as sum_revenue, continent_code ,country_code, pub_id, client_id,delivery_hour,delivery_date from reduce_adclients_summaries where id>=#{start_id} and id<=#{end_id} group by delivery_date,pub_id,client_id,continent_code,country_code order by null"
        selectQuery11="select SQL_NO_CACHE ad_client_type,sum(impressions) impression,sum(fill_rate) as fl_rate, handset ,handset_model, pub_id, client_id, delivery_hour,delivery_date from reduce_adclients_summaries where id>=#{start_id} and id<=#{end_id} group by delivery_date,pub_id,client_id,handset order by null"
        selectQuery12="select SQL_NO_CACHE ad_client_type, sum(impressions) impression,sum(fill_rate) as fl_rate, adclient_name,handset,user_agent,pub_id,client_id,country_code,continent_code,delivery_hour,delivery_date from reduce_adclients_summaries where id>=#{start_id} and id<=#{end_id} group by delivery_date, pub_id,client_id,handset,continent_code,country_code order by null"
        getQuery = case checkQuery
             when "reduce_campaigns_summaries" : selectQuery1
             when "reduce_adv_carriers" : selectQuery2
             when "reduce_adv_devicesproperties" : selectQuery3
             when "reduce_adclients_summaries" : selectQuery4
             when "reduce_pub_channels" : selectQuery5
             when "reduce_pub_carriers" : selectQuery6
             when "reduce_pub_urls" : selectQuery7
             when "adv_geolocations" : selectQuery8
             when "adv_handsets" : selectQuery9
             when "pub_geolocations" : selectQuery10
             when "pub_handsets" : selectQuery11
             when "devices_summaries" : selectQuery12
             end
             return getQuery
      rescue Exception=>e
           puts "Error in ClassName: AnalyticsSummarizer MethodName: selectQuery ErrInfo:#{e.to_s}" 
      end
    end
    
  end
