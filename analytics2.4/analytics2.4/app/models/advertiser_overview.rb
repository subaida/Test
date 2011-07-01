class AdvertiserOverview < ActiveRecord::Base
    
    def self.top_bar(start_date,end_date)
      #p start_date.strftime("%y-%bb-%d")
     find_by_sql("select sum(traffic_clicks) as clicks , sum(traffic) as impressions ,sum(cost_clicks) as amt_spent,((sum(traffic_clicks)/sum(traffic))*100) as ctr, ((traffic/traffic_total)*100) as percentage from advertiser_overviews where daydate>='#{Time.parse(start_date).strftime("%Y-%m-%d")}' and daydate<='#{Time.parse(end_date).strftime("%Y-%m-%d")}'")
       #find_by_sql("select sum(clicks) as clicks , sum(impressions) as impressions ,((sum(clicks)/sum(impressions))*100)  as ctr, sum(amount_spent) as  amount_spent from admin_campaign_wise_reports where daydate>='2011-06-25'and daydate<='2011-06-25'")
    end
    
    #~ def self.top_campaigns_performance(display,start_date,end_date,limit)
      #~ puts "-------1--------"
       #~ puts display
        #~ find_by_sql("select campaign_id,sum(clicks) as clicks , sum(impressions) as impressions ,sum(amount_spent) as amt_spent,((sum(clicks)/sum(impressions))*100) as ctr, ((traffic/traffic_total)*100) as percentage from admin_campaign_wise_reports where daydate>='#{Time.parse(start_date).strftime("%Y-%m-%d")}' and daydate<='#{Time.parse(end_date).strftime("%Y-%m-%d")}' group by campaign_id order by amount_spent #{display} limit #{limit}")
        #~ find_by_sql("select campaign_id, c.campaign_name, sum(clicks) as clicks , sum(impressions) as impressions ,sum(cs.amount_spent) as amt_spent,((sum(clicks)/sum(impressions))*100) as ctr, ((traffic/traffic_total)*100) as percentage from admin_campaign_wise_reports cs,campaigns c where  c.id=cs.campaign_id and (cs.impressions>0 or cs.clicks>0) group by campaign_id order by cs.amount_spent #{display} limit 10")
     #~ end
     
     def self.overall_campaigns_performance(display,start_date,end_date)
       #~ puts "------2---------"
       #~ puts display order by #{adminreport_name=='amount_spent' ? 'amt_spent' : adminreport_name} #{display}
       find_by_sql("select campaign_id, sum(traffic_clicks) as clicks , sum(traffic) as impressions ,sum(cost_clicks) as amt_spent,((sum(traffic_clicks)/sum(traffic))*100) as ctr, ((traffic/traffic_total)*100) as percentage from advertiser_overviews where daydate>='#{Time.parse(start_date).strftime("%Y-%m-%d")}' and daydate<='#{Time.parse(end_date).strftime("%Y-%m-%d")}' group by campaign_id ")
       #~ find_by_sql("select campaign_id, c.campaign_name, sum(clicks) as clicks , sum(impressions) as impressions ,sum(cs.amount_spent) as amt_spent,((sum(clicks)/sum(impressions))*100) as ctr, ((traffic/traffic_total)*100) as percentage from admin_campaign_wise_reports cs,campaigns c where  c.id=cs.campaign_id and (cs.impressions>0 or cs.clicks>0) group by campaign_id order by cs.amount_spent #{display}")
     end
 end
	#~ def self.show_data()
          #~ find_by_sql("select * from admin_campaign_wise_reports ")
          #~ find_by_sql("select campaign_name, campaign_id,sum(clicks) as clicks , sum(impressions) as impressions ,sum(amount_spent) as amt_spent,((sum(clicks)/sum(impressions))*100) as ctr, ((traffic/traffic_total)*100) as percentage from admin_campaign_wise_reports  where daydate>='2011-06-24' and daydate<='2011-06-25' group by campaign_id order by amount_spent asc")
          #~ puts "coming..........."
          #~ find_by_sql("select campaign_name, campaign_id,sum(clicks) as clicks , sum(impressions) as impressions ,sum(amount_spent) as amt_spent,((sum(clicks)/sum(impressions))*100) as ctr, ((traffic/traffic_total)*100) as percentage from admin_campaign_wise_reports group by campaign_name order by amount_spent asc")
	#~ end
#~ end
#~ p c=AdminCampaignWiseReports.new.show_data
#~ puts a=c.show_data