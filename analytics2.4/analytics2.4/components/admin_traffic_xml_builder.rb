require 'dbi'

#/*
# * admin_xml_builder.rb
# *
# * Author :Dipti Uppal
# * Version: 1.0
# * Created: 26-08-2008
# * Last Modified: 
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
# * Contact us at 
# * info@mobile-worx.com
# *
# * Notes
# * Version: 0.9.1
# * Functionality: Admin XML Builder is used to Build the XML  for all the Admin requests. 
# */
##
#
require 'AnalyticsDBConnection'
ActiveRecord::Base.establish_connection(  
:adapter => "mysql",  
:host => HOSTNAME,  
:database => DATABASE,
:username => USERNAME,
:password => PASSWORD
)
class CampaignsSummary < ActiveRecord::Base
end
class AdvDeviceproperty < ActiveRecord::Base
end
class AdvCarrier < ActiveRecord::Base
end
class AdclientsSummary < ActiveRecord::Base  
end
class PubChannel < ActiveRecord::Base
end
class PubUrl < ActiveRecord::Base
end

class AdminTrafficXmlBuilder

#Declaration of variables, used for displaying the charts.
       @@i = 0 
       @@XML_array=Array.new
       @@xml_count=0
       @intPage =0 
       @@flag = true

#--------------------------------------------------------------------------------------------
  #Method Name: campaign_performance
  #Purpose: Used to display the Charts for the Campaign Performance Screen.
  #Version: 1.0
  #Author:Dipti Uppal
  #Last Modified:
  #Notes: None.
#-------------------------------------------------------------------------------------------- .         
  def campaign_performance(*args)
    # Query to get the Data for Pie Chart.       
      begin
       @@strXML=''
       @@flag = true
       @@xml_hash = Hash.new
       @@XML_array = Array.new
       @@i = 0 
       @@getsymbol={"&"=>"%26","%"=>"%25"}
       # Getting the values 
       @intPage = args[0]
       @Campaign_Id = args[1]
       @Ad_Id = args[2]
       startDate = args[3]
       endDate = args[4] 
       
       # Query to get Data for the Pie Chart.
       if @Campaign_Id == nil or @Campaign_Id == "All"
          @strOperations = "Campaigns"
          @strQuery = "select Campaign_Id, Campaign_Name, sum(Impressions) as Impressions, Clicks,CTR, CPM, ZestADZ_Revenue, CPC  from campaigns_summaries  group by Campaign_Name order by Impressions desc limit 10 offset #{@intPage}"  
          @recordset = CampaignsSummary.find_by_sql(@strQuery)
          #Future Enhancement.
       #elsif @Campaign_Id != nil  or   startDate=='' and endDate=='' and @Ad_Id==nil and @Ad_Id==''
       #   @strOperations = "Ads"
          #@strQuery = "select Campaign_Id, Campaign_Name, sum(Impressions) as No_Of_Impression from campaigns_summaries where Campaign_Id =#{@Campaign_Id} group by Campaign_Name limit 10 offset #{@intPage}"  
        #  @strQuery = "select distinct(ad_text) , sum(a.Impressions) as No_Of_Impression  from  campaigns_summaries c , ads a  where a.campaign_id = #{@Campaign_Id} group by ad_text limit 10  "  
         # @recordset = Ad.find_by_sql(@strQuery)
       #elsif @Campaign_Id != nil and @Ad_Id!=nil and startDate!=nil and endDate!=nil     
        #  @strOperations = "Ads with date"
         # @strQuery = "select monthname(c.Delivery_Date) , a.id ,a.ad_text, sum(a.Impressions) as Impressions ,  sum(a.clicks) as Clicks from  campaigns_summaries c , ads a  where a.campaign_id = #{@Campaign_Id} and a.id = #{@Ad_Id} and month(Delivery_Date)>='#{startDate}' and month(Delivery_Date)<='#{endDate}'  group by  month(Delivery_Date) "  
         # @recordset = Ad.find_by_sql(@strQuery)
       #elsif @Campaign_Id != nil and @Ad_Id!=nil or startDate=='' and endDate==''    
       #   @strOperations = "Ads with date"
        #  @strQuery = "select monthname(c.Delivery_Date) as Created_Date , a.id ,a.ad_text, sum(a.Impressions) as Impressions ,  sum(a.clicks) as Clicks from campaigns_summaries c,  ads a where a.campaign_id = #{@Campaign_Id} and a.id=#{@Ad_Id} group by  month(c.Delivery_Date)"  
        #  @recordset = Ad.find_by_sql(@strQuery)          
      end
      
       # Traverse through all the records.
       if @recordset.size!= 0
         for recordset in @recordset
           # Call the piechart method to display the Data for Chart.
           if @strOperations == "Campaigns"
               @strCampaignName = (recordset.Campaign_Name).gsub(/["']/, '')
               generate_piechartXML(@strCampaignName,recordset.Impressions)
           #Future Enhancement.    
           #elsif @strOperations == "Ads"
            #   @strAdsName = (((recordset.ad_text).gsub(/["']/, '')).rstrip).gsub("&", " ")
            #   generate_piechartXML(@strAdsName,recordset.No_Of_Impression)
          # elsif @strOperations == "Ads with date"       
            #   generate_multiLinechartXMLDate(recordset.Created_Date)         
           #    @strAdsName = (((recordset.ad_text).gsub(/["']/, '')).rstrip).gsub("&", " ")
           #    generate_multiLinechartCampXML("Clicks", recordset.Clicks)  
           #    generate_multiLinechartCampXML("Impressions", recordset.Impressions)        
           end
         end
         
         @@strXML+= "</chart>" 
          @@xml_hash={:xml_string=>@@strXML,:xml_array=>@@XML_array}
          
        return @@xml_hash
      end 
      rescue Exception=>e
       puts "DEBUGGER :: ERROR :: in admin_traffic_xml_builder.rb - Campaign_performance :: #{e.to_s}"
     end
  end
  
#--------------------------------------------------------------------------------------------
  #Method Name: publisher_performance
  #Purpose: Used to display the Charts for the Publisher Performance Screen.
  #Version: 1.0
  #Author:Dipti Uppal
  #Last Modified: Md Shujauddeen
  #Notes: None.
#-------------------------------------------------------------------------------------------- .      
  def publisher_performance(*args) 
    # Query to get the Data for Pie Chart.       
      begin
       @@strXML=''
       @@flag = true
       @intPage = args[0]
       @@xml_hash = Hash.new
       @@XML_array = Array.new
       @@i = 0
       # Query to get Data for the Pie Chart.
       @strQuery = "select pub_id, pub_name as Publisher_Name, impressions as Impressions, clicks as Clicks ,ctr as CTR, ecpm as ECPM , revenue as Publisher_Revenue from adclients_summaries group by pub_name order by Impressions desc limit 10 offset #{@intPage}" 
       @recordset = AdclientsSummary.find_by_sql(@strQuery)
       # Traverse through all the records.
       if @recordset.size!= 0
         for recordset in @recordset
           # Call the piechart method to display the Data for Chart.
           @strPubName = (recordset.Publisher_Name).gsub(/["']/, '')
           generate_piechartXML(@strPubName ,recordset.Impressions)
         end
         @@strXML+= "</chart>" 
         @@xml_hash={:xml_string=>@@strXML,:xml_array=>@@XML_array}
         return @@xml_hash
      end 
      rescue Exception=>e
       puts "DEBUGGER :: ERROR :: in admin_traffic_xml_builder.rb - publisher_performance :: #{e.to_s}"
     end  
   end
   
#--------------------------------------------------------------------------------------------
  #Method Name: advertiser_performance
  #Purpose: Used to display the Charts for the Advertiser Performance Screen.
  #Version: 1.0
  #Author:Dipti Uppal
  #Last Modified: Md Shujauddeen
  #Notes: None.
#-------------------------------------------------------------------------------------------- .        
    def advertiser_performance(*args) 
       begin
       @@strXML=''
       @@flag = true
       @intPage = args[0]
       @@xml_hash = Hash.new
       @@XML_array = Array.new
       @@flag=true
       
       # Query to get Data for the line Chart.
       @strQuery = "select Advertiser_Name,advertiser_id,Impressions,Clicks,CTR,CPM,CPC  from campaigns_summaries group by Advertiser_Name order by Impressions desc limit 10 offset #{@intPage}" 
       @recordset = CampaignsSummary.find_by_sql(@strQuery)
           
       # Traverse through all the records.
       if @recordset.size!= 0
         for recordset in @recordset
           # Call the piechart method to display the Data for Chart.
           @strAdvName = (recordset.Advertiser_Name).gsub(/["']/, '')
           generate_linechartXML(@strAdvName ,recordset.Impressions)
         end
         @@strXML+= "</chart>" 
         @@xml_hash={:xml_string=>@@strXML}
         return @@xml_hash
       end 
       rescue Exception=>e
        puts "DEBUGGER :: ERROR :: in admin_traffic_xml_builder.rb - advertiser_performance :: #{e.to_s}"
     end  
   end
      
#--------------------------------------------------------------------------------------------
  #Method Name: advpub_registration
  #Purpose: Used to display the Charts for the Advertiser Publisher Registeration Screen.
  #Version: 1.0
  #Author:Dipti Uppal
  #Last Modified:
  #Notes: None.
#-------------------------------------------------------------------------------------------- .     
  def advpub_registration(*args) 
       begin
       @@strXML=''
       @@flag = true
       @@xml_hash = Hash.new
       @@XML_array = Array.new
       @flagAdmin = true
       @flagAdv = true
       @flagPub = true
       @flagDate = true
       startDate = args[0]
       endDate = args[1]
       
       #Future Enhancement. Query to get Data for the line Chart.
       #@strQuery = "select  distinct(monthname(created_at)) as Created_Date from users, roles where users.role_id= roles.id group by users.role_id ,  month(users.created_at) " 
       #@recordset = User.find_by_sql(@strQuery)

       @strQuery = "select  distinct(monthname(created_at)) as Created_Date from users, roles where users.role_id= roles.id" 
       @strQuery+= " and created_at>='#{startDate}' and  created_at<='#{endDate}'" if ((startDate=='select start date' and  endDate=='select end date') and (startDate==nil and  endDate==nil))
       @strQuery+= " and created_at>='#{startDate}' and  created_at<='#{endDate}'" if ((startDate!='select start date' and  endDate!='select end date') and (startDate!=nil and  endDate!=nil))
       @strQuery+="  group by users.role_id ,  month(users.created_at)"  
       @recordset = User.find_by_sql(@strQuery)
        
       # Traverse through all the records.
       if @recordset.size!= 0
         for recordset in @recordset
           # Call the piechart method to display the Data for Chart.
           generate_multiLinechartXMLDate(recordset.Created_Date)
         end
       end
       
       #Future Enhancement.Query to get Data for the line Chart.
       #@strQuery = "select count(users.id) as Users, roles.role_name as Role_Name from users, roles where users.role_id= roles.id group by users.role_id ,  month(users.created_at) " 
       #@recordset = User.find_by_sql(@strQuery)

       @strQuery = "select count(users.id) as Users, roles.role_name as Role_Name from users, roles where users.role_id= roles.id" 
       @strQuery+= " and created_at>='#{startDate}' and  created_at<='#{endDate}'" if ((startDate=='select start date' and  endDate=='select end date') and (startDate==nil and  endDate==nil))
       @strQuery+= " and created_at>='#{startDate}' and  created_at<='#{endDate}'" if ((startDate!='select start date' and  endDate!='select end date') and (startDate!=nil and  endDate!=nil))
       @strQuery+=" group by users.role_id ,  month(users.created_at)"        
       @strQuery
       @recordset = User.find_by_sql(@strQuery)
           
       # Traverse through all the records.
       if @recordset.size!= 0
         for recordset in @recordset
           # Call the piechart method to display the Data for Chart.
           @strAdvPubName = (recordset.Role_Name).gsub(/["']/, '')
           generate_multiLinechartXML(recordset.Users, @strAdvPubName)
         end 
       @@strXML+= "</dataset></chart>" 
       @@xml_hash={:xml_string=>@@strXML}
       return @@xml_hash
      end 
      rescue Exception=>e
       puts "DEBUGGER :: ERROR :: in admin_traffic_xml_builder.rb - advpub_registration :: #{e.to_s}"
     end  
   end

#--------------------------------------------------------------------------------------------
  #Method Name: publisher_traffic_growth
  #Purpose: Used to display the Charts for the Publisher Traffic Growth Screen.
  #Version: 1.0
  #Author:Md Shujaudeen
  #Last Modified:
  #Notes: None.
#-------------------------------------------------------------------------------------------- .    
  def publisher_traffic_growth(*args) 
       begin
      @@strXML=''
           @@flag = true
           @@xml_hash = Hash.new
           @@date_count=0
           publisher_id = args[0]
           startDate = args[1]
           endDate = args[2]
           chartType=args[3]
           duration=args[4]
           @@date_count=Time.parse(startDate)
            column1=chartType=='bar' ? 'monthname(delivery_date) as month' : 'delivery_date'
            adv_id= (publisher_id=='All' || publisher_id==nil || publisher_id=='') ? "" : " and pub_id='#{publisher_id}'"
            group_value= chartType=='bar' ? "year(Delivery_Date), month(Delivery_Date)" : "year(Delivery_Date), month(Delivery_Date),Day(delivery_date)"
            @strQuery="select #{column1}, sum(impressions) as sum_impression from  adclients_summaries"
            @strQuery+=" where delivery_date>='#{startDate} 00:00:00' and delivery_date<='#{endDate} 23:59:59' #{adv_id}"
            @strQuery+=" group by #{group_value}" 
            @recordset = AdclientsSummary.find_by_sql(@strQuery)
            # Traverse through all the records.
            if @recordset.size!= 0
                for recordset in @recordset
                   # Call the piechart method to display the Data for Chart.
                   generate_linechartXML(recordset.month,recordset.sum_impression) if chartType=='bar'
                   generate_traffic_growth_XML(recordset.sum_impression,recordset.delivery_date,duration,endDate) if chartType=='line'
                 end
                 if chartType=='line'
                     @anchor_color="anchorBgColor='FF0000'"
                      if Time.parse(endDate).strftime("%Y-%m-%d")>@@date_count.strftime("%Y-%m-%d")
                           while Time.parse(endDate).strftime("%Y-%m-%d")>=@@date_count.strftime("%Y-%m-%d")
                                  if Time.parse(endDate).strftime("%Y-%m-%d")==@@date_count.strftime("%Y-%m-%d")
                                         @@strXML+= "<set name='#{@@date_count.strftime("%d-%b-%Y")}' value='0' #{@anchor_color if duration.to_i==0}/>" 
                                  else
                                        @@strXML+= "<set name='#{@@date_count.strftime("%d-%b-%Y")}' value='0'/>"
                                  end
                                  @@date_count+=86400
                            end
                      elsif Time.parse(endDate).strftime("%Y-%m-%d")==@@date_count.strftime("%Y-%m-%d")
                             @@strXML+= "<set name='#{@@date_count.strftime("%d-%b-%Y")}' value='0' #{@anchor_color if duration.to_i==0}/>" 
                      end
                end
                @@strXML+= "</chart>" 
                return @@strXML
            end 
      rescue Exception=>e
       puts "DEBUGGER :: ERROR :: in admin_traffic_xml_builder.rb - publisher_traffic_growth :: #{e.to_s}"
     end  
   end
  
 
#--------------------------------------------------------------------------------------------
  #Method Name: advertiser_traffic_growth
  #Purpose: Used to display the Charts for the Publisher Traffic Growth Screen.
  #Version: 1.0
  #Author:Md Shujauddeen
  #Last Modified: Md Shujauddeen 
  #Notes: Had to change the code, as the functionality was not working properly.
#-------------------------------------------------------------------------------------------- .      
   def advertiser_traffic_growth(*args)
     begin
           @@strXML=''
           @@flag = true
           @@xml_hash = Hash.new
           @@date_count=0
           advertiser_id = args[0]
           startDate = args[1]
           endDate = args[2]
           chartType=args[3]
           duration=args[4]
           @@date_count=Time.parse(startDate)
            column1=chartType=='bar' ? 'monthname(delivery_date) as month' : 'delivery_date'
            adv_id= (advertiser_id=='All' || advertiser_id==nil || advertiser_id=='') ? "" : " and advertiser_id='#{advertiser_id}'"
            group_value= chartType=='bar' ? "year(Delivery_Date), month(Delivery_Date)" : "year(Delivery_Date), month(Delivery_Date),Day(delivery_date)"
            @strQuery="select #{column1}, sum(impressions) as sum_impression from  campaigns_summaries"
            @strQuery+=" where delivery_date>='#{startDate} 00:00:00' and delivery_date<='#{endDate} 23:59:59' #{adv_id}"
            @strQuery+=" group by #{group_value}"   
            @recordset = CampaignsSummary.find_by_sql(@strQuery)
            # Traverse through all the records.
            if @recordset.size!= 0
                   for recordset in @recordset
                     # Call the piechart method to display the Data for Chart.
                     generate_linechartXML(recordset.month,recordset.sum_impression) if chartType=='bar'
                     generate_traffic_growth_XML(recordset.sum_impression,recordset.delivery_date,duration,endDate) if chartType=='line'
                   end
                  if chartType=='line'
                      @anchor_color="anchorBgColor='FF0000'"
                      if Time.parse(endDate).strftime("%Y-%m-%d")>@@date_count.strftime("%Y-%m-%d")
                           while Time.parse(endDate).strftime("%Y-%m-%d")>=@@date_count.strftime("%Y-%m-%d")
                                  if Time.parse(endDate).strftime("%Y-%m-%d")==@@date_count.strftime("%Y-%m-%d")
                                         @@strXML+= "<set name='#{@@date_count.strftime("%d-%b-%Y")}' value='0' #{@anchor_color if duration.to_i==0}/>" 
                                  else
                                        @@strXML+= "<set name='#{@@date_count.strftime("%d-%b-%Y")}' value='0'/>"
                                  end
                                  @@date_count+=86400
                                end
                         elsif Time.parse(endDate).strftime("%Y-%m-%d")==@@date_count.strftime("%Y-%m-%d")
                                 @@strXML+= "<set name='#{@@date_count.strftime("%d-%b-%Y")}' value='0' #{@anchor_color if duration.to_i==0}/>" 
                        end
                    end
            @@strXML+= "</chart>" 
            return @@strXML
            end 
      rescue Exception=>e
          puts "DEBUGGER :: ERROR :: in admin_traffic_xml_builder.rb - advertiser_traffic_growth :: #{e.to_s}"
     end  
    end

#--------------------------------------------------------------------------------------------
  #Method Name: admin_traffic_growth_continent
  #Purpose: Displaying charts as per traffic for continent
  #Version: 1.0
  #Author:Md Shujauddeen
  #Last Modified:
  #Notes: None.
#-------------------------------------------------------------------------------------------- .      
   def admin_traffic_growth_continent(*args)
     begin
       @@strXML=''
       @@date_count=0
       @@flag = true
       @@xml_hash = Hash.new
       @@XML_array = Array.new
        startDate = args[0]
        endDate = args[1]
        user_type = args[2]
        ad_request='impressions'
        query= "select continent_code,country_code, sum(#{ad_request}) as sum_requests from #{user_type}" 
        query+=" where delivery_date>='#{(Time.parse(startDate)).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(endDate)).strftime("%Y-%m-%d")} 23:59:59' and #{ad_request} > 0" 
        query+= " group by continent_code,country_code order by sum_requests desc"
        p
        @recordset = CampaignsSummary.find_by_sql(query)
        if @recordset.size!= 0
           for recordset in @recordset
              # Call the piechart method to display the Data for Chart.
              generate_contmapXML(recordset.continent_code,recordset.country_code,recordset.sum_requests,'traffic_growth')
           end
           @@strXML+="</data>"
           @@strXML+="<colorRange><color minValue='0' maxValue='#{(@@date_count/3)}' displayValue='Low' color='A7FF98' /><color minValue='#{((@@date_count/3))}' maxValue='#{(@@date_count-(@@date_count/3))}' displayValue='Moderate' color='2CCE00' /><color minValue='#{(@@date_count-(@@date_count/3))}' maxValue='#{(@@date_count)+1}' displayValue='High' color='007700' /></colorRange></map>"
        else
        end 
       return @@strXML
      rescue Exception=>e
          puts "DEBUGGER :: ERROR :: in admin_traffic_xml_builder.rb - admin_traffic_growth_continent :: #{e.to_s}"
     end  
    end
    
#--------------------------------------------------------------------------------------------
  #Method Name: Device Summary
  #Purpose: Used to display the Charts for the Device Summary Screen.
  #Version: 1.0
  #Author:Md Shujauddeen
  #Last Modified: Md Shujauddeen A
  #Notes: None.
#-------------------------------------------------------------------------------------------- .         
  def device_summary(*args)
    # Query to get the Data for Pie Chart.       
      begin
       @@strXML=''
       @@flag = true
       @@xml_hash = Hash.new
       startDate = args[0]
       endDate = args[1]
       limit = args[2]
       country=args[3]
       fill_type=args[4]
       get_col=fill_type=='filled' ? "sum(impressions)" : fill_type=='unfilled' ? "sum(fill_rate)" : "sum(fill_rate)+sum(impressions)"
       get_country=country.upcase=='ALL' ? "" : "ac.country_name='#{country}' and ad.continent_code=ac.continent_code and ad.country_code=ac.country_code and"
       filter_table=country.upcase=='ALL' ? "devices_summaries" : "devices_summaries ad,analytics_country_list ac"
       filter_col=fill_type.to_s=='filled' ? "and impressions>0" : fill_type.to_s=='unfilled' ? "and fill_rate>0" : "and (impressions>0 or fill_rate>0)"
       # Query to get Data for the line Chart.
       @strQuery = "select handset ,#{get_col} as traffic_acquired from #{filter_table} where #{get_country} " 
       @strQuery+= "delivery_date>='#{(Time.parse(startDate)).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(endDate)).strftime("%Y-%m-%d")} 23:59:59' #{filter_col}" 
       @strQuery+= " group by handset order by traffic_acquired desc"
       @recordset = CampaignsSummary.find_by_sql(@strQuery)
       # Traverse through all the records.
       if @recordset.size!= 0
           count=0
           othersValue=0
           for recordset in @recordset
             # Call the piechart method to display the Data for Chart.
             @strDevName = (recordset.handset!=nil && recordset.handset!='') ? "#{(recordset.handset).gsub(/["']/, '')}" : "Unknown"
             count+=1
            if (count.to_i<=limit.to_i)
                  generate_piechartXML(@strDevName ,recordset.traffic_acquired)
            else
                othersValue+=recordset.traffic_acquired.to_i
                if (@recordset.size.to_i==count.to_i)
                      generate_piechartXML('Others',othersValue)
                end
            end
           end
           @@strXML+= "</chart>" 
        else
        end 
        strxml=@@strXML
        @@strXML=''
      return strxml
       rescue Exception=>e
       puts "DEBUGGER :: ERROR :: in admin_traffic_xml_builder.rb - device_summary :: #{e.to_s}"
     end
   end
   
#--------------------------------------------------------------------------------------------
  #Method Name: Device Summary
  #Purpose: Used to display the Charts for the Device Summary Screen.
  #Version: 1.0
  #Author:Md Shujauddeen
  #Last Modified: Md Shujauddeen A
  #Notes: None.
#-------------------------------------------------------------------------------------------- .         
  def device_model_summary(*args)
    # Query to get the Data for Pie Chart.       
      begin
       @@strXML=''
       @@flag = true
       @@xml_hash = Hash.new
       startDate = args[0]
       endDate = args[1]
       limit = args[2]
       country=args[3]
       fill_type=args[4]
       handset=args[5]
       get_col=fill_type=='filled' ? "sum(impressions)" : fill_type=='unfilled' ? "sum(fill_rate)" : "sum(fill_rate)+sum(impressions)"
       get_country=country.upcase=='ALL' ? "" : "ac.country_name='#{country}' and ad.continent_code=ac.continent_code and ad.country_code=ac.country_code and"
       filter_table=country.upcase=='ALL' ? "adclients_summaries" : "adclients_summaries ad,analytics_country_list ac"
       filter_col=fill_type.to_s=='filled' ? "and impressions>0" : fill_type.to_s=='unfilled' ? "and fill_rate>0" : "and (impressions>0 or fill_rate>0)"
       # Query to get Data for the line Chart.
       strQuery = "select handset_model ,#{get_col} as traffic_acquired from #{filter_table} where #{get_country} " 
       strQuery+= "delivery_date>='#{(Time.parse(startDate)).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(endDate)).strftime("%Y-%m-%d")} 23:59:59' and handset='#{handset}' #{filter_col}" 
       strQuery+= " group by handset_model order by traffic_acquired desc"
       recordset = CampaignsSummary.find_by_sql(strQuery)
       # Traverse through all the records.
       if recordset.size!= 0
           count=0
           othersValue=0
           for row in recordset
             # Call the piechart method to display the Data for Chart.
             strDevName = (row.handset_model!=nil && row.handset_model!='') ? "#{(row.handset_model).gsub(/["']/, '')}" : "Unknown"
             count+=1
            if (count.to_i<=limit.to_i)
                  generate_piechartXML(strDevName ,row.traffic_acquired,'handset_model')
            else
                othersValue+=row.traffic_acquired.to_i
                if (recordset.size.to_i==count.to_i)
                      generate_piechartXML('Others',othersValue,'handset_model')
                end
            end
           end
           @@strXML+= "</chart>" 
        else
        end 
        strxml=@@strXML
        @@strXML=''
      return strxml
       rescue Exception=>e
       puts "DEBUGGER :: ERROR :: in admin_traffic_xml_builder.rb - device_model_summary :: #{e.to_s}"
     end
  end
   
#--------------------------------------------------------------------------------------------
  #Method Name: publisher_fillrate
  #Purpose: Used to display the Charts for the Device Summary Screen.
  #Version: 1.0
  #Author:Md Shujauddeen
  #Last Modified: Md Shujauddeen A
  #Notes: None.
#-------------------------------------------------------------------------------------------- .   
  def publisher_fillrate(*args)
        begin
       @@strXML=''
       @@flag = true
       @@xml_hash = Hash.new
       startDate = args[0]
       endDate = args[1]
       limit = args[2]
       order = args[3]
       # Query to get Data for the line Chart.
       strQuery = "select p.publisher_name as pub_name ,(sum(fill_rate)+sum(impressions)) as traffic_acquired, (sum(impressions)/(sum(fill_rate)+sum(impressions)))*100 as fr_percentage from adclients_summaries ad,publishers p where " 
       strQuery+= "delivery_date>='#{(Time.parse(startDate)).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(endDate)).strftime("%Y-%m-%d")} 23:59:59' and p.id=ad.pub_id and (ad.impressions>0 or ad.fill_rate>0)" 
       strQuery+= " group by pub_id order by traffic_acquired #{order} limit #{limit}"
       recordset = CampaignsSummary.find_by_sql(strQuery)
       # Traverse through all the records.
       if recordset.size!= 0
           for recordset in recordset
             # Call the piechart method to display the Data for Chart.
             strDevName = (recordset.pub_name!=nil && recordset.pub_name!='') ? "#{(recordset.pub_name).gsub(/["']/, '')}" : "Unknown"
                  generate_ColumnXML(strDevName ,recordset.fr_percentage)
           end
           @@strXML+= "</chart>" 
        else
        end 
        @@xml_hash={:xml_string=>@@strXML}
      return @@xml_hash
       rescue Exception=>e
       puts "DEBUGGER :: ERROR :: in admin_traffic_xml_builder.rb - publisher_fillrate :: #{e.to_s}"
     end
  end
#--------------------------------------------------------------------------------------------
  #Method Name: publisher_fillrate
  #Purpose: Used to display the Charts for the Device Summary Screen.
  #Version: 1.0
  #Author:Md Shujauddeen
  #Last Modified: Md Shujauddeen A
  #Notes: None.
#-------------------------------------------------------------------------------------------- .  
  def publisher_fillrate_country(*args)
        begin
       @@strXML=''
       @@flag = true
       @@xml_hash = Hash.new
       @@date_count=0
       startDate = args[0]
       endDate = args[1]
       pub_id = args[2]
       # Query to get Data for the line Chart.
       strQuery = "select continent_code,country_code, (sum(impressions)/(sum(fill_rate)+sum(impressions)))*100 as fr_percentage from pub_geolocations where " 
       strQuery+= "delivery_date>='#{(Time.parse(startDate)).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(endDate)).strftime("%Y-%m-%d")} 23:59:59' and pub_id=#{pub_id}" 
       strQuery+= " group by continent_code,country_code"
       recordset = CampaignsSummary.find_by_sql(strQuery)
       # Traverse through all the records.
       if recordset.size!= 0
           for recordset in recordset
             # Call the piechart method to display the Data for Chart.
                  generate_contmapXML(recordset.continent_code,recordset.country_code,recordset.fr_percentage,'fillrate')
           end
           @@strXML+="</data>"
           @@strXML+="<colorRange><color minValue='0' maxValue='#{(@@date_count/3)}' displayValue='Low' color='A7FF98' /><color minValue='#{((@@date_count/3))}' maxValue='#{(@@date_count-(@@date_count/3))}' displayValue='Moderate' color='2CCE00' /><color minValue='#{(@@date_count-(@@date_count/3))}' maxValue='#{(@@date_count)+1}' displayValue='High' color='007700' /></colorRange></map>"
      else
      end 
      return @@strXML
       rescue Exception=>e
       puts "DEBUGGER :: ERROR :: in admin_traffic_xml_builder.rb - device_summary :: #{e.to_s}"
     end
  end
 #------------------------------------------ Methods to Display Charts. -----------------------------------------------------#   
 
 
#--------------------------------------------------------------------------------------------
  #Method Name: generate_contmapXML
  #Purpose: This method is used to construct xml structure for Continentwise map.
  #Version: 1.0
  #Author:Md Shujauddeen
  #Last Modified:
  #Notes: None.
#-------------------------------------------------------------------------------------------- 
        def generate_contmapXML(*args)
          begin
            #@continent={"AS"=>"01","EU"=>"02","AF"=>"03","NA"=>"04","SA"=>"05","CA"=>"06","OC"=>"07","ME"=>"08"}
            countrycodeHash={"NA.AG"=>"01","NA.BS"=>"02","NA.BB"=>"03","CA.BZ"=>"04","NA.CA"=>"05","CA.CR"=>"06","NA.CU"=>"07","NA.DM"=>"08","NA.DO"=>"09","CA.SV"=>"10","NA.GD"=>"11","CA.GT"=>"12","NA.HT"=>"13","CA.HN"=>"14","NA.JM"=>"15","NA.MX"=>"16","CA.NI"=>"17","CA.PA"=>"18","NA.KN"=>"19","NA.LC"=>"20","NA.VC"=>"21","NA.TT"=>"22","NA.US"=>"23","NA.GL"=>"24","SA.AR"=>"25","SA.BO"=>"26","SA.BR"=>"27","SA.CL"=>"28","SA.CO"=>"29","SA.EC"=>"30","SA.FK"=>"31","SA.GF"=>"32","SA.GY"=>"33","SA.PY"=>"34","SA.PE"=>"35","SA.SR"=>"36","SA.UY"=>"37","SA.VE"=>"38","AF.DZ"=>"39","AF.AO"=>"40","AF.BJ"=>"41","AF.BW"=>"42","AF.BF"=>"43","AF.BI"=>"44","AF.CM"=>"45","AF.CV"=>"46","AF.CF"=>"47","AF.TD"=>"48","AF.KM"=>"49","AF.CI"=>"50","AF.CD"=>"51","AF.DJ"=>"52","AF.EG"=>"53","AF.GQ"=>"54","AF.ER"=>"55","AF.ET"=>"56","AF.GA"=>"57","AF.GH"=>"58","AF.GN"=>"59","AF.GW"=>"60","AF.KE"=>"61","AF.LS"=>"62","AF.LR"=>"63","AF.LY"=>"64","AF.MG"=>"65","AF.MW"=>"66","AF.ML"=>"67","AF.MR"=>"68","AF.MA"=>"69","AF.MZ"=>"70","AF.NA"=>"71","AF.NE"=>"72","AF.NG"=>"73","AF.RW"=>"74","AF.ST"=>"75","AF.SN"=>"76","AF.SL"=>"78","AF.SO"=>"79","AF.ZA"=>"80","AF.SD"=>"81","AF.SZ"=>"82","AF.TZ"=>"83","AF.TG"=>"84","AF.TN"=>"85","AF.UG"=>"86","AF.ZM"=>"88","AF.ZW"=>"89","AF.GM"=>"90","AF.CG"=>"91","AF.MU"=>"92","AS.AF"=>"93","AS.AM"=>"94","AS.AZ"=>"95","AS.BD"=>"96","AS.BT"=>"97","AS.BN"=>"98","AS.MM"=>"99","AS.KH"=>"100","AS.CN"=>"101","AS.TP"=>"102","AS.GE"=>"103","AS.IN"=>"104","AS.ID"=>"105","ME.IR"=>"106","AS.JP"=>"107","AS.KZ"=>"108","AS.KP"=>"109","AS.KR"=>"110","AS.KG"=>"111","AS.LA"=>"112","AS.MY"=>"113","AS.MN"=>"114","AS.NP"=>"115","AS.PK"=>"116","AS.PH"=>"117","AS.RU"=>"118","AS.SG"=>"119","AS.LK"=>"120","AS.TJ"=>"121","AS.TH"=>"122","AS.TM"=>"123","AS.UZ"=>"124","AS.VN"=>"125","AS.TW"=>"126","AS.HK"=>"127","AS.MO"=>"128","EU.AL"=>"129","EU.AD"=>"130","EU.AT"=>"131","EU.BY"=>"132","EU.BE"=>"133","EU.BA"=>"134","EU.BG"=>"135","EU.HR"=>"136","EU.CZ"=>"137","EU.DK"=>"138","EU.EE"=>"139","EU.FI"=>"140","EU.FR"=>"141","EU.DE"=>"142","EU.GR"=>"143","EU.HU"=>"144","EU.IS"=>"145","EU.IE"=>"146","EU.IT"=>"147","EU.LV"=>"148","EU.LI"=>"149","EU.LT"=>"150","EU.LU"=>"151","EU.MK"=>"152","EU.MT"=>"153","EU.MD"=>"154","EU.MC"=>"155","EU.MO"=>"156","EU.NL"=>"157","EU.NO"=>"158","EU.PL"=>"159","EU.PT"=>"160","EU.RO"=>"161","EU.SM"=>"162","EU.CS"=>"163","EU.SK"=>"164","EU.SI"=>"165","EU.ES"=>"166","EU.SE"=>"167","EU.CH"=>"168","EU.UA"=>"169","EU.UK"=>"170","EU.VA"=>"171","EU.CY"=>"172","EU.TR"=>"173","EU.RU"=>"174","OC.AU"=>"175","OC.FJ"=>"176","OC.KI"=>"177","OC.MH"=>"178","OC.FM"=>"179","OC.NR"=>"180","OC.NZ"=>"181","OC.PW"=>"182","OC.PG"=>"183","OC.WS"=>"184","OC.SB"=>"185","OC.TO"=>"186","OC.TV"=>"187","OC.VU"=>"188","OC.NC"=>"189","ME.BH"=>"190","ME.IQ"=>"191","ME.IL"=>"192","ME.JO"=>"193","ME.KW"=>"194","ME.LB"=>"195","ME.OM"=>"196","ME.QA"=>"197","ME.SA"=>"198","ME.SY"=>"199","ME.AE"=>"200","ME.YE"=>"201","NA.PR"=>"202","NA.KY"=>"203","EU.GB"=>"170","AF.SC"=>"77"}
            @aes = AESSecurity.new()
            if @@flag==true
              @@strXML="<map hoverColor='01B401' #{args[3]=='traffic_growth' ? "" : "forceDecimals='1' numberSuffix='%25'" } decimals='2' useSNameInLabels='0' formatNumberScale='0' showCanvasBorder='0' fillColor='F7F7F7' includeValueInLables='0'  showPercentageValues='1' defaultAnimation='0' showShadow='0' showBevel='0' showLegend='0' showLabels='0'><data>"
              @@flag=false
              @@date_count=args[2].to_i
            end
            if @@date_count<args[2].to_i
              @@date_count=args[2].to_i
            end
             ccode=countrycodeHash["#{args[0]}.#{args[1]}"]
              @@strXML+="<entity id='#{ccode}' value='#{args[2].to_s}'/>" if args[2].to_f > 0.00
          rescue Exception=>e
            puts "ERROR :: in AdminTrafficXmlBuilder Component :: generate_contmapXML method :: #{e.to_s}"
          end
        end #contmapXML ends here
#--------------------------------------------------------------------------------------------
  #Method Name: generate_traffic_growth_XML
  #Purpose: This method is used to construct xml structure for Linechart.
  #Version: 1.0
  #Author:Md Shujauddeen
  #Last Modified:
  #Notes: None.
#-------------------------------------------------------------------------------------------- 
def generate_traffic_growth_XML(*args)
          begin
                if @@flag==true
                        @@strXML="<chart decimals='2' connectNullData='1' lineDashGap='6' labelDisplay='WRAP' lineColor ='1E9DC8' anchorSides='10' anchorRadius='4' anchorBgColor='1E9DC8' anchorBorderColor='FFFFFF' anchorBorderThickness='1' labelStep='#{args[2].to_i==6 ? 1 : 5}' numDivLines='3' alternateHGridColor='FFFFFF' divLineColor='CCCCCC'  numVDivLines='0' showLabels='1' showValues='0' canvasBorderColor ='FFFFFF' canvasBorderAlpha='0' canvasBorderThickness='0'  baseFontSize ='12' chartTopMargin='8' chartLeftMargin='1'  decimalPrecision='0' bgColor='ffffff' xAxisName='' yAxisName='Impressions' showNames='1' showBorder='0' chartRightMargin='35' formatNumberScale='0' > "
                  @@flag=false
                end
                @anchor_color="anchorBgColor='FF0000'"
                @delivery_date=args[1].to_s
                @delivery_date=Time.parse(@delivery_date)
                if @delivery_date.strftime("%Y-%m-%d")>@@date_count.strftime("%Y-%m-%d")
                      while @delivery_date.strftime("%Y-%m-%d")>@@date_count.strftime("%Y-%m-%d")
                                 @@strXML+= "<set name='#{@@date_count.strftime("%d-%b-%Y")}' value='0'/>"
                            @@date_count+=86400
                          end
                      @@strXML+= "<set name='#{@@date_count.strftime("%d-%b-%Y")}' value='#{args[0]==nil ? 0 : args[0].to_s}' #{@anchor_color if args[2].to_i==0 and Time.parse(args[3]).strftime("%d-%b-%Y")==@@date_count.strftime("%d-%b-%Y")}/>" 
                      @@date_count+=86400
                 elsif @delivery_date.strftime("%Y-%m-%d")==@@date_count.strftime("%Y-%m-%d")
                       @@strXML+= "<set name='#{@@date_count.strftime("%d-%b-%Y")}' value='#{args[0]==nil ? 0 : args[0].to_s}' #{@anchor_color if args[2].to_i==0 and Time.parse(args[3]).strftime("%d-%b-%Y")==@@date_count.strftime("%d-%b-%Y")}/>" 
                       @@date_count+=86400
                  end
            rescue Exception=>e
                  puts "ERROR :: in AdvertiserXmlBuilder Component and generate_linechartXML method.The Error is #{e.to_s}"
            end
        end  #generatelinechartXML ends here

#--------------------------------------------------------------------------------------------
  #Method Name: generate_piechartXML
  #Purpose: This method is used to construct xml structure for piechart.
  #Version: 1.0
  #Author:Dipti Uppal
  #Last Modified:
  #Notes: None.
#-------------------------------------------------------------------------------------------- 
  def generate_piechartXML(*args)
      begin
          @color_hash=Hash.new
          @color_hash={"0"=>"0C95BF","1"=>"12C400","2"=>"ECB800","3"=>"EB2300","4"=>"70808F","5"=>"000000","6"=>"800080","7"=>"FFFF00","8"=>"7FFFD4","9"=>"6600FF"}
          if @@flag == true
            @@strXML+= "<chart yAxisName='Impressions'  decimals='2' defaultAnimation='0' use3DLighting='0' showPlotBorder='0' plotGradientColor='' divLineColor ='FFFFFF'  baseFontSize ='12' numDivLines='2' alternateVGridColor='FFFFFF'  showBorder='0' showLabels='1' chartTopMargin='5' chartRightMargin ='30'  showValues='0' bgColor='FFFFFF' canvasBorderColor='FFFFFF' canvasBorderThickness='0' formatNumberScale='0'>"
            @@flag = false
         end
            colour=@color_hash["#{@@i}"]
            args[0]=(args[0]=='' || args[0]==nil) ? 'Unknown' : args[0]
            #~ url=(args[0]!='Others' && args[2]!='handset_model' ) ? "link='/admin_analytic/admin_handset_model%3Fmodel=#{args[0].to_s.gsub(/([&%])/) do|s| @@getsymbol["#{s}"] end}'" : "" 
            @@strXML+="<set label='#{args[0].to_s.gsub(/([&%])/) do|s| @@getsymbol["#{s}"] end}' value='#{args[1].to_s}' color='#{colour.to_s}'/>" 
            @@i+=1
      rescue Exception=>e
           puts "DEBUGGER :: ERROR :: in admin_traffic_xml_builder.rb - generate_piechartXML :: #{e.to_s}"
      end
    end
 
 #--------------------------------------------------------------------------------------------
  #Method Name: generate_piechartXML
  #Purpose: This method is used to construct xml structure for piechart.
  #Version: 1.0
  #Author:Md Shujauddeen
  #Last Modified:
  #Notes: None.
#-------------------------------------------------------------------------------------------- 
  def generate_ColumnXML(*args)
      begin
          if @@flag == true
            @@strXML+= "<chart yAxisName='Fill Rate'  decimals='2' defaultAnimation='0' use3DLighting='0' showPlotBorder='0' plotGradientColor='' divLineColor ='FFFFFF'  baseFontSize ='12' numDivLines='2' alternateVGridColor='FFFFFF'  showBorder='0' showLabels='1' chartTopMargin='5' chartRightMargin ='30'  showValues='0' bgColor='FFFFFF' canvasBorderColor='FFFFFF' canvasBorderThickness='0' formatNumberScale='0'>"
            @@flag = false
         end
            colour='0C95BF'
            args[0]=(args[0]=='' || args[0]==nil) ? 'Unknown' : args[0]
            @@strXML+="<set label='#{args[0].to_s.gsub(/([&%])/) do|s| @@getsymbol["#{s}"] end}' value='#{args[1].to_s}' color='#{colour.to_s}'/>" 
            @@i+=1
      rescue Exception=>e
           puts "DEBUGGER :: ERROR :: in admin_traffic_xml_builder.rb - generate_ColumnXML :: #{e.to_s}"
      end
    end

 
 
#--------------------------------------------------------------------------------------------
  #Method Name: generate_linechartXML
  #Purpose: This method is used to construct xml structure for linechart.
  #Version: 1.0
  #Author:Md Shujauddeen
  #Last Modified:
  #Notes: None.
#--------------------------------------------------------------------------------------------      
 def generate_linechartXML(*args)
  begin
     if @@flag==true
       @@strXML+= "<chart xAxisName='' yAxisName='Impressions' formatNumberScale='0' showNames='1' decimals='2' defaultAnimation='0' use3DLighting='0' showPlotBorder='0' plotGradientColor='' divLineColor ='FFFFFF'  baseFontSize ='12' yAxisName='Requests' alternateVGridColor='FFFFFF'  showBorder='0' showLabels='1' chartTopMargin='5' chartRightMargin ='15'  showValues='0' bgColor='FFFFFF' canvasBorderColor='FFFFFF' canvasBorderThickness='0'>"
       
       @@flag=false
     end
       @@strXML=@@strXML+  "<set name='#{args[0]}' value='#{args[1]}'/>"
   rescue Exception=>e
       puts "DEBUGGER :: ERROR :: in admin_traffic_xml_builder.rb - generate_linechartXML :: #{e.to_s}"
   end
end

#--------------------------------------------------------------------------------------------
  #Method Name: generate_multiLinechartXMLDate
  #Purpose: This method is used to construct xml structure for advertiser publisher registrations 
  #Version: 1.0
  #Author:Dipti Uppal
  #Last Modified: Md Shujauddeen
  #Notes: None.
#--------------------------------------------------------------------------------------------     
def generate_multiLinechartXMLDate(*args)
 begin
     if @@flag==true
      @@strXML+="<chart decimals='2' formatNumberScale='0'  connectNullData='1' lineDashGap='6' labelStep='1' numDivLines='3' alternateHGridColor='FFFFFF' divLineColor='F3F3F3'  numVDivLines='0'  showLabels='1' showValues='0' canvasBorderColor ='F2F2F2' canvasBorderAlpha='0' canvasBorderThickness='0' baseFontSize ='12' chartTopMargin='10' chartLeftMargin='1' chartRightMargin='35' decimalPrecision='0' bgColor='ffffff'    xAxisName='' yAxisName='Advertiser Vs Publisher' showNames='1' showBorder='0' lineThickness='4' ><categories>"
      @@flag=false
    end

    #Get the Date
  @@strXML = @@strXML+ "<category label= '#{args[0]}'/>"  
    
  rescue Exception=>e
     puts "DEBUGGER :: ERROR :: in admin_traffic_xml_builder.rb - generate_multiLinechartXMLDate :: #{e.to_s}"
  end
end


 #--------------------------------------------------------------------------------------------
  #Method Name: generate_multiLinechartXML
  #Purpose: This method is used to construct xml structure for advertiser publisher registrations
  #Version: 1.0
  #Author:Dipti Uppal
  #Last Modified: Md Shujauddeen
  #Notes: None.
#--------------------------------------------------------------------------------------------                 
def generate_multiLinechartXML(*args)
  begin
 
    # Get the Dataset for all the Admin. 
#    if args[1]=='Administrator' and @flagAdmin == true
#      @@strXML = @@strXML+ "</categories><dataset seriesName='Administrator' color='F1683C' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>" 
#      @@strXML = @@strXML+ "<set value='#{args[0]}'/>"
#      @flagAdmin = false
#    elsif  args[1]=='Administrator'  
#      @@strXML = @@strXML+ "<set value='#{args[0]}'/></dataset>"  
#    end
#    
    # Get the Dataset for all the Advertiser.   
    if args[1]=='Advertiser'and @flagAdv == true
      @@strXML = @@strXML+ "</categories><dataset valuePadding='1' seriesName='Advertiser' Color='0C95BF' anchorSides='10' anchorRadius='4' anchorBgColor='0C95BF' anchorBorderColor='FFFFFF' anchorBorderThickness='1'>" 
      
      @@strXML = @@strXML+ "<set value='#{args[0]}'/>"
      @flagAdv = false
    elsif   args[1]=='Advertiser'
      @@strXML = @@strXML+ "<set  value='#{args[0]}'/>"        
    end
    
    # Get the Dataset for all the Publisher. 
    if args[1]=='Publisher' and @flagPub == true
      @@strXML = @@strXML+ "</dataset><dataset seriesName='Publisher' Color='999999'  anchorSides='10' anchorRadius='4' anchorBgColor='999999' anchorBorderColor='FFFFFF' anchorBorderThickness='1'>"
      
      @@strXML = @@strXML+ "<set value='#{args[0]}'/>"
       @flagPub = false
    elsif  args[1]=='Publisher' 
      @@strXML = @@strXML+ "<set  value='#{args[0]}'/>"         
    end # Admin
 rescue Exception=>e
     puts "DEBUGGER :: ERROR :: in admin_traffic_xml_builder.rb - generate_mutil_linechartXML :: #{e.to_s}"
  end
 end 
 
 #--------------------------------------------------------------------------------------------
  #Method Name: generate_multiLinechartXMLTraffic
  #Purpose: This method is used to construct xml structure for advertiser publisher registrations
  #Version: 1.0
  #Author:Dipti Uppal
  #Last Modified:
  #Notes: None.
#--------------------------------------------------------------------------------------------    
def generate_multiLinechartXMLTraffic(*args)
  begin
    
    # Get the Dataset for all the Publisher. 
    if args[1]=='Publisher' and @flagPub == true
      @@strXML = @@strXML+ "</dataset><dataset seriesName='Publisher' color='2AD62A' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
      @@strXML = @@strXML+ "<set value='#{args[0]}'/>"
       @flagPub = false
    elsif  args[1]=='Publisher' 
      @@strXML = @@strXML+ "<set  value='#{args[0]}'/>"         
    end # Admin
 rescue Exception=>e
     puts "DEBUGGER :: ERROR :: in admin_traffic_xml_builder.rb - generate_multiLinechartXMLTraffic :: #{e.to_s}"
  end
 end # End of generate_multiLinechartXMLTraffic

 #--------------------------------------------------------------------------------------------
  #Method Name: generate_multiLinechartCampXML
  #Purpose: This method is used to construct xml structure for Campaign ads performance.
  #Version: 1.0
  #Author:Dipti Uppal
  #Last Modified:
  #Notes: None.
#--------------------------------------------------------------------------------------------    
 def generate_multiLinechartCampXML(*args)
  begin
  # Get the Dataset for all the Advertiser.   
    if args[0]=='Impressions' and @flagImpressions == true
      @@strXML = @@strXML+ "</categories><dataset seriesName='Advertiser' color='1D8BD1' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>" 
      @@strXML = @@strXML+ "<set value='#{args[1]}'/>"
      @flagImpressions = false
    elsif   args[0]=='Impressions'
      @@strXML = @@strXML+ "<set  value='#{args[1]}'/>"        
    end
    
    # Get the Dataset for all the Publisher. 
    if args[0]=='Clicks' and @flagClicks == true
      @@strXML = @@strXML+ "</dataset><dataset seriesName='Publisher' color='2AD62A' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
      @@strXML = @@strXML+ "<set value='#{args[1]}'/>"
       @flagClicks = false
    elsif  args[0]=='Clicks' 
      @@strXML = @@strXML+ "<set  value='#{args[1]}'/>"         
    end # Admin
 rescue Exception=>e
     puts "DEBUGGER :: ERROR :: in admin_traffic_xml_builder.rb - generate_multiLinechartCampXML :: #{e.to_s}"
  end
 end  # End of generate_multiLinechartCampXML
 
#--------------------------------------------------------------------------------------------
  #Method Name: generate_multiLinechartXMLContinent
  #Purpose: This method is used to construct xml structure for advertiser publisher registrations 
  #Version: 1.0
  #Author:Md Shujauddeen
  #Last Modified:
  #Notes: None.
#--------------------------------------------------------------------------------------------     
def generate_multiLinechartXMLContinent(*args)
 begin
    contName = args[0] 
    contColor = args[2]
    if @flag == true
      @@strXML = @@strXML+ "<dataset seriesName='#{contName}' color='#{contColor}' anchorBorderColor='1D8BD1' anchorBgColor='1D8BD1'>"
      @@strXML = @@strXML+ "<set value='#{args[1]}'/>"
       @flag = false
    else  
      @@strXML = @@strXML+ "<set  value='#{args[1]}'/>"         
    end 
  rescue Exception=>e
     puts "DEBUGGER :: ERROR :: in admin_traffic_xml_builder.rb - generate_multiLinechartXMLContinent :: #{e.to_s}"
  end
end 
 
 
 #--------------------------------------------------------------------------------------------
  #Method Name: generate_multiLinechartXMLContinent
  #Purpose: This method is used to construct xml structure for advertiser publisher registrations 
  #Version: 1.0
  #Author:Md Shujauddeen
  #Last Modified:
  #Notes: None.
#--------------------------------------------------------------------------------------------     
 def generate_continentXML(*args)
       begin
          #following hashes are used to get the country code number using country code
           oceania={"AU"=>"001","FJ"=>"002","KI"=>"003","MH"=>"004","FM"=>"005","NR"=>"006","NZ"=>"007","PW"=>"008","PG"=>"009","WS"=>"010","SB"=>"011","TO"=>"012","TV"=>"013","VU"=>"014","NC"=>"015"}
           africa={"DZ"=>"001","AO"=>"002","BJ"=>"003","BW"=>"004","BF"=>"005","BI"=>"006","CM"=>"007","CV"=>"008","CF"=>"009","TD"=>"010","KM"=>"011","CI"=>"012","CD"=>"013","DJ"=>"014","EG"=>"015","GQ"=>"016","ER"=>"017","ET"=>"018","GA"=>"019","GH"=>"020","GN"=>"021","GW"=>"022","KE"=>"023","LS"=>"024","LR"=>"025","LY"=>"026","MG"=>"027","MW"=>"028","ML"=>"029","MR"=>"030","MA"=>"032","MZ"=>"033","NA"=>"034","NE"=>"035","NG"=>"036","RW"=>"038","ST"=>"040","SN"=>"041","SY"=>"042","SL"=>"043","SO"=>"44","ZA"=>"045","SD"=>"046","SZ"=>"047","TZ"=>"048","TG"=>"049","TN"=>"015","UG"=>"052","WS"=>"053","ZM"=>"054","ZW"=>"055","GM"=>"056","CG"=>"057","MU"=>"058"}
           asia={"AF"=>"001","AM"=>"002","AZ"=>"003","BD"=>"005","BT"=>"006","BN"=>"007","MM"=>"008","KH"=>"009","CN"=>"010","TP"=>"012","GE"=>"013","IN"=>"014","ID"=>"015","IR"=>"016","JP"=>"019","KZ"=>"021","KP"=>"022","KR"=>"023","LA"=>"026","MY"=>"028","MN"=>"030","NP"=>"031","PK"=>"033","PH"=>"034","RU"=>"036","SG"=>"038","LK"=>"039","TH"=>"042","TM"=>"044","UZ"=>"046","VN"=>"047","TW"=>"049","HK"=>"050","MO"=>"051"}
           europe={"AL"=>"001","AD"=>"002","AT"=>"003","BY"=>"004","BE"=>"005","BA"=>"006","BG"=>"007","HY"=>"008","CZ"=>"009","DK"=>"010","EE"=>"011","FI"=>"012","FR"=>"013","DE"=>"014","GR"=>"015","HU"=>"016","IS"=>"017","IE"=>"018","IT"=>"019","LV"=>"020","LI"=>"021","LT"=>"022","LU"=>"023","MK"=>"024","MT"=>"025","MD"=>"026","MC"=>"027","ME"=>"028","NL"=>"029","NO"=>"030","PL"=>"031","PT"=>"032","RO"=>"033","SM"=>"034","CS"=>"035","SK"=>"036","SI"=>"037","ES"=>"038","SE"=>"039","CH"=>"040","UA"=>"041","GB"=>"042","VA"=>"043","CY"=>"044","TR"=>"045","RU"=>"046","UK"=>"042"}
           south_america={"AR"=>"001","BO"=>"002","BR"=>"003","CL"=>"004","CO"=>"005","EC"=>"006","FK"=>"007","GF"=>"008","GY"=>"009","PY"=>"010","PE"=>"011","SR"=>"012","UY"=>"013","VE"=>"014"}
           north_america={"AG"=>"001","BS"=>"002","BB"=>"003","BZ"=>"004","CA"=>"005","CR"=>"006","CU"=>"007","DM"=>"008","DO"=>"009","SV"=>"010","GD"=>"011","GT"=>"012","HT"=>"013","HN"=>"014","JM"=>"015","MX"=>"016","NI"=>"017","PA"=>"018","KN"=>"019","LC"=>"020","VC"=>"021","TT"=>"022","US"=>"023","GL"=>"024","PR"=>"025","KY"=>"026"}
           central_america={"BZ"=>"01","CR"=>"02","SV"=>"03","GT"=>"04","HN"=>"05","NI"=>"06","PM"=>"07"}
           middle_east={"AF"=>"01","BH"=>"02","IR"=>"03","IQ"=>"04","IL"=>"05","JO"=>"06","KW"=>"07","KG"=>"08","LB"=>"09","OM"=>"10","PK"=>"11","QA"=>"12","SA"=>"13","SY"=>"14","TI"=>"15","TU"=>"16","TX"=>"17","AE"=>"18","UZ"=>"19","YE"=>"20"}
           
            if @@flag==true
              @@strXML="<map defaultAnimation='0' numberSuffix='%25' useSNameInLabels='1' decimals='2' showShadow='0' showBevel='0' hoverColor='01B401' formatNumberScale='0' showCanvasBorder='0' fillColor='FFFFFF' leftMargin='5'><data>"
              @@flag=false
              @@date_count=args[1].to_i
            end
                if @@date_count<args[1].to_i
                  @@date_count=args[1].to_i
                end
                args[2]=args[2]=='CB' ? 'NA' : args[2]
              if args[2]=='NA'
                 ccode=north_america["#{args[0]}"]
              elsif args[2]=='SA'
                 ccode=south_america["#{args[0]}"]
              elsif args[2]=='AS'
                 ccode=asia["#{args[0]}"]
              elsif args[2]=='AF'
                 ccode=africa["#{args[0]}"]
              elsif args[2]=='OC'
                 ccode=oceania["#{args[0]}"]
              elsif args[2]=='EU'
                 ccode=europe["#{args[0]}"]
              elsif args[2]=='ME'
                ccode=middle_east["#{args[0]}"]
              elsif args[2]=='CA'
                ccode=central_america["#{args[0]}"]
              end
             
              @@strXML+="<entity id='#{ccode.to_s}' value='#{args[1].to_s}' />" if args[1].to_i > 0
      rescue Exception=>e
            puts "ERROR :: in AdminTrafficXmlBuilder Component :: generate_continentXML method :: #{e.to_s}"
      end
  end # generate continent xml method ends here
 
end #Class ends here
 
