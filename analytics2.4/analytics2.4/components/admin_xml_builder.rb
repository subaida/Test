#/*
# * AdminReportGenerator.rb
# *
# * Author :Sathish Kuamr Sadhasivam
# * Version: 1.0
# * Created: 22-Aug-2008
# * Last Modified: 13-Oct-2008
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
# * Note: This component for building the sql queries and generating the xml codes accoring to the input.
# *           
# */
##

require 'active_record'
require 'AnalyticsDBConnection'
# Active Record connection for the AdvertiserXmlBuilder component to connect with ZestADZ Analytics DB.
ActiveRecord::Base.establish_connection(  
:adapter => "mysql",  
:host => HOSTNAME,  
:database => DATABASE,
:username => USERNAME,
:password => PASSWORD
)

# Active Record models connection for the AdvertiserXmlBuilder component.
class Ad < ActiveRecord::Base  
end
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

@@hour_count= 0
@@strXML=''
@@multi_strXML=''
@@cat_strXML=''
#~ @@date_count=0
@@color_count=0
@@mod=0
#~ @@xml_count=0
@@flag=true
@@xml_hash=Hash.new

  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#Method Name: AdvertiserXmlBuilder	
	#Purpose: To generate the xml code. 
	#Version: 1.0
	#Author: Sathish Kumar Sadhasivam
	#Last Modified: 13-Oct-2008 by Sathish Kumar Sadhasivam
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  
class AdminXmlBuilder
    begin
    # This hash is user to get value of day in string  format
        # This hash is used to get the value of month in english
        @@getsymbol={"&"=>"%26","%"=>"%25"}
        @@monthtoenglish={"1"=>"Jan","01"=>"Jan","2"=>"Feb","02"=>"Feb","3"=>"Mar","03"=>"Mar","4"=>"Apr","04"=>"Apr","5"=>"May","05"=>"May","6"=>"June","06"=>"June","7"=>"July","07"=>"July","8"=>"Aug","08"=>"Aug","9"=>"Sep","09"=>"Sep","10"=>"Oct","11"=>"Nov","12"=>"Dec"}
        # This method is used to get the exact number of days in a month, ex: it gives 29 days as output for the february month in a leap year
        def daysinmonth(year, month)
          return (Date.new(year, 12, 31) << (12-month)).day
        end
              
        #This method is used to construct query based on the parameter receives from the controller.
        def generate_query(*args) #generate_query starts here
           begin
                @tablename=args[0].split('-')[0]
                @duration=args[0].split('-')[1]
                @report_type=args[1] 
                 @column1=args[2]
                @column2=args[3]
                @startdate=args[4]
                @enddate=args[5]
                @order=args[6]
              @limit=args[7]
                @column3=args[8]
                @page=(args[9]!=nil) ? args[9] : 0
                #~ @start_year= Time.parse(@startdate).strftime("%Y-%m-%d").split('-')[0] if @startdate!=nil #selects only year
                #~ @start_day=Time.parse(@startdate).strftime("%Y-%m-%d").split('-')[2] if @startdate!=nil#selects only day
                #~ @start_month=Time.parse(@startdate).strftime("%Y-%m-%d").split('-')[1] if @startdate!=nil
                #~ @end_year=Time.parse(@enddate).strftime("%Y-%m-%d").split('-')[0] if @enddate!=nil
                #~ @end_month=Time.parse(@enddate).strftime("%Y-%m-%d").split('-')[1] if @enddate!=nil
                 #~ @end_day=Time.parse(@enddate).strftime("%Y-%m-%d").split('-')[2] if @enddate!=nil
                #~ @ctr="((sum(clicks)/sum(impressions))*100)"#if @report_type!="Overall_Performance"
                #~ @ecpm='((sum(revenue)/sum(impressions))*1000)'
                #~ customize_column= @column3=='campaign_name' ? 'c.campaign_name' : @column3=='pub_name' ? 'p.publisher_name' : @column3=='advertiser_name' ? 'a.name' : ''
                #~ customize_table=@column3=='campaign_name' ? 'campaigns_summaries cs, campaigns c' : @column3=='pub_name' ? 'adclients_summaries ad,publishers p' : @column3=='advertiser_name' ? 'campaigns_summaries cs,advertisers a' : ''
                #~ customize_condition=@column3=='campaign_name' ? 'c.id=cs.campaign_id' : @column3=='pub_name' ? 'p.id=ad.pub_id' : @column3=='advertiser_name' ? 'a.id=cs.advertiser_id' : ''
                #~ customize_filter=@column3=='campaign_name' ? 'and (cs.impressions>0 or cs.clicks>0)' : @column3=='pub_name' ? 'and (ad.impressions>0 or ad.clicks>0)' : @column3=='advertiser_name' ? 'and (cs.impressions>0 or cs.clicks>0)' : ''
            #~ begin
                  #~ # ---- Query Builder ----
                  #~ sub_query="select count(*) as count from #{@tablename}"
                  #~ sub_query+=" where delivery_date>='#{(Time.parse(@startdate)).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(@enddate)).strftime("%Y-%m-%d")} 23:59:59'" 
                  #~ #sub_query+="and #{@column1}!='ip' and #{@column1}!=''"
                  #~ obj=@column3=='pub_name' ? 'ad.' :'cs.' 
                  #~ sql_query ="select #{customize_column} as #{@column3} , (#{(@column2=='ctr') ? @ctr : @column2=='ecpm' ? @ecpm : "sum(#{obj}#{@column2})"}) as #{@column2=='amount_spent' ? 'amt_spent' :@column2} from #{customize_table}"  
                  #~ sql_query+=" where delivery_date>='#{(Time.parse(@startdate)).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(@enddate)).strftime("%Y-%m-%d")} 23:59:59' and #{customize_condition} #{customize_filter}" 
                  #~ sql_query+=" group by #{@column1} order by #{@column2=='amount_spent' ? 'amt_spent' :@column2} #{@order} limit #{@limit} offset #{@page}"  if @report_type!="Overall_Performance"
                  #~ sql_query+=" group by #{@column1} order by #{@column2=='amount_spent' ? 'amt_spent' :@column2} #{@order} "  if @report_type=="Overall_Performance"
                  #~ #following code is used to calculate modulas value if applicable
                  #~ @add_month=0
                  #~ @no_day=(@end_day.to_i-@start_day.to_i)+1
                  #~ if @end_year.to_i!=@start_year.to_i
                      #~ @add_month=@end_month.to_i+12
                      #~ @add_month=@add_month.to_i-@start_month.to_i
                    #~ @no_day+=(@add_month*30)
                  #~ elsif @end_month.to_i>@start_month.to_i
                      #~ @add_month=@end_month.to_i-@start_month.to_i
                      #~ @no_day+=(@add_month*30)
                  #~ end
                  #~ @modulas=@no_day/30
                  #~ @XML_xaxis='days'
                  #~ @@date_count=Time.parse(@startdate)
              #~ rescue Exception=>e
                #~ puts "DEBUGGER :: Error:: in admin_xml_builder.rb - generate_query ::#{e.to_s}"
              #~ end
              @XML_xaxis='days'
              begin
             #~ @tablename=AdminCampaignWiseReport.show_data() #convert the string into model name
                  #~ @tablename=@tablename.classify.constantize  #convert the string into model name
                  #~ @recordset=@tablename.find_by_sql(sql_query) # fetch the recordset from table
                  @recordset=AdminCampaignWiseReport.top_campaigns_performance(@order,@startdate,@enddate) # fetch the recordset from table
              rescue Exception=>e
                  puts "DEBUGGER :: ERROR :: in admin_xml_builder.rb - generate_query :: #{e.to_s}"
              end
              @anchor_color="anchorBgColor='FF0000'"
              count=0
              othersValue=0.00
              if @recordset.size !=0  #main If conditons starts here
                  for recordset in @recordset 
                      #Check whether publisher request click or impression or revenuereport
                      i=1
                      if args[3]!='imp vs clicks'
                        #~ puts "-------------check 1---------"
                          #~ generate_mutil_linechartXML(recordset.impressions,recordset.clicks,recordset.delivery_date,@startdate,@enddate,'Impression Vs Clicks',@no_day,@duration) 
                      #~ else
                          count+=1
                          if (count.to_i<=@limit.to_i)
                             #~ puts "-------------check 2----#{@report_type}-----"
                              generate_piechartXML(recordset[@column3],recordset[@column2]) 
                          else
                              othersValue+=recordset[@column2].to_f
                              if (@recordset.size.to_i==count.to_i)
                              generate_piechartXML('Others',othersValue)
                              end
                            end
                            i+=1
                     end
                  end #for loop ends here

                  #to insert xml datas for which recordset are not available
                  #~ if @report_type=='admin_campaign_wise_reports' and args[3].to_s!='imp vs clicks'
                    #~ puts "-------------check 3---------"
                      #~ if Time.parse(@enddate)>@@date_count
                          #~ while Time.parse(@enddate)>=@@date_count
                              #~ delivery_day=@@date_count.strftime("%Y-%m-%d").split('-')[2] #will return day
                              #~ if Time.parse(@enddate)==@@date_count
                                  #~ @@strXML+= "<set name='#{@@date_count.strftime("%d-%b-%Y")}' value='0' #{@anchor_color if @duration.to_i==1}/>" 
                              #~ elsif delivery_day.to_i%@modulas==0 
                       #~ @@strXML+= "<set name='#{@@date_count.strftime("%d-%b-%Y")}' value='0'/>"
                              #~ end
                              #~ @@date_count+=86400
                          #~ end
                      #~ elsif Time.parse(@enddate)==@@date_count
                          #~ @@strXML+= "<set name='#{@@date_count.strftime("%d-%b-%Y")}' value='0' #{@anchor_color if @duration.to_i==1}/>" 
                      #~ end
                  #~ @@strXML+="<styles><definition><style name='myLabelsFont' type='font' font='Arial' size='12' color='000000' bold='1'/></definition><application><apply toObject='DataLabels' styles='myLabelsFont' /></application></styles>"
                  #~ #to insert xml datas for impression vs click if recordsets are not available for specified date
                  #~ elsif @report_type=='admin_campaign_wise_reports' && args[3].to_s=='imp vs clicks'
                     #~ puts "-------------check 1-1--------"
                      #~ if Time.parse(@enddate)>@@date_count
                          #~ while Time.parse(@enddate)>=@@date_count
                              #~ delivery_day=@@date_count.strftime("%Y-%m-%d").split('-')[2] #will return day
                              #~ if Time.parse(@enddate)==@@date_count 
                                  #~ @@strXML+= "<set value='0' #{@anchor_color if @duration.to_i==1}/>"
                                  #~ @@cat_strXML+="<category label='#{@@date_count.strftime("%d-%b-%Y")}'/>"
                                  #~ @@multi_strXML+="<set value='0' #{@anchor_color if @duration.to_i==1}/>"
                              #~ elsif delivery_day.to_i%@modulas==0
                    #~ @@strXML+= "<set value='0'/>"
                                  #~ @@cat_strXML+="<category label='#{@@date_count.strftime("%d-%b-%Y")}'/>"
                                  #~ @@multi_strXML+="<set value='0'/>"
                              #~ end
                              #~ @@date_count+=86400
                          #~ end
                      #~ elsif Time.parse(@enddate)==@@date_count
                         #~ puts "-------------check 1--2-------"
                          #~ @@strXML+= "<set value='0'/ #{@anchor_color if @duration.to_i==1}>"
                          #~ @@cat_strXML+="<category label='#{@@date_count.strftime("%d-%b-%Y")}'/>"
                          #~ @@multi_strXML+="<set value='0'/ #{@anchor_color if @duration.to_i==1}>"
                      #~ end
                      #~ @@multi_strXML+="</dataset>"
                      #~ @@cat_strXML+="</categories>"
                      #~ @@strXML+="</dataset>"
                      #~ @@strXML+=@@cat_strXML
                      #~ @@strXML+=@@multi_strXML
                   #~ p   @@strXML+="<styles><definition><style name='myLabelsFont' type='font' font='Arial' size='12' color='000000' bold='1'/></definition><application><apply toObject='DataLabels' styles='myLabelsFont' /></application></styles>"
                  #~ end
                #~ if @report_type=='Traffic'
                    #~ @@strXML+="</data>"
                    #~ @@strXML+="<colorRange><color minValue='0' maxValue='#{(@@date_count-1).to_s}' displayValue='Low' color='F0FFE8' /><color minValue='#{(@@date_count.to_i-1).to_s}' maxValue='#{(@@date_count.to_i+1).to_s}' displayValue='High' color='009900' /></colorRange></map>"
                #~ end
                #~ if @report_type=='Ad_Wise' and args[5]=='imp vs clicks'
                   #~ puts "-------------check 12---------"
                   #~ @@multi_strXML+="</dataset>"
                   #~ @@cat_strXML+="</categories>"
                   #~ @@strXML+="</dataset>"
                   #~ @@strXML+=@@cat_strXML
                   #~ @@strXML+=@@multi_strXML
                   #~ @@strXML+="<styles><definition><style name='myLabelsFont' type='font' font='Arial' size='12' color='000000' bold='1'/></definition><application><apply toObject='DataLabels' styles='myLabelsFont' /></application></styles>"
                #~ end
                #~ if @report_type=='Traffic_Continent'
                   #~ puts "-------------check 14---------"
                  #~ @@strXML+='</data>'
                  #~ @@strXML+="<colorRange><color minValue='0' maxValue='#{(@@date_count-1).to_s}' displayValue='Low' color='F0FFE8' /><color minValue='#{(@@date_count.to_i-1).to_s}' maxValue='#{(@@date_count.to_i+1).to_s}' displayValue='High' color='009900' /></colorRange></map>"
                #~ end
                #~ if @report_type=='Keyword'
                   #~ puts "-------------check 1-6--------"
                  #~ @@strXML+="<styles><definition><style name='myValuesFont' type='font' size='16' color='000000' bold='1' font='Arial, Helvetica, sans-serif' /></definition><application><apply toObject='DataLabels'  styles='myValuesFont' /></application></styles>"
                #~ end
                  @@strXML = @@strXML + "</chart>" 
            end #main If ends here
            #reinitialize flag, str variable and counters to construct next chart
            @@flag=true   
            #~ @@xml_count=0
            #~ @@date_count=0
            @@color_count=0 
            @@mod=0
           @returnstrXML=@@strXML
            @@strXML=''  
            @@cat_strXML=''
            @@multi_strXML=''
            @@xml_hash=nil
            @@xml_hash={:xml_string=>@returnstrXML }
            return @@xml_hash
          rescue Exception=>e
             puts "DEBUGGER :: ERROR :: in admin_xml_builder under generate_query method. The error is #{e.to_s}"
          end
        end # generate_query ends here
        #this method is used to construct xml structure based on the recordset retrived from the database
        
        #this method is used to construct xml structure for piechart
        def generate_piechartXML(*args)
            begin
              @color_hash=Hash.new
              @color_hash={"0"=>"0C95BF","1"=>"12C400","2"=>"ECB800","3"=>"EB2300","4"=>"70808F","5"=>"000000","6"=>"800080","7"=>"FFFF00","8"=>"7FFFD4","9"=>"0377CA","10"=>"15C2F7"}
              if @@flag==true
                  #~ @@strXML = "<chart decimals='2' defaultAnimation='0'  use3DLighting='0' showPlotBorder='1' showShadow='0' plotGradientColor='0' showLabels='1' chartTopMargin='0' chartLeftMargin='0' chartRightMargin='0' chartBottomMargin='0' showValues='0'   baseFontSize='12' isSliced='1' enableSmartLabels='1'  bgColor='FFFFFF' showBorder='0' plotBorderThickness='0'  startingAngle='80' canvasBorderColor ='cccccc' canvasBorderAlpha='0' canvasBorderThickness='0' showPercentageValues='1' pieRadious='100'>" if args[2]=='Device_Summary' or args[2]=="Carrier_Traffic"   
                  puts "hello"
                 p @@strXML = "<chart decimals='2' defaultAnimation='0'  use3DLighting='0' showPlotBorder='1' showShadow='0' plotGradientColor='0' showLabels='1' chartTopMargin='0' chartLeftMargin='0' chartRightMargin='0' chartBottomMargin='0' showValues='0'   baseFontSize='12' isSliced='1' enableSmartLabels='1'  bgColor='FFFFFF' showBorder='0' plotBorderThickness='0'  startingAngle='80' canvasBorderColor ='cccccc' canvasBorderAlpha='0' canvasBorderThickness='0' showPercentageValues='1' pieRadious='100'>" 
                  #~ @@strXML = "<chart decimals='2' yAxisName='#{args[3].to_s=='ecpm' ? 'eCPM' : (args[3].to_s).upcase}'  divLineColor='CCCCCC' numDivLines='2' alternateHGridColor='FFFFFF' anchorBorderColor='FFFFFF' defaultAnimation='0' use3DLighting='0' alternateVGridColor='FFFFFF' showPlotBorder='0' showShadow='0' plotGradientColor='' showLabels='1' chartTopMargin='10' chartLeftMargin='0' chartRightMargin='0' chartBottomMargin='10' showValues='0' canvasBorderColor ='FFFFFF' formatNumberScale='0' canvasBorderAlpha='0' canvasBorderThickness='0' pieRadious='100'  baseFontSize='12' showBorder='0' plotBorderThickness='0'   bgColor='FFFFFF'  showPercentageValues='1' > " if args[3]=='ctr' || args[3]=='ecpm'
                  @@flag=false
                end
              colour=@color_hash["#{@@color_count}"]
              limit = (args[3]=='ctr' || args[3]=='ecpm') ? 10 : 15
              args[0]=(args[0]=='' || args[0]==nil) ? 'could not detect' : args[0]
              puts "---------------------34----------"
            p  @@strXML=@@strXML+ "<set label='#{args[0]!=nil ? (truncate(args[0].split("'")[0].to_s,limit)).gsub(/([&%])/) do|s| @@getsymbol["#{s}"] end : 'NA' }' value='#{args[1].to_s}' color='#{(args[0].to_s=='Others') ? '000000' : colour.to_s}' />" if args[3]!='ctr' and args[2]!='URL' and args[3]!='ecpm'
            puts "---------------------35----------"
              #~ @@strXML+="<set label='#{args[0].to_s.gsub(/([&%])/) do|s| @@getsymbol["#{s}"] end}' value='#{args[1].to_s}'  color='176D94'/>" if args[3]=='ctr' || args[3]=='ecpm'
              @@color_count+=1
            rescue Exception=>e
              puts "DEBUGGER :: ERROR :: in AdminXmlBuilder Component under generate_piechartXML method. The Error is #{e.to_s}"
            end
        end
        
        
          
        def truncate(*args)
              begin
              i=args[0]
              limit=args[1].to_i
                    if i.split("").size > limit
                        k=0
                        s=''
                        for j in i.split("")
                        if k.to_i<limit
                            s=s+j
                        end
                        k+=1
                        end
                        return s=s+'..'
                    else
                        return i
                    end
              rescue Exception=>e
                    puts "DEBUG :: ERROR :: AdminXMLBuilder Component > truncate . Exception is #{e.to_s}"
                    return i
              end
        end
          
    rescue Exception=>e
        puts "ERROR :: in ReportGenerator Component and the error is :: #{e.to_s}"
    end
end   #class ends here
