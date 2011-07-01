class AdminCampaignWiseReport < ActiveRecord::Base
    def self.show_data(display,type,startdate,enddate)
        if (type == "Campaigns_Performance")
            #~ puts "coming......if....."
                find_by_sql("select campaign_name, campaign_id,sum(clicks) as clicks , sum(impressions) as impressions ,sum(amount_spent) as amt_spent,((sum(clicks)/sum(impressions))*100) as ctr, ((traffic/traffic_total)*100) as percentage from admin_campaign_wise_reports group by campaign_name order by amount_spent #{display} limit 10")
          elsif (type=="Overall_Performance")
            #~ puts "coming....else......."
                find_by_sql("select campaign_name, campaign_id,sum(clicks) as clicks , sum(impressions) as impressions ,sum(amount_spent) as amt_spent,((sum(clicks)/sum(impressions))*100) as ctr, ((traffic/traffic_total)*100) as percentage from admin_campaign_wise_reports group by campaign_name order by amount_spent #{display} ")
          end
        end
         def self.camp_id()
              find_by_sql("select campaign_id from admin_campaign_wise_reports  ")
         end
	#~ def self.show_data()
          #~ find_by_sql("select * from admin_campaign_wise_reports ")
          #~ find_by_sql("select campaign_name, campaign_id,sum(clicks) as clicks , sum(impressions) as impressions ,sum(amount_spent) as amt_spent,((sum(clicks)/sum(impressions))*100) as ctr, ((traffic/traffic_total)*100) as percentage from admin_campaign_wise_reports  where daydate>='2011-06-24' and daydate<='2011-06-25' group by campaign_id order by amount_spent asc")
          #~ puts "coming..........."
          #~ find_by_sql("select campaign_name, campaign_id,sum(clicks) as clicks , sum(impressions) as impressions ,sum(amount_spent) as amt_spent,((sum(clicks)/sum(impressions))*100) as ctr, ((traffic/traffic_total)*100) as percentage from admin_campaign_wise_reports group by campaign_name order by amount_spent asc")
	#~ end
end
#~ p c=AdminCampaignWiseReports.new.show_data
#~ puts a=c.show_data