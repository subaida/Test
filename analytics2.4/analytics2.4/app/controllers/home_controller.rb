
#/*
# * Reports.rb
# *
# * Author : Md Shujauddeen
# * Version: 1.0
# * Created: 23-07-2008
# * Last Modified: 07-10-2008
# *
# * Copyright (c) 2003-2008 by CalChennai Mobile-worx  Pvt Ltd
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
# * Version: 0.9.1
# * Note: This is the reports component, which is used to generate reports for advertiser every day in day basis.
# *           This is used to generate reports only for WAP CPC Campaigns
# */
##

require 'aes_security.rb' #this is to require AES security component
class HomeController < ApplicationController
  @@aes = AESSecurity.new()
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#Method Name: index
	#Purpose: redirecting to home page.
	#Version: 1.0
	#Author: Md Shujauddeen A
	#Last Modified: 20-Oct-2008 by Md Shujauddeen A
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  def index
      begin
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @@aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
                  redirect_to :action=>'home_analytics'
              else
                  flash[:notice]="Your are not an authorized user. Please login with different username."
                  redirect_to :controller=>'login', :action=>'login'
              end
          end
      rescue Exception => e
          puts "ERROR :: home/home_analytics :: #{e.to_s}"
      end
    end
    
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#Method Name: home_analytics
	#Purpose: to render home page
	#Version: 1.0
	#Author: Md Shujauddeen A
	#Last Modified: 20-Oct-2008 by Md Shujauddeen A
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
     def home_analytics
      begin
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @@aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
                  duration=params[:duration]!=nil ? params[:duration] : @@aes.encrypt(session[:key],session[:iv],'1')
                  showlist=params[:showlist]!=nil ? params[:showlist] : @@aes.encrypt(session[:key],session[:iv],'5')
                  @duration=@@aes.decrypt(session[:key],session[:iv],duration)
                  @showlist=@@aes.decrypt(session[:key],session[:iv],showlist)
                  @end_date=((Time.now)-(@duration=='1' ? 60*60*24 : 0)).strftime('%Y-%m-%d')
                  @start_date=((Time.now)-(60*60*24*(@duration).to_i)).strftime('%Y-%m-%d')
                  user_id = @@aes.decrypt(session[:key],session[:iv],session[:user_id])
                  verifyDBconnection
                  @publisher=Publisher.find_by_user_id(user_id)
                  @advertiser=Advertiser.find_by_user_id(user_id)
                  limit=(@showlist=='ALL') ? "" : "limit #{@showlist}"
                  adclient_query="select adc.app_name as site_name,client_id,sum(impressions) as sum_impressions,sum(clicks) as sum_clicks,((sum(clicks)/sum(impressions))*100) as ctr,sum(revenue) as sum_revenue,((sum(revenue)/sum(impressions))*1000) as ecpm from adclients_summaries a,adclients adc where pub_id = #{@publisher.id} and adc.publisher_id=#{@publisher.id} and adc.id=a.client_id and delivery_date>='#{@start_date} 00:00:00' and delivery_date<='#{@end_date} 23:59:59' group by site_name order by sum_impressions desc #{limit} "
                  campaign_query="select c.campaign_name as camp_name,cs.campaign_id,cs.ad_client_type,sum(cs.impressions) as sum_impressions, sum(cs.clicks) as sum_clicks, ((sum(cs.clicks)/sum(cs.impressions))*100) as ctr, sum(cs.amount_spent)  as sum_amount_spent from campaigns_summaries cs, campaigns c where  cs.advertiser_id=#{@advertiser.id}   and cs.delivery_date>='#{@start_date}' and cs.delivery_date<='#{@end_date}' and c.id=cs.campaign_id group by camp_name order by sum_impressions desc #{limit}"
                  @adclient_summary=AdclientsSummary.find_by_sql(adclient_query)
                  @campaign_summary=CampaignsSummary.find_by_sql(campaign_query)
              else
                  flash[:notice]="Your are not an authorized user. Please login with different username."
                  redirect_to :controller=>'login', :action=>'login'
              end
          end  
      rescue Exception => e
          puts "ERROR :: home/home_analytics :: #{e.to_s}"
      end
    end
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#Method Name: home_analytics
	#Purpose: to render home page
	#Version: 1.0
	#Author: Md Shujauddeen A
	#Last Modified: 20-Oct-2008 by Md Shujauddeen A
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    def verifyDBconnection
        check_DBstatus=ActiveRecord::Base.connection.active?
        if check_DBstatus==true
        else
               ActiveRecord::Base.connection.reconnect!
        end
    end
end
