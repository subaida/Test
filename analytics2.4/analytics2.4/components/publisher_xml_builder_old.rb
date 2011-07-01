
#/*
# * Reports.rb
# *
# * Author :Md Shujauddeen A
# * Version: 1.0
# * Created: 23-07-2008
# * Last Modified: 28-06-2008
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

require 'active_record'
require 'AnalyticsDBConnection'
require 'aes_security.rb' #this is to require AES security component
ActiveRecord::Base.establish_connection(  
:adapter => "mysql",  
:host => HOSTNAME,  
:database => DATABASE,
:username => USERNAME,
:password => PASSWORD
)
class AdclientsSummary < ActiveRecord::Base  
end
class PubChannel < ActiveRecord::Base  
end
class PubCarrier < ActiveRecord::Base  
end
class PubUrl < ActiveRecord::Base  
end
class PubHandset < ActiveRecord::Base  
end
class PubGeolocation < ActiveRecord::Base  
end
@@hour= 0
@@strXML=''
@@multi_strXML=''
@@cat_strXML=''
@@XML_array=Array.new
@@date_count=0
@@color_count=0
@@mod=0
@@flag=true
@@xml_hash=Hash.new
class PublisherXmlBuilder
  begin
        # This hash is used to get the value of month in english
        @@monthtoenglish={"1"=>"Jan","01"=>"Jan","2"=>"Feb","02"=>"Feb","3"=>"Mar","03"=>"Mar","4"=>"Apr","04"=>"Apr","5"=>"May","05"=>"May","6"=>"June","06"=>"June","7"=>"July","07"=>"July","8"=>"Aug","08"=>"Aug","9"=>"Sep","09"=>"Sep","10"=>"Oct","11"=>"Nov","12"=>"Dec"}
        @@getsymbol={"&"=>"%26","%"=>"%25"}
        # This method is used to get the exact number of days in a month, ex: it gives 29 days as output for the february month in a leap year
        def daysinmonth(year, month)
          return (Date.new(year, 12, 31) << (12-month)).day
        end
        
        #This method is used to construct query based on the parameter receives from the controller
        def generate_query(*args) #generate_query starts here
          begin
                @@XML_array=Array.new
                 @pub_id=(args[0].split('-')[0]).to_i
                 chk_filled=args[0].split('-')[1]
                 @tablename=args[1]
                 @report_type=args[2]
                 @column1=args[3]
                 @column2=args[4]
                 @adclientid=args[5]
                 @enddate=args[7]
                 @startdate=args[6]
                 @startdate= (args[8]=='0' and (@report_type=='Visitors' or @report_type=='Traffic_summary')) ? (Time.now - 2592000).to_s : (args[8]=='1' and (@report_type=='Visitors' or @report_type=='Traffic_summary')) ? (Time.now - 2678400).to_s : (((Time.parse(@startdate))==(Time.parse(@enddate))) && (@report_type=='Visitors' or @report_type=='Traffic_summary')) ? (((Time.parse(@enddate))-2592000).to_s) : args[6]
                 controller=args[9]
                 temp=args[10]
                 #args[8] returns 1 or 0 in PieChart for smartLabel, in LineChart return 1 for duration
                 if @column2=='Impressions Vs Clicks' 
                    @column2='impressions'
                    @column3='clicks'
                 end
                 if @column2=='ctr'
                  @ctr="((sum(clicks)/sum(impressions))*100)"
                 elsif @column2=='ecpm'
                  @ecpm='((sum(revenue)/sum(impressions))*1000)'
                end
                @start_year= Time.parse(@startdate).strftime("%Y-%m-%d").split('-')[0]  #retrieves start year, selected by the publisher
                @start_day=Time.parse(@startdate).strftime("%Y-%m-%d").split('-')[2]  #retrives start day, selected by the publisher
                @start_month=Time.parse(@startdate).strftime("%Y-%m-%d").split('-')[1]  #retrives start month, selected by the publisher
                @end_year=Time.parse(@enddate).strftime("%Y-%m-%d").split('-')[0] #retrives end year, selected by the publisher
                @end_month=Time.parse(@enddate).strftime("%Y-%m-%d").split('-')[1] #retrives end month, selected by the publisher
                @end_day=Time.parse(@enddate).strftime("%Y-%m-%d").split('-')[2] #retrives end day, selected by the publisher
                begin
                    filter_column=chk_filled=='filled' ? (@tablename=='adclients_summaries' || @tablename=='pub_handsets' || @tablename=='pub_geolocations' || @tablename=='adclients_summaries') ? @report_type=='Traffic_summary' ? "and (impressions>0 or clicks>0)" :  "and impressions>0" : "and requests>0" : chk_filled=='unfilled' ? "and fill_rate>0" : (chk_filled=='both' && (@tablename=='adclients_summaries' || @tablename=='adclients_summaries')) ? "and (impressions>0 or fill_rate>0 or clicks>0)" : (chk_filled=='both' && ( @tablename=='pub_handsets' || @tablename=='pub_geolocations')) ? "and (impressions>0 or fill_rate>0)" : "and (requests>0 or fill_rate>0)"
                    #following code is used to frame query to retrieve recordset from the database
                    continent_traffic="if(continent_code='CB','NA',continent_code) as continent"
                    continent_code=args[8].to_s=='NA' ? "'NA' or continent_code='CB'" : "'#{args[8]}'" if @report_type=='Traffic_Continent'
                    @adclient_type=(@adclientid!='SMS' and @adclientid!='WAP')? " and client_id=#{@adclientid}" : " and (ad_client_type='#{@adclientid.upcase}')"  if @column1!='handset' and @tablename!='pub_urls'
                    @adclient_type=(@adclientid!='SMS' and @adclientid!='WAP')? " and client_id=#{@adclientid}" : ""  if @column1=='handset' or  @tablename=='pub_urls'
                    sql_query="select #{@column1=='continent_code' ? continent_traffic : @column1}, #{(@column2=='ctr' ? @ctr : (@column2=='ecpm' ? @ecpm : (chk_filled=='filled' || @column2=='clicks' || @column2=='revenue') ? "sum(#{@column2})" : chk_filled=='unfilled' ? "sum(fill_rate)" : "(sum(#{@column2})+sum(fill_rate))" ))} as #{(@column1=='handset' or @column1=='handset_model') ? 'requests' : @column2} from #{@tablename} where" if args[4].to_s!='Impressions Vs Clicks' and @tablename!='pub_keywords'
                    sql_query="select #{@column1},#{chk_filled=='filled' ? "sum(#{@column2})" : chk_filled=='unfilled' ? "sum(fill_rate)" : "(sum(#{@column2})+sum(fill_rate))"} as #{@column2}, sum(#{@column3}) as #{@column3} from #{@tablename} where" if args[4].to_s=='Impressions Vs Clicks' 
                    sql_query="select carriers as operator ,#{chk_filled=='filled' ? "sum(requests)" : chk_filled=='unfilled' ? "sum(fill_rate)" : "(sum(requests)+sum(fill_rate))"} as requests from #{@tablename} where " if @tablename=='pub_carriers'
                    sql_query+=" pub_id =#{@pub_id}" if @pub_id!=nil 
                    sql_query+=" and delivery_date>='#{(Time.parse(@startdate)).strftime("%Y-%m-%d")}' and delivery_date<='#{(Time.parse(@enddate)).strftime("%Y-%m-%d")}'" if @startdate!=nil and @startdate!="" and @enddate!=nil and @enddate!=""
                    sql_query+=" and (continent_code=#{continent_code})" if @report_type=='Traffic_Continent'
                    sql_query+=" #{filter_column}"
                    sql_query+="#{@adclient_type}" 
                    sql_query+=" and handset='#{temp}'" if @column1=='handset_model'
                    sql_query+=" group by delivery_hour" if (@tablename=='adclients_summaries' || @tablename=='adclients_summaries') and @report_type=='hourly_report' 
                    sql_query+=" group by #{@column1} order by #{@column1=='handset' ? 'requests' : @column2} desc #{args[8].to_i!=1 ? 'limit 5' : ''}" if @report_type=='Pie_chart' || @report_type=='Bar_chart'#|| @tablename=='pub_keywords' || @tablename=='pub_devices' || @tablename=='pub_urls'
                    sql_query+=" group by continent" if @report_type=='Traffic'
                    sql_query+=" group by country_code" if @report_type=='Traffic_Continent'
                    #following code is used to calculate modulas value
                    if @report_type=='Visitors' || @report_type=='Traffic_summary'
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
                         sql_query+=" and if(((delivery_date='#{@start_year}-#{@start_month}-#{@start_day}') || (delivery_date='#{@end_year}-#{@end_month.to_i}-#{@end_day.to_i}')),Day(delivery_date),Day(delivery_date)%#{@modulas}=0)" if @startdate!=nil and @startdate!="" and @enddate!=nil and @enddate!="" and @modulas.to_i>1
                         sql_query+=" group by delivery_date order by null"  
                         @@date_count=Time.parse(@startdate)
                    end
              rescue Exception=>e
                puts"Error:: under query generator and the exception is:#{e.to_s}"
              end
                begin
                    @tablename=@tablename.classify.constantize  #convert the string into model name
                    @recordset=@tablename.find_by_sql(sql_query) # fetch the recordset from table
               rescue Exception=>e
                    puts "DEBUGGER :: ERROR :: in report_generator.rb - generate query :: #{e.to_s}"
                end
              @@XML_array.clear
              @anchor_color="anchorBgColor='FF0000'"
              count=0
              othersValue=0
              otherPercentage=0.00
              if @recordset!=nil #main If conditons starts here
              if @recordset.size !=0  #sub main If conditons starts here
                  for recordset in @recordset 
                         #Checks report_type to call corresponding method to generate report.
                       if @report_type=='hourly_report'  
                              generate_hourlyXML(recordset.impressions,recordset.delivery_hour) 
                      elsif @report_type=='Pie_chart'
                              count+=1
                              if (count.to_i<=5)
                                   generate_piechartXML(recordset[@column1],recordset.requests,@column1,args[8],controller)
                              else
                                    othersValue+=recordset.requests.to_i
                                    if (@recordset.size.to_i==count.to_i)
                                          generate_piechartXML('Others',othersValue,@column1,args[8],controller)
                                    end
                              end
                      elsif @report_type=='Traffic'
                             generate_contmapXML(recordset.continent,recordset.impressions,@report_type,@pub_id,@adclientid,controller) 
                      elsif @report_type=='Bar_chart'
                             count+=1
                              if (count.to_i<=5)
                                   generate_piechartXML(recordset.keywords,recordset.requests,@column1,recordset.key_percentage,args[8]) 
                              else
                                    othersValue+=recordset.requests.to_i
                                    otherPercentage+=recordset.key_percentage.to_f
                                    if (@recordset.size.to_i==count.to_i)
                                          generate_piechartXML('Others',othersValue,@column1,otherPercentage,args[8]) 
                                    end
                              end
                      elsif @report_type=='Traffic_Continent'
                              generate_continentXML(recordset.country_code,recordset.impressions,@report_type,args[8]) 
                      elsif @report_type=='Visitors'
                               generate_linechartXML(recordset.requests_unique_visitors,recordset.delivery_date,@startdate,@enddate,@report_type,@no_day,args[8])
                      elsif @report_type=='Traffic_summary'
                              if args[4].to_s=="Impressions Vs Clicks"
                                 generate_mutil_linechartXML(recordset.impressions,recordset.clicks,recordset.delivery_date,@startdate,@enddate,'Impression Vs Clicks',@no_day,args[8])
                              else 
                                 generate_linechartXML(recordset[args[4]],recordset.delivery_date,@startdate,@enddate,"#{args[4]=='ecpm' ? (args[4].capitalize).swapcase : args[4]=='ctr' ? args[4].upcase : args[4].capitalize}",@no_day,args[8])
                              end
                        end 
                      end #for loop ends here
                      
                         #following code is used to insert default xml values (zero) for which recordset are not available
                         #checks if report type is hourly report and insert default for hourly report if records are not available in DB
                        
                        if @report_type=='hourly_report'
                             if @@hour <24
                                for k in @@hour...24
                                        @@strXML=@@strXML+  "<set name='#{k}'  value='0' />"
                                end
                              end
                              @@strXML+="<styles><definition><style name='myLabelsFont' type='font' font='Arial' size='12' color='000000' bold='1'/></definition><application><apply toObject='DataLabels' styles='myLabelsFont' /></application></styles>"
                        #following code is used to insert default value for Unique Visitor and Traffic Summary(summary report);
                        elsif @report_type=='Visitors' || (@report_type=='Traffic_summary' && args[4].to_s!='Impressions Vs Clicks')
                              if Time.parse(@enddate).strftime("%Y-%m-%d")>@@date_count.strftime("%Y-%m-%d")
                                   while Time.parse(@enddate).strftime("%Y-%m-%d")>=@@date_count.strftime("%Y-%m-%d")
                                          delivery_day=@@date_count.strftime("%Y-%m-%d").split('-')[2] #will return day
                                          if Time.parse(@enddate).strftime("%Y-%m-%d")==@@date_count.strftime("%Y-%m-%d")
                                                 @@strXML+= "<set name='#{@@date_count.strftime("%d-%b-%Y")}' value='0' #{@anchor_color if args[8].to_s=='0'}/>" 
                                          elsif delivery_day.to_i%@modulas==0 
                                                @@strXML+= "<set name='#{@@date_count.strftime("%d-%b-%Y")}' value='0'/>"
                                          end
                                          @@date_count+=86400
                                   end
                              elsif Time.parse(@enddate).strftime("%Y-%m-%d")==@@date_count.strftime("%Y-%m-%d")
                                     @@strXML+= "<set name='#{@@date_count.strftime("%d-%b-%Y")}' value='0' #{@anchor_color if args[8].to_s=='0'}/>" 
                              end
                              @@strXML+="<styles><definition><style name='myLabelsFont' type='font' font='Arial' size='12' color='000000' bold='1'/></definition><application><apply toObject='DataLabels' styles='myLabelsFont' /></application></styles>"
                              #to insert xml datas for impression vs click if recordsets are not available for specified date
                          elsif @report_type=='Traffic_summary' && args[4].to_s=='Impressions Vs Clicks'
                                if Time.parse(@enddate).strftime("%Y-%m-%d")>@@date_count.strftime("%Y-%m-%d")
                                     while Time.parse(@enddate).strftime("%Y-%m-%d")>=@@date_count.strftime("%Y-%m-%d")
                                            delivery_day=@@date_count.strftime("%Y-%m-%d").split('-')[2] #will return day
                                            if Time.parse(@enddate).strftime("%Y-%m-%d")==@@date_count.strftime("%Y-%m-%d") 
                                                   @@strXML+= "<set value='0' #{@anchor_color if args[8].to_s=='0'}/>"
                                                   @@cat_strXML+="<category label='#{@@date_count.strftime("%d-%b-%Y")}'/>"
                                                   @@multi_strXML+="<set value='0' #{@anchor_color if args[8].to_s=='0'}/>"
                                            elsif delivery_day.to_i%@modulas==0
                                                   @@strXML+= "<set value='0'/>"
                                                   @@cat_strXML+="<category label='#{@@date_count.strftime("%d-%b-%Y")}'/>"
                                                   @@multi_strXML+="<set value='0'/>"
                                            end
                                            @@date_count+=86400
                                     end
                                elsif Time.parse(@enddate).strftime("%Y-%m-%d")==@@date_count.strftime("%Y-%m-%d")
                                     @@strXML+= "<set value='0' #{@anchor_color if args[8].to_s=='0'} />"
                                     @@cat_strXML+="<category label='#{@@date_count.strftime("%d-%b-%Y")}'/>"
                                     @@multi_strXML+="<set value='0' #{@anchor_color if args[8].to_s=='0'} />"
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
                                
                              if @report_type=='Traffic_Continent'
                                @@strXML+='</data>'
                                @@strXML+="<colorRange><color minValue='0' maxValue='#{(@@date_count/3)}' displayValue='Low' color='A7FF98' /><color minValue='#{((@@date_count/3))}' maxValue='#{(@@date_count-(@@date_count/3))}' displayValue='Moderate' color='2CCE00' /><color minValue='#{(@@date_count-(@@date_count/3))}' maxValue='#{(@@date_count)+1}' displayValue='High' color='007700' /></colorRange></map>"
                              end
                              if @tablename=='pub_keywords'
                                  @@strXML+="<styles><definition><style name='myValuesFont' type='font' size='16' color='000000' bold='1' font='Arial, Helvetica, sans-serif' /></definition><application><apply toObject='DataLabels'  styles='myValuesFont' /></application></styles>"
                                end
                              if @report_type=='Pie_chart'
                                  @@strXML+="<styles><definition><style name='myLabelsFont' type='font' font='Arial' size='14' color='404040' bold='0'/></definition><application><apply toObject='DataLabels' styles='myLabelsFont' /></application></styles>" 
                              end
                               @@strXML = @@strXML + "</chart>" if  @report_type!='Traffic'and @report_type!='Traffic_Continent'
                    else
                      #@@strXML="<chart chartTopMargin='1' chartLeftMargin='1' caption='Traffic'  decimalPrecision='0' bgColor='ffffff'    xAxisName='Days' yAxisName='#{args[4]}' showNames='1' rotateNames='1' labelDisplay='ROTATE' alternateHGridAlpha='40' numDivLines='5' divLineColor='CCCCCC' divLineThickness='1' alternateHGridColor='CCCCCC' showBorder='0'>" if  @report_type!='Traffic'and @report_type!='Traffic_Continent'
                     # @@strXML+= "<set name='No Data' value='0' color='666666'/>"
                   end #sub main If ends here
                end #main if ends here
                   #reinitialize flag, str variable and counters to construct next chart.
                    @@flag=true   
                    @@hour=0
                    @@mod=0
                    @@color_count=0
                    @@date_count=0
                    @returnstrXML=@@strXML #assigns chart string to instance varaible and reintialize the chart_class variable.
                    @@strXML=''  
                    @@cat_strXML=''
                    @@multi_strXML=''
                    @@xml_hash=nil
                    @@xml_hash={:xml_string=>@returnstrXML,:xml_array=>@@XML_array }
                    return @@xml_hash
                    
              rescue Exception=>e
                   puts "ERROR :: in ReportGenerator Component and generate_query method. The error is #{e.to_s}"
              end
        end # generate_query ends here
        #this method is used to construct xml structure based on the recordset retrived from the database
        #args[0]=> return impressions
        #args[1]=> return hours
        def generate_hourlyXML(*args)
          begin
             if @@flag==true
                   @@strXML = "<chart connectNullData='1' numDivLines='2' alternateHGridColor='FFFFFF' divLineColor='CCCCCC' xAxisNamePadding='3' chartBottomMargin='5' lineColor='0C95BF' anchorSides='8' anchorRadius='4' anchorBgColor='0C95BF' anchorBorderColor='FFFFFF' anchorBorderThickness='1' labelStep='2' showValues='0' canvasBorderColor ='F2F2F2' canvasBorderThickness='1' canvasBorderAlpha='0' baseFontSize ='12' chartTopMargin='10' chartLeftMargin='1' chartRightMargin='35' bgColor='ffffff'    xAxisName='Hours - GMT' yAxisName='Impressions' showNames='1' numDivLines='0'  numVDivLines='0' showBorder='0' formatNumberScale='0'> "
                   @@flag=false
              end
              if args[1].to_i > @@hour.to_i
                    for j in @@hour...args[1].to_i
                       @@strXML=@@strXML+  "<set name='#{j}'  value='0' />"  #inserts default zero values if records are not avaible for a particular hour
                     end
                    @@strXML=@@strXML+  "<set name='#{args[1]}' value='#{args[0]}'/>" # insert impression values .
                    @@hour=(args[1].to_i)+1
              elsif args[1].to_i==@@hour
                    @@strXML=@@strXML+  "<set name='#{args[1]}' value='#{args[0]}'/>"
                    @@hour=(args[1].to_i)+1 #increment counter.
              end
              
            rescue Exception=>e
                 puts "ERROR :: in ReportGenerator Component and generate_hourlyXML method. The error is #{e.to_s}"
            end
        end
        
      #this method is used to construct xml structure for piechart
      #args[0]=> returns sum(demographic, keyword,devices,url)
      #args[1]=> returns demographic,device,url or keyword name
      #args[2]=>return first_column for camparing
      #args[3] return percentage value for keyword's bar chart
      def generate_piechartXML(*args)
          begin
              #color_hash is used to store default colors for pie-chart
              @aes = AESSecurity.new()
              @color_hash=Hash.new
              @keywordcolor_hash=Hash.new
              @pieRadius="pieRadius='100'"
              @color_hash={"0"=>"0C95BF","1"=>"12C400","2"=>"ECB800","3"=>"EB2300","4"=>"70808F","5"=>"000000","6"=>"800080","7"=>"FFFF00","8"=>"0377CA"}
              if @@flag==true   #checks whether the flag is true to add root xml element.
                   @@strXML = "<chart decimals='2' defaultAnimation='0' use3DLighting='0' showPlotBorder='1' plotGradientColor='' showShadow='0'  showLabels='#{args[3]}' chartTopMargin='0' chartLeftMargin='0' chartRightMargin='0' chartBottomMargin='0' showValues='#{args[3]}'  decimals='0' isSliced='0' enableSmartLabels='#{args[3]}'  bgColor='FFFFFF'  showBorder='0' plotBorderThickness='0' showPercentageValues='1' #{args[3].to_i==1 ? @pieRadius : ""}  >" if args[2]!='keywords'&& args[2]!='url' # this root xml element is used only for channel and handset pie-chart.
                   @@flag=false #set flag as false
                 end
              key='rh21nr8e0vav0h0v'
              iv='1pnee1ng36nuare8'
              getsymbol={"&"=>"%7E","%"=>"%25"}
             args[0]=(args[0]=='' || args[0]==nil) ? 'Unknown' : args[0]
             #url_model=(args[2]=='handset') ? (args[0]!='Others' && args[0]!='Unknown') ? "link='/#{args[4]}/publisher_handset_model%3Fhandset=#{args[0].to_s.gsub(/([&%])/) do|s| getsymbol["#{s}"] end}'" : ""  : ""
             colour=@color_hash["#{@@color_count}"] #get the color 
             @@strXML+="<set label='#{args[0].to_s.gsub(/([&%])/) do|s| @@getsymbol["#{s}"] end}' value='#{args[1].to_s}' color='#{colour.to_s}'/>" if args[2]!='url'
             @@date_count+=args[1].to_i #increment the counter value
             @@XML_array[@@color_count]=["#{args[0]}",args[1].to_i,colour,@@date_count] if args[2]!='handset_model'  #store the label,value and color in the array 
             @@color_count+=1
                   
          rescue Exception=>e
               puts "ERROR :: in ReportGenerator Component and generate_piechartXML method. The Error is #{e.to_s}"
          end
        end
        
          #This method is used to construct xml structure for unique visitor and Traffic summary .
          #args[0] returns no of clicks, impression, ctr or revenue
          #args[1] returns delivery date
          #args[2] returns start date
          #args[3] returns enddate
          #args[4] returns y axis labelname
          #args[5] returns no of recordset to calculate modulas
          #args[6] returns period (duration)
         #  generate_linechartXML(recordset[args[4]],recordset.delivery_date,@startdate,@enddate.to_i,args[4].capitalize,@no_day,args[8])
        def generate_linechartXML(*args)
          begin
               if @@flag==true
                      @@mod=args[5].to_i
                      @@mod=@@mod/30 >0 ? @@mod/30 : 1
                      @labelstep=args[4].to_s=='Visitors' ? args[5].to_i/(@@mod*4) : args[5].to_i/(@@mod*6)
                      @@strXML="<chart decimals='2' connectNullData='1' lineDashGap='6' labelDisplay='WRAP' lineColor ='0C95BF' anchorSides='10' anchorRadius='4' anchorBgColor='0C95BF' anchorBorderColor='FFFFFF' anchorBorderThickness='1' labelStep='#{@labelstep.to_s}' numDivLines='2' alternateHGridColor='FFFFFF' divLineColor='CCCCCC'  numVDivLines='0' showLabels='1' showValues='0' canvasBorderColor ='FFFFFF' canvasBorderAlpha='0' canvasBorderThickness='0'  baseFontSize ='12' chartTopMargin='8' chartLeftMargin='1'  decimalPrecision='0' bgColor='ffffff' xAxisName='' yAxisName='#{args[4].to_s}' showNames='1' showBorder='0' chartRightMargin='35' formatNumberScale='0'>" 
                      @@flag=false
                    end
                    @anchor_color="anchorBgColor='FF0000'"
                    @delivery_date=args[1].to_s
                    @delivery_date=Time.parse(@delivery_date)
                  if @delivery_date.strftime("%Y-%m-%d")>@@date_count.strftime("%Y-%m-%d")
                        while @delivery_date.strftime("%Y-%m-%d")>@@date_count.strftime("%Y-%m-%d")
                              delivery_day=@@date_count.strftime("%Y-%m-%d").split('-')[2] #will return day
                              if @@date_count==Time.parse(args[2])
                                   @@strXML+= "<set name='#{@@date_count.strftime("%d-%b-%Y")}' value='0' />"
                              elsif delivery_day.to_i%@@mod==0
                                   @@strXML+= "<set name='#{@@date_count.strftime("%d-%b-%Y")}' value='0' />"
                             end
                            @@date_count+=86400
                          end
                          args[0]=(args[0]==nil || args[0]=='') ? "0" : args[0]
                          @@strXML+= "<set name='#{@@date_count.strftime("%d-%b-%Y")}' value='#{args[0].to_s}' #{@anchor_color if (args[6].to_s=='0' and Time.parse(args[3]).strftime("%d-%b-%Y")==@@date_count.strftime("%d-%b-%Y"))}/>" 
                          @@date_count+=86400
                  elsif @delivery_date.strftime("%Y-%m-%d")==@@date_count.strftime("%Y-%m-%d")
                           args[0]=(args[0]==nil || args[0]=='') ? "0" : args[0]
                           @@strXML+= "<set name='#{@@date_count.strftime("%d-%b-%Y")}' value='#{args[0].to_s}' #{@anchor_color if (args[6].to_s=='0' and Time.parse(args[3]).strftime("%d-%b-%Y")==@@date_count.strftime("%d-%b-%Y"))}/>" 
                           @@date_count+=86400
                  end
            rescue Exception=>e
                  puts "ERROR :: in ReportGenerator Component and generate_linechartXML method.The Error is #{e.to_s}"
            end
        end  #generatelinechartXML ends here
                
                #This method is used to construct xml structure for all continent map
                 #args[0]=>returns continent code
                 #args[1]=>returns sum traffic for a particular continent
                 #args[2]=>returns report_type
                 #args[3]=> returns publisher id
                 #args[4]=> returns adclient id
                 #args[5]=> returns controller name
                def generate_contmapXML(*args)
                  begin
                         @continent={"AS"=>"01","EU"=>"02","AF"=>"03","NA"=>"04","SA"=>"05","CA"=>"06","OC"=>"07","ME"=>"08"}
                         @aes = AESSecurity.new()
                         if @@flag==true
                              @@strXML="<map hoverColor='01B401' formatNumberScale='0' useSNameInLabels='0' showCanvasBorder='0' includeValueInLables='0'  showPercentageValues='1' fillColor='FFFFFF' defaultAnimation='0' showShadow='0' showBevel='0' leftMargin='5' ><data>"
                              @@flag=false
                              @@date_count=args[1].to_i
                            end
                            #following code is used to get the maximum traffic, that is being used for range.
                         if @@date_count<args[1].to_i
                              @@date_count=args[1].to_i
                            end
                            # continent_name=@continent["#{args[0]}"]
                            key='aditztd04azd4ezt'
                            iv='t0sez4e0sntgtt0s'
                            ccode=@continent["#{args[0]}"]
                              @@strXML+="<entity id='#{ccode}' value='#{args[1].to_s}' link='/#{args[5].to_s}/traffic_country%3Fid=#{args[0]}/#{@aes.encrypt(key,iv,"#{args[3]}")}/#{args[4]}' />" if args[1].to_i > 0
                   rescue Exception=>e
                   puts "ERROR :: in ReportGenerator Component :: generate_contmapXML method :: #{e.to_s}"
                   end
                 end #contmapXML ends here
                 
                 #This method is used to construct xml structure for particular continent
                 #args[0]=>returns country code
                 #args[1]=>returns sum traffic for a particular continent
                 #args[2]=>returns report_type
                 #args[3]=> returns continent code
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
                            @@strXML="<map defaultAnimation='0' useSNameInLabels='1' showShadow='0' showBevel='0' hoverColor='01B401' formatNumberScale='0' showCanvasBorder='0' fillColor='FFFFFF' leftMargin='5'><data>"
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
                           
                            @@strXML+="<entity id='#{ccode.to_s}' value='#{args[1].to_s}' />" if args[1].to_i > 0
                    rescue Exception=>e
                          puts "ERROR :: in ReportGenerator Component :: generate_continentXML method :: #{e.to_s}"
                    end
                end # generate continent xml method ends here
                 
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
                        @@mod=@@mod/30 >0 ? @@mod/30 : 1
                        @labelstep=args[6].to_i/(@@mod*6)
                         #following code is used to root element of xml
                        @@strXML="<chart decimals='2' formatNumberScale='0'  connectNullData='1' lineDashGap='6' labelStep='#{@labelstep.to_s}' numDivLines='3' alternateHGridColor='FFFFFF' divLineColor='F3F3F3'  numVDivLines='0'  showLabels='1' showValues='0' canvasBorderColor ='F2F2F2' canvasBorderAlpha='0' canvasBorderThickness='0' baseFontSize ='12' chartTopMargin='10' chartLeftMargin='1' chartRightMargin='35' decimalPrecision='0' bgColor='ffffff'    xAxisName='' yAxisName='Impressions Vs Clicks' showNames='1' showBorder='0' lineThickness='4' >" 
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
                          @@cat_strXML+="<category label='#{@@date_count.strftime("%d-%b-%Y")}' />"
                          @@multi_strXML+="<set value='#{args[1].to_s}' #{@anchor_color if args[7].to_s=='0' and Time.parse(args[4]).strftime("%Y-%m-%d")==@@date_count.strftime("%Y-%m-%d")} />"
                          @@date_count+=86400
                      elsif @delivery_date.strftime("%Y-%m-%d")==@@date_count.strftime("%Y-%m-%d")
                            @@strXML+=  "<set value='#{args[0].to_s}' #{@anchor_color if args[7].to_s=='0' and Time.parse(args[4]).strftime("%Y-%m-%d")==@@date_count.strftime("%Y-%m-%d")}/>"
                            @@cat_strXML+="<category label='#{@delivery_date.strftime("%d-%b-%Y")}'/>"
                            @@multi_strXML+="<set value='#{args[1].to_s}' #{@anchor_color if args[7].to_s=='0' and Time.parse(args[4]).strftime("%Y-%m-%d")==@@date_count.strftime("%Y-%m-%d")}/>"
                            @@date_count+=86400
                      end
            rescue Exception=>e
                 puts "ERROR :: in ReportGenerator Component and generate_mutil_linechartXML. The error is :: #{e.to_s}"
            end
          end #generate_mutil_linechartXML method ends here
          
          def performance_summary(*args)
              begin
                  @adclient_type=(args[1]!='SMS' and args[1]!='WAP')? " and client_id=#{args[1]}" : " and ad_client_type='#{args[1].upcase}'"
                  #sub_query="/(select count(*) from adclients_summaries  where pub_id =#{args[0].to_s}  and delivery_date>='#{(Time.parse(args[2])).strftime("%Y-%m-%d")} 00:00:00' and  delivery_date<='#{(Time.parse(args[3])).strftime("%Y-%m-%d")} 23:59:59' #{@adclient_type}  )"
                  query="select #{args[4]=='filled' ? "sum(impressions)" : args[4]=='unfilled' ? "sum(fill_rate)" : "(sum(impressions)+sum(fill_rate))"} as sum_impressions,"
                  query+="sum(clicks) as sum_clicks,"
                  query+="((sum(clicks)/#{args[4]=='filled' ? "sum(impressions)" : args[4]=='unfilled' ? "sum(fill_rate)" : "(sum(impressions)+sum(fill_rate))"})*100)  as sum_ctr,sum(revenue) as sum_revenue,((sum(revenue)/#{args[4]=='filled' ? "sum(impressions)" : args[4]=='unfilled' ? "sum(fill_rate)" : "(sum(impressions)+sum(fill_rate))"})*1000) as sum_ecpm,pub_id" 
                  query+=" from adclients_summaries "
                  query+=" where pub_id =#{args[0].to_s}" 
                  query+="#{@adclient_type}"
                  query+=" and delivery_date>='#{(Time.parse(args[2])).strftime("%Y-%m-%d")}' and delivery_date<='#{(Time.parse(args[3])).strftime("%Y-%m-%d")}'" if args[2]!=nil and args[2]!="" and args[3]!=nil and args[3]!=""
                  query+=" group by client_id" if args[1]!='WAP' and args[1]!='SMS'
                  query+=" group by pub_id" if args[1]=='WAP' ||args[1]=='SMS'
                  @recordset=AdclientsSummary.find_by_sql(query) 
                return @recordset
               
              rescue Exception=>e
              puts "ERROR :: in performace_summary method of ReportGenerator Component. The error is :: #{e.to_s}"
              end
          end
          
       
    rescue Exception=>e
        puts "ERROR :: in ReportGenerator Component and the error is :: #{e.to_s}"
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
