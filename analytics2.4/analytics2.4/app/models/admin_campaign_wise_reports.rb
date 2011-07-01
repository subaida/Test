class AdminCampaignWiseReport < ActiveRecord::Base
#def self.show_data(id,type)
        #if (type == "notreport")
         #     find_by_sql("select impression,continent_code from publisher_traffic_contient_overviews limit 5")
#        elsif (type=="report")
             # find_by_sql("select impression,continent_code from publisher_traffic_contient_overviews ")
        #end
    #end
	def self.show_data()
          #~ find_by_sql("select * from admin_campaign_wise_reports ")
          find_by_sql("select sum(clicks) as clicks , sum(impressions) as impressions ,((sum(clicks)/sum(impressions))*100)  as ctr, sum(amount_spent) as amount_spent from admin_campaign_wise_reports where daydate>='2011-06-23' and daydate<='2011-06-23'")
	end
end
#~ p c=AdminCampaignWiseReports.new.show_data
#~ puts a=c.show_data
#~ select sum(clicks) as clicks , sum(impressions) as impressions ,((sum(clicks)/sum(impressions))*100)  as ctr, sum(amount_spent) 
#~ as  amount_spent from admin_campaign_wise_reports where daydate>
#~ ='2011-06-23' and daydate<='2011-06-23'"