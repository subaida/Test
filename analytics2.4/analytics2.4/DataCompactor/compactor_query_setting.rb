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

class CompactorQuerySetting
  
    #------------------------------------------------------------------------------------
    #class Name: AnalyticsQuerySetting
    #method name: selectAnalyticsQuery
    #Purpose: The purpose of this method is to return a query to fecth data from shard db..
    #Version: 1.0
    #Author: Md Shujauddeen
    #created-on: 20-Aug-2009
    #Last-Modified:
    #-------------------------------------------------------------------------------------    
  def selectCompactorQuery(*args)
      begin
        start_id=args[0].to_s
        end_id=args[1].to_s
        checkQuery=args[2].to_s
        selectQuery1="select SQL_NO_CACHE metrics, ad_client_type, sum(impressions) impression, sum(clicks) as click, sum(amount_spent) as amt_spent,sum(gross_profit) as grs_profit, sum(zestadz_revenue) as zest_revenue,handset,handset_model,sum(unique_visitors) as uniq_visitors, advertiser_id, campaign_id, ad_id,continent_code,country_code, delivery_hour, delivery_date from temp_campaigns_summaries where id>=#{start_id} and id<=#{end_id} group by delivery_date, ad_id,continent_code,country_code,handset order by null"
        selectQuery2="select SQL_NO_CACHE owner, sum(requests) as request,advertiser_id,campaign_id,ad_id,delivery_hour, delivery_date from temp_adv_carriers where id>=#{start_id} and id<=#{end_id} group by delivery_date, ad_id,owner order by null"
        selectQuery3="select SQL_NO_CACHE user_agent , sum(requests) as request,handset,handset_model,advertiser_id,campaign_id, ad_id,delivery_hour, delivery_date from temp_adv_devicesproperties where id>=#{start_id} and id<=#{end_id} group by delivery_date, ad_id,handset,handset_model order by null"
        selectQuery4="select SQL_NO_CACHE ad_client_type, ad_type, sum(impressions) as impression, sum(clicks) as click, sum(fill_rate) as fl_rate, sum(requests_unique_visitors) as sum_visitor, sum(revenue) as sum_revenue, adclient_name,handset,handset_model,user_agent,pub_id, client_id, continent_code, country_code, delivery_hour, delivery_date from temp_adclients_summaries where id>=#{start_id} and id<=#{end_id} group by delivery_date, client_id,continent_code,country_code,handset order by null"
        selectQuery5="select SQL_NO_CACHE channel, sum(requests) as request,sum(fill_rate) as fl_rate, pub_id, client_id, ad_client_type, delivery_hour, delivery_date from temp_pub_channels where id>=#{start_id} and id<=#{end_id} group by delivery_date, client_id,channel order by null"
        selectQuery6="select SQL_NO_CACHE owner, sum(requests) as request,sum(fill_rate) as fl_rate, pub_id, client_id, ad_client_type, delivery_hour, delivery_date from temp_pub_carriers where id>=#{start_id} and id<=#{end_id} group by delivery_date, client_id,owner order by null"
        selectQuery7="select SQL_NO_CACHE delivery_date, delivery_hour, pub_id, client_id, url, sum(requests) as request,sum(fill_rate) as fl_rate from temp_pub_urls where id>=#{start_id} and id<=#{end_id} group by delivery_date, client_id, url order by null"
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
