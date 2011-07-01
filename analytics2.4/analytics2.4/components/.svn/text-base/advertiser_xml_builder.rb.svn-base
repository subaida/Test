#/*
# * AdvReportGenerator.rb
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
require 'aes_security.rb'
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
class AdvCarrier < ActiveRecord::Base  
end
class CampaignsSummary < ActiveRecord::Base  
end
class Ad < ActiveRecord::Base  
end
class AdvDevicesproperty < ActiveRecord::Base  
end
class AdvGeolocation < ActiveRecord::Base  
end
class AdvHandset < ActiveRecord::Base  
end
@@hour_count= 0
@@strXML=''
@@multi_strXML=''
@@cat_strXML=''
@@XML_array=Array.new
@@date_count=0
@@color_count=0
@@mod=0
@@xml_count=0
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
  
class AdvertiserXmlBuilder
    begin
    # This hash is user to get value of day in string  format
        # This hash is used to get the value of month in english
        @@monthtoenglish={"1"=>"Jan","01"=>"Jan","2"=>"Feb","02"=>"Feb","3"=>"Mar","03"=>"Mar","4"=>"Apr","04"=>"Apr","5"=>"May","05"=>"May","6"=>"June","06"=>"June","7"=>"July","07"=>"July","8"=>"Aug","08"=>"Aug","9"=>"Sep","09"=>"Sep","10"=>"Oct","11"=>"Nov","12"=>"Dec"}
        @@getsymbol={"&"=>"%26","%"=>"%25","'"=>""}
        # This method is used to get the exact number of days in a month, ex: it gives 29 days as output for the february month in a leap year
        def daysinmonth(year, month)
            return (Date.new(year, 12, 31) << (12-month)).day
        end
              
        #This method is used to construct query based on the parameter receives from the controller.
        def generate_query(*args) #generate_query starts here
           begin
              @@XML_array=Array.new
              @campaignid=args[0]
              @ad_id=args[1]
              advertiserId=args[2].split('-')[0]
              @tablename=args[2].split('-')[1]
              @duration=args[2].split('-')[2]
              @smartLabel=args[2].split('-')[3]
              @report_type=args[3]
              @column1=args[4]
              @column2=args[5]
              @startdate=args[6] 
              @enddate=args[7]
              @startdate= (@duration=='0' and @report_type=='Campaigns_Summary' ) ? (Time.now - 2592000).to_s : (@duration=='1' and @report_type=='Campaigns_Summary' ) ? (Time.now - 2678400).to_s : (((Time.parse(@startdate))==(Time.parse(@enddate))) && @report_type=='Campaigns_Summary') ? (((Time.parse(@enddate))-2592000).to_s) : args[6]
              @column3=""
              @adid= @ad_id=="All" ? "" : " and ad_id=#{@ad_id} "
              campaignId=@campaignid=="SMS" || @campaignid=="WAP" ? "" : " and campaign_id=#{@campaignid}"
              cs_camp_id=@campaignid=="SMS" || @campaignid=="WAP" ? "" : " and cs.campaign_id=#{@campaignid}"
              ad_type=(@campaignid=="SMS" || @campaignid=="WAP" ) ? true : false
              if @column2=='ctr'
                  @ctr="((sum(clicks)/sum(impressions))*100)"
              elsif @column2=='amount_spent'
                  @column2=@column1
                  @column3='amount_spent'
              end
              if @column2=='imp vs clicks' and @report_type!='Device_Summary'
                  @column2='impressions'
                  @column3='clicks'
              elsif @report_type=='Device_Summary' or @report_type=='Carrier_Traffic' or @report_type=='Traffic' or @report_type=='Traffic_Continent' or @report_type=='Owner_Traffic' or  @report_type=='Model_Summary'
                  @column2=args[8]
                  @column3=args[9]
                  @column4=args[10] if args[10]
                  @@user=args[11] if args[11]
              end
              @start_year= Time.parse(@startdate).strftime("%Y-%m-%d").split('-')[0] #selects only year
              @start_day=Time.parse(@startdate).strftime("%Y-%m-%d").split('-')[2] #selects only day
              @start_month=Time.parse(@startdate).strftime("%Y-%m-%d").split('-')[1]
              @end_year=Time.parse(@enddate).strftime("%Y-%m-%d").split('-')[0]
              @end_month=Time.parse(@enddate).strftime("%Y-%m-%d").split('-')[1]
              @end_day=Time.parse(@enddate).strftime("%Y-%m-%d").split('-')[2]
              begin
                  # ---- Query Builder ----
                  filter_column=(@tablename=='campaigns_summaries' || @tablename=='campaigns_summaries' || @tablename=='adv_geolocations' || @tablename=='adv_handsets') ? @column2=='unique_visitors' ? "and unique_visitors>0" : @report_type=='Campaigns_Summary' ? "and (impressions>0 or clicks>0)" : "and impressions>0"  : "and requests>0"
                  continent_traffic="if(continent_code='CB','NA',continent_code) as continent"
                  continent_code=args[11].to_s=='NA' ? "'NA' or continent_code='CB'" : "'#{args[11]}'" if @report_type=='Traffic_Continent'
                  sql_query ="select #{@column1} ,(#{(@column2=='ctr')? @ctr : "sum(#{@column2})"}) as #{@column2} from #{@report_type=='Ad_Wise' ? 'campaigns_summaries cs,ads a' : @tablename} where" if @column3=="" and @report_type!='DeviceProperties_Traffic' and @report_type!='Traffic' and @report_type!='Traffic_Continent'
                  sql_query ="select #{@column2=='continent_code' ? continent_traffic : @column2} , sum(#{@column3}) as #{@column3} from #{@tablename} where " if @column3!="" and @report_type!='DeviceProperties_Traffic' and @report_type!='Carrier_Traffic'
                  sql_query ="select #{@column1} , sum(#{@column2}) as #{@column2}, sum(#{@column3}) as #{@column3} from #{@tablename} where " if @column3!="" and @report_type=='Campaigns_Summary' or @column2=='imp vs clicks' and @report_type!='Traffic'  and @report_type!='Traffic_Continent' and @column3!="amount_spent"  and @report_type!='Ad_Wise'
                  sql_query="select carriers as #{@column2} , sum(requests)  as #{@column3} from #{@tablename} where" if @report_type=='Carrier_Traffic'
                  #~ sql_query="select carriers as #{@column2} , sum(requests)  as #{@column3} from adv_carrier where" if @report_type=='Owner_Traffic'
                  sql_query+=" (#{@column4}=#{continent_code}) and " if @report_type=='Traffic_Continent'
                  sql_query+=" advertiser_id=#{advertiserId} #{campaignId} #{@adid}" if  @report_type!='DeviceProperties_Traffic' and @report_type!='Ad_Wise'
                  sql_query="select properties as property_name, sum(requests) as property_count from #{@tablename} where advertiser_id=#{advertiserId} #{campaignId} #{@adid}" if @report_type=='DeviceProperties_Traffic'
                  sql_query+=" cs.advertiser_id=#{advertiserId} #{cs_camp_id} and a.id=cs.ad_id  #{@adid}" if @report_type=='Ad_Wise'
                  sql_query+=" and delivery_date>='#{(Time.parse(@startdate)).strftime("%Y-%m-%d")}' and delivery_date<='#{(Time.parse(@enddate)).strftime("%Y-%m-%d")}'"
                  sql_query+=" #{filter_column}  group by property_name order by property_count desc limit 5" if @report_type=='DeviceProperties_Traffic'
                  #sql_query+=" and carr.owner=own.carrier" if @report_type=='Carrier_Traffic' or @report_type=='Owner_Traffic'
                  #sql_query+=" and own.operator='#{@column4}'" if @report_type=='Owner_Traffic'
                  sql_query+=" and ad_client_type='#{@campaignid}'"  if (@tablename=='campaigns_summaries' || @tablename=='campaigns_summaries') and ad_type==true
                  sql_query+=" #{filter_column}" if @report_type!='DeviceProperties_Traffic'
                  #sql_query+=" and handset='#{@column4}'" if @report_type=='Model_Summary'
                  sql_query+=" group by ad_id order by #{@column2} desc #{@smartLabel.to_i!=1 ? 'limit 5' : 'limit 10'}" if @report_type=='Ad_Wise'
                  sql_query+=" group by delivery_hour" if @tablename=='campaigns_summaries'and @report_type=='hourly_report'
                  sql_query+=" group by #{@column2} order by #{@column3} desc #{@smartLabel.to_i!=1 ? 'limit 5' : ''}" if @column3!="" and args[10]!='no limit' and @report_type!='DeviceProperties_Traffic' and @report_type!='Ad_Wise' and @report_type!='Campaigns_Summary' and @report_type!='Traffic' and @report_type!='Traffic_Continent'
                  sql_query+=" group by #{@column2=='continent_code' ? 'continent' : @column2} order by #{@column3} desc " if @column3!="" and args[10]!='no limit' and (@report_type=='Traffic' || @report_type=='Traffic_Continent')
                  if @report_type=='Campaigns_Summary'
                      #following code is used to calculate modulas value if applicable
                      @add_month=0
                      @no_day=(@end_day.to_i-@start_day.to_i)+1
                      if @end_year.to_i!=@start_year.to_i
                          @add_month=@end_month.to_i+12
                          @add_month=@add_month.to_i-@start_month.to_i
                          @no_day+=(@add_month*30)
                      elsif @end_month.to_i>@start_month.to_i
                          @add_month=@end_month.to_i-@start_month.to_i
                          @no_day+=(@add_month*30)
                      end
                      @modulas=@no_day/30>0 ? @no_day/30 : 1
                      sql_query+=" and if(((delivery_date='#{@start_year}-#{@start_month}-#{@start_day}')||(delivery_date='#{@end_year.to_i}-#{@end_month.to_i}-#{@end_day.to_i}')),delivery_date,Day(delivery_date)%#{@modulas}=0)" if @modulas.to_i>1
                      sql_query+=" group by delivery_date order by null"  
                      @@date_count=Time.parse(@startdate)
                  end
              rescue Exception=>e
                puts "Error:: in advertiser_xml_builder under query generator and the exception is:#{e.to_s}"
              end
              begin
                @tablename=@tablename.classify.constantize  #convert the string into model name
                @recordset=@tablename.find_by_sql(sql_query) # fetch the recordset from table
              rescue Exception=>e
              puts "DEBUGGER :: ERROR :: in advertiser report_generator.rb - generate query :: #{e.to_s}"
              end
              @@XML_array.clear
              @anchor_color="anchorBgColor='FF0000'"
              if @recordset.size !=0  #main If conditons starts here
                count=0
                othersValue=0
                for recordset in @recordset 
                    #Check whether publisher request click or impression or revenuereport
                    if @report_type=='hourly_report'  
                      generate_hourlyXML(recordset.impressions,recordset.delivery_hour,@column2) 
                    elsif @report_type=='Traffic'
                          generate_contmapXML(recordset.continent,recordset.impressions,@report_type,@campaignid,@ad_id,@startdate,@enddate) 
                    elsif @report_type=='Traffic_Continent'
                        generate_continentXML(recordset.country_code,recordset.impressions,@report_type,args[11]) 
                    elsif (@report_type=='Carrier_Traffic' or @report_type=='Device_Summary')
                        count+=1
                        if (count.to_i<=5)
                             generate_piechartXML(recordset[@column2],recordset[@column3],@report_type,@smartLabel,@campaignid,@ad_id) 
                        else
                              othersValue+=recordset[@column3].to_i
                              if (@recordset.size.to_i==count.to_i)
                                    generate_piechartXML('Others',othersValue,@report_type,@smartLabel)
                              end
                            end
                    elsif @report_type=='Owner_Traffic' 
                          count+=1
                          if (count.to_i<=5)
                               generate_piechartXML(recordset[@column2],recordset[@column3],@report_type,@smartLabel) 
                          else
                                othersValue+=recordset[@column3].to_i
                                if (@recordset.size.to_i==count.to_i)
                                      generate_piechartXML('Others',othersValue,@report_type,@smartLabel)
                                end
                              end
                    elsif @report_type=='Model_Summary' 
                          count+=1
                          if (count.to_i<=5)
                               generate_piechartXML(recordset[@column2],recordset[@column3],@report_type,@smartLabel) 
                          else
                                othersValue+=recordset[@column3].to_i
                                if (@recordset.size.to_i==count.to_i)
                                      generate_piechartXML('Others',othersValue,@report_type,@smartLabel)
                                end
                          end
                    elsif @report_type=='DeviceProperties_Traffic'
                          count+=1
                          if (count.to_i<=5)
                               generate_piechartXML(recordset.property_name,recordset.property_count,@report_type,@smartLabel) 
                          else
                                othersValue+=recordset.dp_count.to_i
                                if (@recordset.size.to_i==count.to_i)
                                      generate_piechartXML('Others',othersValue,@report_type,@smartLabel)
                                end
                          end
                    elsif @report_type=='Ad_Wise'
                       #~ count+=1
                        #~ if (count.to_i<=5)
                             generate_piechartXML(recordset.ad_name,recordset[@column2],@report_type,@column2) 
                        #~ else
                              #~ othersValue+=recordset[@column2].to_i
                              #~ if (@recordset.size.to_i==count.to_i)
                                    #~ generate_piechartXML('Others',othersValue,@report_type,@smartLabel)
                              #~ end
                        #~ end
                    elsif @report_type=='Campaigns_Summary'
                        if args[5]=='imp vs clicks'
                          generate_mutil_linechartXML(recordset.impressions,recordset.clicks,recordset.delivery_date,@startdate,@enddate,'Impression Vs Clicks',@no_day,@duration)
                        else
                          generate_linechartXML(recordset[args[5]],recordset.delivery_date,@startdate,@enddate,args[5]=='ctr' ? args[5].upcase : args[5].capitalize,@no_day,@duration)
                        end
                    end 
                  end #for loop ends here

              #to insert xml datas for which recordset are not available
                if @report_type=='hourly_report'
                   if @@hour_count <24
                        for k in @@hour_count...24
                            @@XML_array[k]=["#{k}",0]
                            @@strXML=@@strXML+ "<set name='#{k}' value='0'/>"
                        end
                    end
                      @@strXML+="<styles><definition><style name='myLabelsFont' type='font' font='Arial' size='12' color='000000' bold='1'/></definition><application><apply toObject='DataLabels' styles='myLabelsFont' /></application></styles>"
                      elsif @report_type=='Campaigns_Summary' and args[5].to_s!='imp vs clicks'
                              if Time.parse(@enddate).strftime("%Y-%m-%d")>@@date_count.strftime("%Y-%m-%d")
                                   while Time.parse(@enddate).strftime("%Y-%m-%d")>=@@date_count.strftime("%Y-%m-%d")
                                          delivery_day=@@date_count.strftime("%Y-%m-%d").split('-')[2] #will return day
                                          if Time.parse(@enddate).strftime("%Y-%m-%d")==@@date_count.strftime("%Y-%m-%d")
                                                 @@strXML+= "<set name='#{@@date_count.strftime("%d-%b-%Y")}' value='0' #{@anchor_color if @duration.to_s=='0'}/>" 
                                          elsif delivery_day.to_i%@modulas==0 
                                                @@strXML+= "<set name='#{@@date_count.strftime("%d-%b-%Y")}' value='0'/>"
                                          end
                                          @@date_count+=86400
                                   end
                              elsif Time.parse(@enddate).strftime("%Y-%m-%d")==@@date_count.strftime("%Y-%m-%d")
                                     @@strXML+= "<set name='#{@@date_count.strftime("%d-%b-%Y")}' value='0' #{@anchor_color if @duration.to_s=='0'}/>" 
                              end
                              @@strXML+="<styles><definition><style name='myLabelsFont' type='font' font='Arial' size='12' color='000000' bold='1'/></definition><application><apply toObject='DataLabels' styles='myLabelsFont' /></application></styles>"
                          #to insert xml datas for impression vs click if recordsets are not available for specified date
                          elsif @report_type=='Campaigns_Summary' && args[5].to_s=='imp vs clicks'
                                if Time.parse(@enddate).strftime("%Y-%m-%d")>@@date_count.strftime("%Y-%m-%d")
                                     while Time.parse(@enddate).strftime("%Y-%m-%d")>=@@date_count.strftime("%Y-%m-%d")
                                            delivery_day=@@date_count.strftime("%Y-%m-%d").split('-')[2] #will return day
                                             if Time.parse(@enddate).strftime("%Y-%m-%d")==@@date_count.strftime("%Y-%m-%d") 
                                                   @@strXML+= "<set value='0' #{@anchor_color if @duration.to_s=='0'}/>"
                                                   @@cat_strXML+="<category label='#{@@date_count.strftime("%d-%b-%Y")}'/>"
                                                   @@multi_strXML+="<set value='0' #{@anchor_color if @duration.to_s=='0'}/>"
                                            elsif delivery_day.to_i%@modulas==0
                                                   @@strXML+= "<set value='0'/>"
                                                   @@cat_strXML+="<category label='#{@@date_count.strftime("%d-%b-%Y")}'/>"
                                                   @@multi_strXML+="<set value='0'/>"
                                            end
                                            @@date_count+=86400
                                     end
                                elsif Time.parse(@enddate).strftime("%Y-%m-%d")==@@date_count.strftime("%Y-%m-%d")
                                     @@strXML+= "<set value='0' #{@anchor_color if @duration.to_s=='0'}/>"
                                     @@cat_strXML+="<category label='#{@@date_count.strftime("%d-%b-%Y")}'/>"
                                     @@multi_strXML+="<set value='0' #{@anchor_color if @duration.to_s=='0'}/>"
                                end
                             @@multi_strXML+="</dataset>"
                             @@cat_strXML+="</categories>"
                             @@strXML+="</dataset>"
                             @@strXML+=@@cat_strXML
                             @@strXML+=@@multi_strXML
                             @@strXML+="<styles><definition><style name='myLabelsFont' type='font' font='Arial' size='12' color='000000' bold='1'/></definition><application><apply toObject='DataLabels' styles='myLabelsFont' /></application></styles>"
                end
                if @report_type=='Traffic'
                    @@strXML+="</data>"
                    @@strXML+="<colorRange><color minValue='0' maxValue='#{(@@date_count/3)}' displayValue='Low' color='A7FF98' /><color minValue='#{((@@date_count/3))}' maxValue='#{(@@date_count-(@@date_count/3))}' displayValue='Moderate' color='2CCE00' /><color minValue='#{(@@date_count-(@@date_count/3))}' maxValue='#{(@@date_count)+1}' displayValue='High' color='007700' /></colorRange></map>"
                end
                if @report_type=='Ad_Wise' and args[5]=='imp vs clicks'
                   @@multi_strXML+="</dataset>"
                   @@cat_strXML+="</categories>"
                   @@strXML+="</dataset>"
                   @@strXML+=@@cat_strXML
                   @@strXML+=@@multi_strXML
                   @@strXML+="<styles><definition><style name='myLabelsFont' type='font' font='Arial' size='12' color='000000' bold='1'/></definition><application><apply toObject='DataLabels' styles='myLabelsFont' /></application></styles>"
                end
                if @report_type=='Traffic_Continent'
                  @@strXML+='</data>'
                  @@strXML+="<colorRange><color minValue='0' maxValue='#{(@@date_count/3)}' displayValue='Low' color='A7FF98' /><color minValue='#{((@@date_count/3))}' maxValue='#{(@@date_count-(@@date_count/3))}' displayValue='Moderate' color='2CCE00' /><color minValue='#{(@@date_count-(@@date_count/3))}' maxValue='#{(@@date_count)+1}' displayValue='High' color='007700' /></colorRange></map>"
                end
                if @report_type=='Keyword'
                  @@strXML+="<styles><definition><style name='myValuesFont' type='font' size='16' color='000000' bold='1' font='Arial, Helvetica, sans-serif' /></definition><application><apply toObject='DataLabels'  styles='myValuesFont' /></application></styles>"
                end
                  @@strXML = @@strXML + "</chart>" if  @report_type!='Traffic'and @report_type!='Traffic_Continent'
            end #main If ends here
            #reinitialize flag, str variable and counters to construct next chart
            @@flag=true   
            @@xml_count=0
            @@date_count=0
            @@color_count=0 
            @@mod=0
            @@hour_count=0
            @returnstrXML=@@strXML
            @@strXML=''  
            @@cat_strXML=''
            @@multi_strXML=''
            @@xml_hash=nil
            @@xml_hash={:xml_string=>@returnstrXML,:xml_array=>@@XML_array }
            
            return @@xml_hash
          rescue Exception=>e
             puts "ERROR :: in AdvertiserXmlBuilder Component and generate_query method. The error is #{e.to_s}"
          end
        end # generate_query ends here
        #this method is used to construct xml structure based on the recordset retrived from the database
        def generate_hourlyXML(*args)
            begin
                if @@flag==true
                    @@strXML = "<chart decimals='2'connectNullData='1' numDivLines='2' alternateHGridColor='FFFFFF' divLineColor='CCCCCC' xAxisNamePadding='3' chartBottomMargin='5' lineColor='1E9DC8' anchorSides='8' anchorRadius='4' anchorBgColor='1E9DC8' anchorBorderColor='FFFFFF' anchorBorderThickness='1' labelStep='2' showValues='0' canvasBorderColor ='F2F2F2' canvasBorderThickness='1' canvasBorderAlpha='0' baseFontSize ='12' chartTopMargin='10' chartLeftMargin='1' chartRightMargin='35' bgColor='ffffff'    xAxisName='Hours - GMT' yAxisName='Impressions' showNames='1' numDivLines='0'  numVDivLines='0' showBorder='0' formatNumberScale='0'>  "
                    @@flag=false
                end
              if args[1].to_i > @@hour_count.to_i
                    for j in @@hour_count...args[1].to_i
                    @@strXML=@@strXML+  "<set name='#{j}'  value='0' />"
                    end
                    @@strXML=@@strXML+  "<set name='#{args[1]}' value='#{args[0]}'/>"
                    @@hour_count=(args[1].to_i)+1
              elsif args[1].to_i==@@hour_count.to_i
                    @@strXML=@@strXML+  "<set name='#{args[1]}' value='#{args[0]}'/>"
                    @@hour_count=(args[1].to_i)+1
              end
            rescue Exception=>e
                  puts "ERROR :: in AdvertiserXmlBuilder Component and generate_hourlyXML method. The error is #{e.to_s}"
            end
        end
        
        #this method is used to construct xml structure for piechart
        def generate_piechartXML(*args)
            begin
                  @aes = AESSecurity.new()
                  @color_hash=Hash.new
                  @adwisecolor_hash=Hash.new
                  @pieRadius="pieRadius='100'"
                  @color_hash={"0"=>"0C95BF","1"=>"12C400","2"=>"ECB800","3"=>"EB2300","4"=>"70808F","5"=>"000000","6"=>"800080","7"=>"FFFF00","8"=>"7FFFD4"}
                  @adwisecolor_hash={"0"=>"0C95BF","1"=>"0DA3D1","2"=>"11B3E4","3"=>"15C2F7","4"=>"4BCDFB","5"=>"48D3FD","6"=>"71DCFD","7"=>"8BE4FF","8"=>"9DE5FB","9"=>"BFECFA"}
                  if @@flag==true
                      @@strXML = "<chart decimals='2' defaultAnimation='0'  use3DLighting='0' showPlotBorder='1' showShadow='0' plotGradientColor='0' showLabels='#{args[3]}' chartTopMargin='0' chartLeftMargin='0' chartRightMargin='0' chartBottomMargin='0' showValues='#{args[3]}'   baseFontSize='12'  decimals='0' isSliced='0' enableSmartLabels='#{args[3]}'  bgColor='FFFFFF' showBorder='0' plotBorderThickness='0'  startingAngle='80' canvasBorderColor ='cccccc' canvasBorderAlpha='0' canvasBorderThickness='0' showPercentageValues='1' #{args[3].to_i==1 ? @pieRadius : ''}>" if args[2]=='Device_Summary' or args[2]=="Carrier_Traffic"  or args[2]=="Owner_Traffic"  or args[2]=="Model_Summary"
                      @@strXML = "<chart yAxisName='Impressions'  decimals='2' defaultAnimation='0' use3DLighting='0' showPlotBorder='0' plotGradientColor='' divLineColor ='FFFFFF'  baseFontSize ='12' numDivLines='2' alternateVGridColor='FFFFFF'  showBorder='0' showLabels='1' chartTopMargin='5' chartRightMargin ='30'  showValues='0' bgColor='FFFFFF' canvasBorderColor='FFFFFF' canvasBorderThickness='0' formatNumberScale='0'>" if args[2]=="DeviceProperties_Traffic"     
                      @@strXML = "<chart yAxisName='#{args[3].capitalize}'  decimals='2' defaultAnimation='0' use3DLighting='0' showPlotBorder='0' plotGradientColor='' divLineColor ='FFFFFF'  baseFontSize ='12' numDivLines='2' alternateVGridColor='FFFFFF'  showBorder='0' showLabels='1' chartTopMargin='5' chartRightMargin ='30'  showValues='0' bgColor='FFFFFF' canvasBorderColor='FFFFFF' canvasBorderThickness='0' formatNumberScale='0'> " if args[2]=='Ad_Wise'
                      @@flag=false
                  end 
                  key='rh21nr8e0vav0h0v'
                  iv='1pnee1ng36nuare8'
                  if args[2]=='DeviceProperties_Traffic'
                      args[0]=(args[0]=='' || args[0]==nil) ? 'Unknown' : (args[0].include?('InVideo')) ? 'video' : args[0]
                  else
                      args[0]=(args[0]=='' || args[0]==nil) ? 'Unknown' : args[0]
                    end
                  getsymbol={"&"=>"%7E","%"=>"%25","'"=>""}
                  colour="#{args[2]=='Ad_Wise' ? @adwisecolor_hash["#{@@color_count}"]  : @color_hash["#{@@color_count}"]}" #get the color
                  #url_model=(args[2]=='Device_Summary') ? (args[0]!='Others' && args[0]!='Unknown') ? "link='/#{@@user}/advertiser_handset_model%3Fhandset=#{args[0].to_s.gsub(/([&%])/) do|s| getsymbol["#{s}"] end}'" : ""  : ""
                  #url=(args[2]=='Carrier_Traffic' && @@user=='admin_analytic') ? args[0]!='Others' ? "link='/#{@@user}/advertiser_owner%3Foperator=#{args[0].to_s.gsub(/([&%'])/) do|s| getsymbol["#{s}"] end}/#{@aes.encrypt(key,iv,"#{args[4]}")}/#{args[5]}'" : ""  : ""
                  @@strXML=@@strXML+ "<set label='#{args[0].to_s.gsub(/([&%'])/) do|s| @@getsymbol["#{s}"] end}' value='#{args[1].to_s}' color='#{colour.to_s}' />" if args[2]!='Ad_Wise' and args[2]!='URL'
                  @@strXML+="<set label='#{(truncate(args[0].to_s,10)).gsub(/([&%'])/) do|s| @@getsymbol["#{s}"] end}' toolText='#{args[0].to_s.gsub(/([&%'])/) do|s| @@getsymbol["#{s}"] end}, #{args[1].to_s}' value='#{args[1].to_s}'  color='#{colour.to_s}'/>" if args[2]=='Ad_Wise'
                  @@date_count+=args[1].to_i
                  @@XML_array[@@color_count]=["#{args[0]}",args[1].to_i,colour,@@date_count] if args[2]!='Ad_Wise' and args[2]!='DeviceProperties_Traffic'
                  @@color_count+=1
            rescue Exception=>e
                puts "ERROR :: in AdvertiserXmlBuilder Component and generate_piechartXML method. The Error is #{e.to_s}"
            end
        end
        
        #This method is used to construct xml structure for unique visitor and Traffic summary .
        #args[0] returns no of clicks, impression, ctr or revenue
        #args[1] returns xml type: whether daily, monthly or yearly
        #args[2] returns day from table
        #args[3] returns month from table
        #args[4] returns year from table
        #args[5] returns start day 
        #args[6] returns start month
        #args[7] returns start year
        #args[8] returns y axis labelname
        #args[9] recordset size
        
         def generate_linechartXML(*args)
          begin
                if @@flag==true
                  @@mod=args[5].to_i
                  @@mod=@@mod/30>0 ? @@mod/30 : 1
                  @@strXML="<chart decimals='2' connectNullData='1' lineDashGap='6' labelDisplay='WRAP' lineColor ='1E9DC8' anchorSides='10' anchorRadius='4' anchorBgColor='1E9DC8' anchorBorderColor='FFFFFF' anchorBorderThickness='1' labelStep='#{(args[5].to_i/(@@mod*4)).to_s}' numDivLines='2' alternateHGridColor='FFFFFF' divLineColor='CCCCCC'  numVDivLines='0' showLabels='1' showValues='0' canvasBorderColor ='FFFFFF' canvasBorderAlpha='0' canvasBorderThickness='0'  baseFontSize ='12' chartTopMargin='8' chartLeftMargin='1'  decimalPrecision='0' bgColor='ffffff' xAxisName='' yAxisName='Unique Visitors' showNames='1' showBorder='0' chartRightMargin='35' formatNumberScale='0' > " if args[4].to_s=='Unique_visitors'
                  @@strXML="<chart decimals='2' connectNullData='1' lineDashGap='6' labelDisplay='WRAP' lineColor ='1E9DC8' anchorSides='10' anchorRadius='4' anchorBgColor='1E9DC8' anchorBorderColor='FFFFFF' anchorBorderThickness='1' labelStep='#{(args[5].to_i/(@@mod*6)).to_s}' numDivLines='3' alternateHGridColor='FFFFFF' divLineColor='CCCCCC'  numVDivLines='0' showLabels='1' showValues='0' canvasBorderColor ='FFFFFF' canvasBorderAlpha='0' canvasBorderThickness='0'  baseFontSize ='12' chartTopMargin='8' chartLeftMargin='1'  decimalPrecision='0' bgColor='ffffff' xAxisName='' yAxisName='#{args[4]=='Amount_spent' ? 'Spent' : args[4].to_s}' showNames='1' showBorder='0' chartRightMargin='35' formatNumberScale='0' > " if args[4].to_s!='Unique_visitors'
                  @@flag=false
                end
                @anchor_color="anchorBgColor='FF0000'"
                @delivery_date=args[1].to_s
                @delivery_date=Time.parse(@delivery_date)
                if @delivery_date.strftime("%Y-%m-%d")>@@date_count.strftime("%Y-%m-%d")
                      while @delivery_date.strftime("%Y-%m-%d")>@@date_count.strftime("%Y-%m-%d")
                            delivery_day=@@date_count.strftime("%Y-%m-%d").split('-')[2] #will return day
                            if @@date_count==Time.parse(args[2])
                                 @@strXML+= "<set name='#{@@date_count.strftime("%d-%b-%Y")}' value='0'/>"
                            elsif delivery_day.to_i%@@mod==0 
                                @@strXML+= "<set name='#{@@date_count.strftime("%d-%b-%Y")}' value='0'/>"
                            end
                            @@date_count+=86400
                      end
                      @@strXML+= "<set name='#{@@date_count.strftime("%d-%b-%Y")}' value='#{args[0]==nil ? 0 : args[0].to_s}' #{@anchor_color if args[6].to_s=='0' and Time.parse(args[3]).strftime("%d-%b-%Y")==@@date_count.strftime("%d-%b-%Y")}/>" 
                      @@date_count+=86400
                 elsif @delivery_date.strftime("%Y-%m-%d")==@@date_count.strftime("%Y-%m-%d")
                       @@strXML+= "<set name='#{@@date_count.strftime("%d-%b-%Y")}' value='#{args[0]==nil ? 0 : args[0].to_s}' #{@anchor_color if args[6].to_s=='0' and Time.parse(args[3]).strftime("%d-%b-%Y")==@@date_count.strftime("%d-%b-%Y")}/>" 
                       @@date_count+=86400
                  end
            rescue Exception=>e
                  puts "ERROR :: in AdvertiserXmlBuilder Component and generate_linechartXML method.The Error is #{e.to_s}"
            end
        end  #generatelinechartXML ends here
        
                
        #This method is used to construct xml structure for all continent map
        def generate_contmapXML(*args)
          begin
            @continent={"AS"=>"01","EU"=>"02","AF"=>"03","NA"=>"04","SA"=>"05","CA"=>"06","OC"=>"07","ME"=>"08"}
            @aes = AESSecurity.new()
            if @@flag==true
              @@strXML="<map hoverColor='01B401' useSNameInLabels='0' formatNumberScale='0' showCanvasBorder='0' fillColor='F7F7F7' includeValueInLables='0'  showPercentageValues='1' defaultAnimation='0' showShadow='0' showBevel='0'><data>"
              @@flag=false
              @@date_count=args[1].to_i
            end
            if @@date_count<args[1].to_i
              @@date_count=args[1].to_i
            end
            key='rh21nr8e0vav0h0v'
            iv='1pnee1ng36nuare8'
             ccode=@continent["#{args[0]}"]
              @@strXML+="<entity id='#{ccode}' value='#{args[1].to_s}' link='/#{@@user}/advertiser_traffic_continent%3Fparams=#{args[0]}/#{@aes.encrypt(key,iv,"#{args[3]}")}/#{args[4]}' />" if args[1].to_i>0
          rescue Exception=>e
            puts "ERROR :: in AdvertiserXmlBuilder Component :: generate_contmapXML method :: #{e.to_s}"
          end
        end #contmapXML ends here

        #This method is used to construct xml structure for particular continent
        def generate_continentXML(*args)
          begin
          #following hashes are used to get the country code number using country code
          @North_America=Hash.new
          @South_America=Hash.new
          @Europe=Hash.new
          @Asia=Hash.new
          @Africa=Hash.new
          @Oceania=Hash.new
          @Oceania={"AU"=>"001","FJ"=>"002","KI"=>"003","MH"=>"004","FM"=>"005","NR"=>"006","NZ"=>"007","PW"=>"008","PG"=>"009","WS"=>"010","SB"=>"011","TO"=>"012","TV"=>"013","VU"=>"014","NC"=>"015"}
           @Africa={"DZ"=>"001","AO"=>"002","BJ"=>"003","BW"=>"004","BF"=>"005","BI"=>"006","CM"=>"007","CV"=>"008","CF"=>"009","TD"=>"010","KM"=>"011","CI"=>"012","CD"=>"013","DJ"=>"014","EG"=>"015","GQ"=>"016","ER"=>"017","ET"=>"018","GA"=>"019","GH"=>"020","GN"=>"021","GW"=>"022","KE"=>"023","LS"=>"024","LR"=>"025","LY"=>"026","MG"=>"027","MW"=>"028","ML"=>"029","MR"=>"030","MA"=>"032","MZ"=>"033","NA"=>"034","NE"=>"035","NG"=>"036","RW"=>"038","ST"=>"040","SN"=>"041","SY"=>"042","SL"=>"043","SO"=>"44","ZA"=>"045","SD"=>"046","SZ"=>"047","TZ"=>"048","TG"=>"049","TN"=>"015","UG"=>"052","WS"=>"053","ZM"=>"054","ZW"=>"055","GM"=>"056","CG"=>"057","MU"=>"058"}
           @Asia={"AF"=>"001","AM"=>"002","AZ"=>"003","BD"=>"005","BT"=>"006","BN"=>"007","MM"=>"008","KH"=>"009","CN"=>"010","TP"=>"012","GE"=>"013","IN"=>"014","ID"=>"015","IR"=>"016","JP"=>"019","KZ"=>"021","KP"=>"022","KR"=>"023","LA"=>"026","MY"=>"028","MN"=>"030","NP"=>"031","PK"=>"033","PH"=>"034","RU"=>"036","SG"=>"038","LK"=>"039","TH"=>"042","TM"=>"044","UZ"=>"046","VN"=>"047","TW"=>"049","HK"=>"050","MO"=>"051"}
           @Europe={"AL"=>"001","AD"=>"002","AT"=>"003","BY"=>"004","BE"=>"005","BA"=>"006","BG"=>"007","HY"=>"008","CZ"=>"009","DK"=>"010","EE"=>"011","FI"=>"012","FR"=>"013","DE"=>"014","GR"=>"015","HU"=>"016","IS"=>"017","IE"=>"018","IT"=>"019","LV"=>"020","LI"=>"021","LT"=>"022","LU"=>"023","MK"=>"024","MT"=>"025","MD"=>"026","MC"=>"027","ME"=>"028","NL"=>"029","NO"=>"030","PL"=>"031","PT"=>"032","RO"=>"033","SM"=>"034","CS"=>"035","SK"=>"036","SI"=>"037","ES"=>"038","SE"=>"039","CH"=>"040","UA"=>"041","GB"=>"042","VA"=>"043","CY"=>"044","TR"=>"045","RU"=>"046","UK"=>"042"}
           @South_America={"AR"=>"001","BO"=>"002","BR"=>"003","CL"=>"004","CO"=>"005","EC"=>"006","FK"=>"007","GF"=>"008","GY"=>"009","PY"=>"010","PE"=>"011","SR"=>"012","UY"=>"013","VE"=>"014"}
           @North_America={"AG"=>"001","BS"=>"002","BB"=>"003","BZ"=>"004","CA"=>"005","CR"=>"006","CU"=>"007","DM"=>"008","DO"=>"009","SV"=>"010","GD"=>"011","GT"=>"012","HT"=>"013","HN"=>"014","JM"=>"015","MX"=>"016","NI"=>"017","PA"=>"018","KN"=>"019","LC"=>"020","VC"=>"021","TT"=>"022","US"=>"023","GL"=>"024","PR"=>"025","KY"=>"026"}
           @Central_America={"BZ"=>"01","CR"=>"02","SV"=>"03","GT"=>"04","HN"=>"05","NI"=>"06","PM"=>"07"}
           @Middle_East={"AF"=>"01","BH"=>"02","IR"=>"03","IQ"=>"04","IL"=>"05","JO"=>"06","KW"=>"07","KG"=>"08","LB"=>"09","OM"=>"10","PK"=>"11","QA"=>"12","SA"=>"13","SY"=>"14","TI"=>"15","TU"=>"16","TX"=>"17","AE"=>"18","UZ"=>"19","YE"=>"20"}
          if @@flag==true
            @@strXML="<map defaultAnimation='0' useSNameInLabels='1' showShadow='0' showBevel='0' hoverColor='01B401' formatNumberScale='0' showCanvasBorder='0' fillColor='F7F7F7' leftMargin='5'><data>"
            @@flag=false
            @@date_count=args[1].to_i
          end
          if @@date_count<args[1].to_i
            @@date_count=args[1].to_i
          end
          args[3]=args[3]=='CB' ? 'NA' : args[3]
          if args[3]=='NA'
            ccode=@North_America["#{args[0]}"]
          elsif args[3]=='SA'
            ccode=@South_America["#{args[0]}"]
          elsif args[3]=='AS'
            ccode=@Asia["#{args[0]}"]
          elsif args[3]=='AF'
            ccode=@Africa["#{args[0]}"]
          elsif args[3]=='OC'
            ccode=@Oceania["#{args[0]}"]
          elsif args[3]=='EU'
            ccode=@Europe["#{args[0]}"]
          elsif args[3]=='ME'
            ccode=@Middle_East["#{args[0]}"]
          elsif args[3]=='CA'
            ccode=@Central_America["#{args[0]}"]
          end
          @@strXML+="<entity id='#{ccode.to_s}' value='#{args[1].to_s}' />" if args[1].to_i>0
          rescue Exception=>e
            puts "ERROR :: in AdvertiserXmlBuilder Component :: generate_continentXML method :: #{e.to_s}"
          end
        end 
        
        
        # generate continent xml method ends here
        def generate_multi_PiechartXML(*args)
          begin
            if @@flag==true
              @@strXML="<chart formatNumberScale='0' decimals='2' labelDisplay='Stagger'   labelStep='#{@labelstep.to_s}' numDivLines='0'  numVDivLines='0'  showLabels='1' showValues='0' canvasBorderColor ='F2F2F2' canvasBorderAlpha='0' canvasBorderThickness='0' baseFontSize ='12' chartTopMargin='10' chartLeftMargin='1' chartRightMargin='4' decimalPrecision='0' bgColor='ffffff'    xAxisName='' yAxisName='Impressions Vs Clicks' showNames='1' showBorder='0' lineThickness='4' >" 
              @@strXML+="<dataset  valuePadding='1' seriesName='Impressions' Color='1E9DC8' anchorSides='10' anchorRadius='4' anchorBgColor='1E9DC8' anchorBorderColor='FFFFFF' anchorBorderThickness='1'>"
              @@multi_strXML="<dataset  seriesName='Clicks' Color='999999'  anchorSides='10' anchorRadius='4' anchorBgColor='999999' anchorBorderColor='FFFFFF' anchorBorderThickness='1'>"
              @@cat_strXML="<categories>"
              @@flag=false
              #root element ends here
            end
            @@strXML+= "<set value='#{args[1].to_s}'/>"
            @@cat_strXML+="<category label='#{args[0].to_s}'/>"
            @@multi_strXML+="<set value='#{args[2].to_s}'/>"
          rescue Exception=>e
            puts"Error:: AdvertiserXmlBuilder component generate_multi_PiechartXML method. An error occured in #{e.to_s}"
          end
        end
      #This method is used to construct xml structure for impression vs click
          #args[0] returns , impression, 
          #args[1] returns clicks
          #args[2] returns deliverydate  from table
          #args[3] returns start date
          #args[4] returns end date
          #args[5] returns chart type
          #args[6] returns no of record to calculate modulas value
          #args[7] returns period (duration) 
       def generate_mutil_linechartXML(*args)
              begin
                 if @@flag==true
                      #following is used to set the labelstep
                        @@mod=args[6].to_i
                        @@mod=@@mod/30>0 ? @@mod/30 : 1
                        @labelstep=args[6].to_i/(@@mod*6)
                         #following code is used to root element of xml
                        @@strXML="<chart formatNumberScale='0' connectNullData='1' lineDashGap='6' labelStep='#{@labelstep.to_s}' numDivLines='3' alternateHGridColor='FFFFFF' divLineColor='F3F3F3'  numVDivLines='0'  showLabels='1' showValues='0' canvasBorderColor ='F2F2F2' canvasBorderAlpha='0' canvasBorderThickness='0' baseFontSize ='12' chartTopMargin='10' chartLeftMargin='1' chartRightMargin='35' decimalPrecision='0' bgColor='ffffff'    xAxisName='' yAxisName='Impressions Vs Clicks' showNames='1' showBorder='0' lineThickness='4' >" 
                        @@strXML+="<dataset valuePadding='1' seriesName='Impressions' Color='0C95BF' anchorSides='10' anchorRadius='4' anchorBgColor='0C95BF' anchorBorderColor='FFFFFF' anchorBorderThickness='1'>"
                        @@multi_strXML="<dataset seriesName='Clicks' Color='999999'  anchorSides='10' anchorRadius='4' anchorBgColor='999999' anchorBorderColor='FFFFFF' anchorBorderThickness='1'>"
                        @@cat_strXML="<categories>"
                        @@flag=false
                       #root element ends here
                     end
                      @anchor_color="anchorBgColor='FF0000'"
                      @delivery_date=args[2].to_s
                      @delivery_date=Time.parse(@delivery_date)
                      if @delivery_date.strftime("%Y-%m-%d")>@@date_count.strftime("%Y-%m-%d")
                          while @delivery_date.strftime("%Y-%m-%d")>@@date_count.strftime("%Y-%m-%d")
                                delivery_day=@@date_count.strftime("%Y-%m-%d").split('-')[2] #will return day
                                if @@date_count.strftime("%Y-%m-%d")==Time.parse(args[3]).strftime("%Y-%m-%d")
                                      @@strXML+= "<set value='0'/>"
                                      @@cat_strXML+="<category label='#{@@date_count.strftime("%d-%b-%Y")}'/>"
                                      @@multi_strXML+="<set value='0'/>"
                                elsif delivery_day.to_i%@@mod==0
                                      @@strXML+= "<set value='0'/>"
                                      @@cat_strXML+="<category label='#{@@date_count.strftime("%d-%b-%Y")}'/>"
                                      @@multi_strXML+="<set value='0'/>"
                                end
                               @@date_count+=86400
                             end
                                @@strXML+=  "<set value='#{args[0].to_s}' #{@anchor_color if args[7].to_s=='0' and Time.parse(args[4]).strftime("%Y-%m-%d")==@@date_count.strftime("%Y-%m-%d")}/>"
                                @@cat_strXML+="<category label='#{@@date_count.strftime("%d-%b-%Y")}'/>"
                                @@multi_strXML+="<set value='#{args[1]==nil ? 0 : args[1].to_s}' #{@anchor_color if args[7].to_s=='0' and Time.parse(args[4]).strftime("%Y-%m-%d")==@@date_count.strftime("%Y-%m-%d")}/>"
                                @@date_count+=86400
                      elsif @delivery_date.strftime("%Y-%m-%d")==@@date_count.strftime("%Y-%m-%d")
                            @@strXML+=  "<set value='#{args[0].to_s}'  #{@anchor_color if args[7].to_s=='0' and Time.parse(args[4]).strftime("%Y-%m-%d")==@@date_count.strftime("%Y-%m-%d")}/>"
                            @@cat_strXML+="<category label='#{@delivery_date.strftime("%d-%b-%Y")}'/>"
                            @@multi_strXML+="<set value='#{args[1]==nil ? 0 : args[1].to_s}'  #{@anchor_color if args[7].to_s=='0' and Time.parse(args[4]).strftime("%Y-%m-%d")==@@date_count.strftime("%Y-%m-%d")}/>"
                            @@date_count+=86400
                      end
            rescue Exception=>e
                 puts "ERROR :: in AdvertiserXmlBuilder Component and generate_mutil_linechartXML. The error is :: #{e.to_s}"
            end
          end #generate_mutil_linechartXML method ends here
          
    rescue Exception=>e
        puts "ERROR :: in ReportGenerator Component and generate_mutil_linechartXML. The error is :: #{e.to_s}"
      end
    #This methode is used to truncate the string into given size
     def truncate(*args)
          i=args[0]
          limit=args[1].to_i
          begin
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
                puts "DEBUG :: ERROR :: AdminXMLBuilder Component > truncate Action. Exception is #{e.to_s}"
                return i
          end
        end #truncate method ends here
end   #class ends here
