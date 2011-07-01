
#/*
# * Reports.rb
# *
# * Author :Asif Ali,Dipti Uppal, and Md Shujauddeen
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
require 'csv'
require 'fastercsv/lib/faster_csv'
require 'aes_security.rb' #this is to require AES security component
#require 'publisher_xml_builder.rb'
@@obj = PublisherXmlBuilder.new()
@@obj1 = PublisherXml.new()
#--------------------------------------------------------------------------------------------
  #Class Name: PublisherAnalyticController
  #Purpose: This Class is used to generate XML and Array's for all the publisher Charts.
  #Version: 1.0
  #Author:Md Shujauddeen A
  #Last Modified:
  #Notes: None.
#-------------------------------------------------------------------------------------------- .

class PublisherAnalyticController < ApplicationController
  
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#Method Name: index
	#Purpose: redirecting to publisher analytic home page.
	#Version: 1.0
	#Author: Md Shujauddeen A
	#Last Modified: 20-Oct-2008 by Md Shujauddeen A
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	def index
		redirect_to :action=>'publisher_home',:analytic=>'refresh'
	end
  
  #--------------------------------------------------------------------------------------------
  #Method Name: publisher_home
  #Purpose: this method is used to display publisher homepage with all the charts
  #Version: 1.0
  #Author:Md Shujauddeen A
  #Last Modified: 24-Oct-2008 by Md Shujauddeen
  #Notes: None.
#-------------------------------------------------------------------------------------------- 
      def publisher_home
        begin
              @aes = AESSecurity.new() #creating an object for AES Security
              if (session[:user_id]==nil)
                  flash[:notice]="Your session has expired. Please login again."
                  redirect_to :controller=>'login', :action=>'login'
              else
                  if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
                      #initialize start and end date
                      #~ @handset_data=PublisherHandsetOverview.handset_data(session[:pub_id],"table",0)
                       @enddate=(params[:edate]!=nil && params[:edate]!='') ? Time.parse(params[:edate]).strftime("%d-%b-%Y") : (Time.now-86400).strftime("%d-%b-%Y") 
                       @startdate=(params[:sdate]!=nil && params[:sdate]!='') ? Time.parse(params[:sdate]).strftime("%d-%b-%Y") : (Time.now-86400).strftime("%d-%b-%Y")
                        @analytic=params[:analytic]
                       user_id = @aes.decrypt(session[:key],session[:iv],session[:user_id])
                       verifyDBconnection
                       user_info=User.find_by_id(user_id)
                      @check_access=user_info.access_on_analytics
                      @publisher_id=Publisher.find_by_sql("select id from publishers where user_id=#{user_id}")
                      session[:pub_id]=@publisher_id[0].id
                        #retrieve the adclient list from the database
                        @adclient_list=Adclient.find_by_sql("select id, app_name from adclients where publisher_id=#{@publisher_id[0].id} and status!='Deleted'")
                        if @analytic=='refresh'
                          redirect_to :action=>'generate_report_test',:adclient_dropdown=>params[:site_id]!=nil ? params[:site_id] : @aes.encrypt(session[:key],session[:iv],'WAP'),:pub_start_on=>@startdate,:pub_end_on=>@enddate,:duration=>(params[:duration]!=nil && params[:duration]!='') ? params[:duration].to_s : '1',:filled=>'filled'
                        end
                       @adclient_summary= @@obj1.performance_summary(session[:pub_id],session[:report_adclient]!=nil ? session[:report_adclient] : 'WAP' ,session[:report_start_on]!=nil ? session[:report_start_on] : @startdate ,session[:report_end_on]!=nil ? session[:report_end_on] : @enddate,session[:filled])
                       @summry_report = session[:xml_string] #retrieves the hash from the session
                  else
                      flash[:notice]="Your are not an authorized user. Please login with different username."
                      redirect_to :controller=>'login', :action=>'login'
                  end
              end
        rescue Exception=>e
                puts "DEBUG :: ERROR :: in Publisher analytic controller :: publisher_home method :: #{e.to_s}"
       end
     end
  #--------------------------------------------------------------------------------------------
  #Method Name: publisher_handset
  #Purpose:this method to construct publisher handset chart
  #Version: 1.0
  #Author:Md Shujauddeen A
  #Last Modified: 15-Oct-2008 by Md Shujauddeen
  #Notes: None.
 #-------------------------------------------------------------------------------------------- 
      def publisher_handset
          begin
          @aes = AESSecurity.new() #creating an object for AES Security
              if (session[:user_id]==nil)
                  flash[:notice]="Your session has expired. Please login again."
                  redirect_to :controller=>'login', :action=>'login'
              else
                  if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
                       # @handset_report = session[:xml_string]
                        @smartLable='1' #1 represent smartLable as Enabled
                        @XML_handset_report=@@obj1.generate_query_data("#{session[:pub_id]}-#{session[:filled]}",'publisher_handset_overviews','Pie_chart','device','requests',session[:report_adclient],session[:report_start_on],session[:report_end_on],@smartLable,'publisher_analytic','',"report")
                        #initialize start and end date
                        @startdate=Time.parse(session[:report_start_on]).strftime('%Y-%m-%d')
                        @enddate=Time.parse(session[:report_end_on]).strftime('%Y-%m-%d')
                        @page= params[:page]
                        verifyDBconnection
                        #~ filter_column=session[:filled]=='filled' ? "and impressions>0" : session[:filled]=='unfilled' ? "and fill_rate>0" : "and (impressions>0 or fill_rate>0)"
                        @adclient_type=(session[:report_adclient]!='SMS' and session[:report_adclient]!='WAP')? " and client_id=#{session[:report_adclient]}" : ""
                        query="select device,requests,traffic from publisher_handset_overviews where publisher_id=#{session[:pub_id]} and date='2011-06-05' group by device order by requests desc" 
                        #following code is used to retrive recordset from database.
                        @handsetdata_pages, @handsetdata = paginate_by_sql PublisherHandsetOverview,query,10
                        render :action =>'publisher_handset' 
                    else
                        flash[:notice]="Your are not an authorized user. Please login with different username."
                        redirect_to :controller=>'login', :action=>'login'
                    end
                end
          rescue Exception=>e
              puts "DEBUG :: ERROR :: in Publisher analytic controller :: publisher_handset method :: #{e.to_s}"
            end
            
        end
      #--------------------------------------------------------------------------------------------
      #Method Name: publisher_channel
      #Purpose: this method is used to construct publisher channel chart
      #Version: 1.0
      #Author:Md Shujauddeen A
      #Last Modified: 15-Oct-2008 by Md Shujauddeen
      #Notes: None.
     #-------------------------------------------------------------------------------------------- 
      def publisher_channel
             begin
                  @aes = AESSecurity.new() #creating an object for AES Security
                  if (session[:user_id]==nil)
                      flash[:notice]="Your session has expired. Please login again."
                      redirect_to :controller=>'login', :action=>'login'
                  else
                      if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
                        puts "publisher_channel"
                          @smartLable='1' #1 represent smartLable as Enabled
                          @XML_channel_report=@@obj1.generate_query_data("#{session[:pub_id]}-#{session[:filled]}",'publisher_traffic_channel_overviews','Pie_chart','channel','traffic',session[:report_adclient],session[:report_start_on], session[:report_end_on],@smartLable,'publisher_analytic','',"report")
                          @adclient_type=(session[:report_adclient]!='SMS' and session[:report_adclient]!='WAP')? " and client_id=#{session[:report_adclient]}" : " and (ad_client_type='#{session[:report_adclient].upcase}' or ad_client_type='#{session[:report_adclient].downcase}')"
                          @channel_report = session[:xml_string]  #get the xml string hash from the session.
                          #initialize start and end date.
                          @startdate=Time.parse(session[:report_start_on]).strftime('%Y-%m-%d')
                          @enddate=Time.parse(session[:report_end_on]).strftime('%Y-%m-%d')
                          @page= params[:page]
                          verifyDBconnection
                          #frame query to retrive demographic data from database
                          #~ filter_column=session[:filled]=='filled' ? "and requests>0" : session[:filled]=='unfilled' ? "and fill_rate>0" : "and (requests>0 or fill_rate>0)"
                          #~ sub_query="select  #{session[:filled]=='filled' ? "sum(requests)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(requests)+sum(fill_rate))"} from pub_channels where pub_id =#{session[:pub_id]} and delivery_date>='#{(Time.parse(@startdate)).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(@enddate)).strftime("%Y-%m-%d")} 23:59:59' #{filter_column}"  
                          #~ sub_query+=" #{@adclient_type}"
                          #~ query= "select channel, #{session[:filled]=='filled' ? "sum(requests)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(requests)+sum(fill_rate))"} as sum_requests,(#{session[:filled]=='filled' ? "sum(requests)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(requests)+sum(fill_rate))"}/(#{sub_query})*100) as channel_percentage from pub_channels where pub_id =#{session[:pub_id]} and delivery_date>='#{@startdate} 00:00:00' and delivery_date<='#{@enddate} 23:59:59' #{filter_column}" 
                          #~ query+=" #{@adclient_type}"
                          #~ query+= " group by channel order by sum_requests desc"
                          query="select traffic,channel from publisher_traffic_channel_overviews where publisher_id=#{session[:pub_id]}"
                          #following code is used to retrive recordset from database
                          @channeldata_pages, @channeldata = paginate_by_sql PublisherTrafficChannelOverview,query,10
                      else
                            flash[:notice]="Your are not an authorized user. Please login with different username."
                            redirect_to :controller=>'login', :action=>'login'
                      end
                  end
            rescue Exception=>e
                  puts "DEBUG :: ERROR :: in Publisher analytic controller :: publisher_channel method :: #{e.to_s}"
            end
          end
      #--------------------------------------------------------------------------------------------
      #Method Name: publisher_carriers
      #Purpose: this method is used to construct publisher carrier chart
      #Version: 1.0
      #Author:Md Shujauddeen A
      #Last Modified: 12-Aug-2009 by Md Shujauddeen
      #Notes: None.
     #-------------------------------------------------------------------------------------------- 
      def publisher_carriers
          begin
             @aes = AESSecurity.new() #creating an object for AES Security
              if (session[:user_id]==nil)
                  flash[:notice]="Your session has expired. Please login again."
                  redirect_to :controller=>'login', :action=>'login'
              else
                    if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
                        @smartLable='1' #1 represent smartLable as Enabled
                        @XML_carrier_report=@@obj1.generate_query_data("#{session[:pub_id]}-#{session[:filled]}",'publisher_traffic_carrier_overviews','Pie_chart','carrier','traffic',session[:report_adclient],session[:report_start_on], session[:report_end_on],@smartLable,'publisher_analytic','',"report")
                        #initialze start and end date
                        @startdate=Time.parse(session[:report_start_on]).strftime('%Y-%m-%d')
                        @enddate=Time.parse(session[:report_end_on]).strftime('%Y-%m-%d')
                        @page= params[:page]
                        verifyDBconnection
                        filter_column=session[:filled]=='filled' ? "and requests>0" : session[:filled]=='unfilled' ? "and fill_rate>0" : "and (requests>0 or fill_rate>0)"
                        @adclient_type=(session[:report_adclient]!='SMS' and session[:report_adclient]!='WAP')? " and client_id=#{session[:report_adclient]}" : " and (ad_client_type='#{session[:report_adclient].upcase}' or ad_client_type='#{session[:report_adclient].downcase}')"
                        #frame query to retrive keyword data from database
                        sql="select carrier,traffic from publisher_traffic_carrier_overviews where publisher_id='#{session[:pub_id]}'"
                        @carriers_pages, @carriers = paginate_by_sql AdvCarrier,sql,10      
                     else
                          flash[:notice]="Your are not an authorized user. Please login with different username."
                          redirect_to :controller=>'login', :action=>'login'
                      end
                 end
          rescue Exception=>e
              puts "DEBUG :: ERROR :: in Publisher analytic controller :: publisher_carriers method :: #{e.to_s}"
          end
      end
        #--------------------------------------------------------------------------------------------
        #Method Name: publisher_visitor
        #Purpose: this method is used to construct publisher unique visitor chart
        #Version: 1.0
        #Author:Md Shujauddeen A
        #Last Modified:14-Oct-2008 by Md Shujauddeen
        #Notes: None.
       #-------------------------------------------------------------------------------------------- 
        def publisher_visitor
          begin
              @aes = AESSecurity.new() #creating an object for AES Security
              if (session[:user_id]==nil)
                  flash[:notice]="Your session has expired. Please login again."
                  redirect_to :controller=>'login', :action=>'login'
              else
                  if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
                      #initialize start and end daste
                      @startdate=Time.parse(session[:report_start_on]).strftime('%Y-%m-%d')
                      @enddate=Time.parse(session[:report_end_on]).strftime('%Y-%m-%d')
                      @page= params[:page]
                      verifyDBconnection
                      @xml_unique_visitors=@@obj1.generate_query_data("#{session[:pub_id]}-#{session[:filled]}",'publisher_unique_visitor_overviews','Visitors','delivery_date','requests',session[:report_adclient],session[:report_start_on], session[:report_end_on],session[:duration],'publisher_analytic','',"report")
                      @adclient_type=(session[:report_adclient]!='SMS' and session[:report_adclient]!='WAP')? " and client_id=#{session[:report_adclient]}" : " and (ad_client_type='#{session[:report_adclient].upcase}' or ad_client_type='#{session[:report_adclient].downcase}')"
                      #frame query to retrive unique visitor recordset from database
                      filter_column=session[:filled]=='filled' ? "and impressions>0" : session[:filled]=='unfilled' ? "and fill_rate>0" : "and (impressions>0 or fill_rate>0)"
                      #~ sub_query="select  #{session[:filled]=='filled' ? "sum(requests_unique_visitors)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(requests_unique_visitors)+sum(fill_rate))"} from adclients_summaries where pub_id =#{session[:pub_id]} and delivery_date>='#{(Time.parse(@startdate)).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(@enddate)).strftime("%Y-%m-%d")} 23:59:59' #{filter_column}" 
                      #~ sub_query+=" #{@adclient_type}"
                      #~ query= "select date_format(delivery_date,'%Y/%m/%d') as delivered_date, #{session[:filled]=='filled' ? "sum(requests_unique_visitors)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(requests_unique_visitors)+sum(fill_rate))"} as sum_visitor,(#{session[:filled]=='filled' ? "sum(requests_unique_visitors)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(requests_unique_visitors)+sum(fill_rate))"}/(#{sub_query})*100) as visitor_percentage from adclients_summaries where pub_id =#{session[:pub_id]} and delivery_date>='#{@startdate} 00:00:00' and Delivery_Date<='#{@enddate} 23:59:59' #{filter_column}" 
                      #~ query+= " #{@adclient_type}"
                      #~ query+= " group by delivery_date"
                      #following code is used to retrive visitor recordset from databse
                      query="select traffic,channel from publisher_traffic_channel_overviews where publisher_id='#{session[:pub_id]}'"
                      @visitordata_pages, @visitordata = paginate_by_sql PublisherTrafficChannelOverview,query,10
                 else
                    flash[:notice]="Your are not an authorized user. Please login with different username."
                    redirect_to :controller=>'login', :action=>'login'
                end
            end
          rescue Exception=>e
              puts "DEBUG :: ERROR :: in Publisher analytic controller :: publisher_visitor method :: #{e.to_s}"
            end
          
        end
      #--------------------------------------------------------------------------------------------
      #Method Name: publisher_url
      #Purpose: this method is used to construct publisher url chart
      #Version: 1.0
      #Author:Md Shujauddeen A
      #Last Modified: 14-Oct-2008 by Md Shujauddeen
      #Notes: None.
     #-------------------------------------------------------------------------------------------- 
    def publisher_url
         begin
               @aes = AESSecurity.new() #creating an object for AES Security
              if (session[:user_id]==nil)
                  flash[:notice]="Your session has expired. Please login again."
                  redirect_to :controller=>'login', :action=>'login'
              else
                  if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
                      #initialize start and end date.
                      @startdate=Time.parse(session[:report_start_on]).strftime('%Y-%m-%d')
                      @enddate=Time.parse(session[:report_end_on]).strftime('%Y-%m-%d')
                      @page= params[:page]
                      verifyDBconnection
                      #frame query to retrive publisher url recordset from the database.
                      filter_column=session[:filled]=='filled' ? "and requests>0" : session[:filled]=='unfilled' ? "and fill_rate>0" : "and (requests>0 or fill_rate>0)"
                      @adclient_type=(session[:report_adclient]!='SMS' and session[:report_adclient]!='WAP')? " and client_id=#{session[:report_adclient]}" : ""
                      sub_query="select  #{session[:filled]=='filled' ? "sum(requests)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(requests)+sum(fill_rate))"} from pub_urls where pub_id =#{session[:pub_id]} and delivery_date>='#{(Time.parse(@startdate)).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(@enddate)).strftime("%Y-%m-%d")} 23:59:59' #{filter_column}" 
                      sub_query+=" #{@adclient_type}"
                      query= "select url, #{session[:filled]=='filled' ? "sum(requests)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(requests)+sum(fill_rate))"} as sum_url,(#{session[:filled]=='filled' ? "sum(requests)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(requests)+sum(fill_rate))"}/(#{sub_query})*100) as url_percentage from pub_urls where pub_id =#{session[:pub_id]} and delivery_date>='#{@startdate} 00:00:00' and delivery_date<='#{@enddate} 23:59:59' #{filter_column}" 
                      query+= " #{@adclient_type}"
                      query+= " group by url order by sum_url desc"
                      #following code is used to retrive url data from the database.
                     @urldata_pages, @urldata = paginate_by_sql PubUrl,query,10
                  else
                      flash[:notice]="Your are not an authorized user. Please login with different username."
                      redirect_to :controller=>'login', :action=>'login'
                  end
              end
        rescue Exception=>e
              puts "DEBUG :: ERROR :: in Publisher analytic controller :: publisher_url method :: #{e.to_s}"
        end
      end
    #--------------------------------------------------------------------------------------------
      #Method Name: publisher_hourly_traffic
      #Purpose: this method is used to construct publisher hourly traffic chart
      #Version: 1.0
      #Author:Md Shujauddeen A
      #Last Modified: 14-Oct-2008 by Md Shujauddeen
      #Notes: None.
     #-------------------------------------------------------------------------------------------- 
    def publisher_hourly_traffic
        begin
            @aes = AESSecurity.new() #creating an object for AES Security
            if (session[:user_id]==nil)
                flash[:notice]="Your session has  expired. Please login again."
                redirect_to :controller=>'login', :action=>'login'
            else
                if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
                    #initialize start and end date.
                    @startdate=Time.parse(session[:report_start_on]).strftime('%Y-%m-%d')
                    @enddate=Time.parse(session[:report_end_on]).strftime('%Y-%m-%d')
                    @page= params[:page]
                    verifyDBconnection
                    @xml_hourly_report=@@obj.generate_query("#{session[:pub_id]}-#{session[:filled]}",'adclients_summaries','hourly_report','delivery_hour','impressions',session[:report_adclient],session[:report_start_on],session[:report_end_on],'','publisher_analytic','')
                    @adclient_type=(session[:report_adclient]!='SMS' and session[:report_adclient]!='WAP')? " and client_id=#{session[:report_adclient]}" : " and (ad_client_type='#{session[:report_adclient].upcase}' or ad_client_type='#{session[:report_adclient].downcase}')"
                    filter_column=session[:filled]=='filled' ? "and impressions>0" : session[:filled]=='unfilled' ? "and fill_rate>0" : "and (impressions>0 or fill_rate>0)"
                    #frame sql query to retrive hourly traffic data from database..
                    sub_query="select #{session[:filled]=='filled' ? "sum(impressions)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(impressions)+sum(fill_rate))"} from adclients_summaries where pub_id =#{session[:pub_id]} and delivery_date>='#{(Time.parse(@startdate)).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(@enddate)).strftime("%Y-%m-%d")} 23:59:59' #{filter_column}" 
                    sub_query+=" #{@adclient_type}"
                    query= "select delivery_hour, #{session[:filled]=='filled' ? "sum(impressions)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(impressions)+sum(fill_rate))"} as sum_impressions,(#{session[:filled]=='filled' ? "sum(impressions)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(impressions)+sum(fill_rate))"}/(#{sub_query})*100) as hourly_percentage from adclients_summaries where pub_id =#{session[:pub_id]} and delivery_date>='#{@startdate} 00:00:00' and delivery_date<='#{@enddate} 23:59:59' #{filter_column}" 
                    query+= "#{@adclient_type}"
                    query+= " group by delivery_hour"
                    #following code is use to get the hourly traffic recordset from the database
                    @hourlydata_pages, @hourlydata = paginate_by_sql AdclientsSummary,query,24
                 else
                    flash[:notice]="Your are not an authorized user. Please login with different username."
                    redirect_to :controller=>'login', :action=>'login'
                end
            end
        rescue Exception=>e
              puts "DEBUG :: ERROR :: in Publisher analytic controller :: publisher_hourly_traffic method :: #{e.to_s}"
        end
    end
     #--------------------------------------------------------------------------------------------
      #Method Name: publisher_traffic
      #Purpose: this method is used to construct publisher traffic (continent wise) map
      #Version: 1.0
      #Author:Md Shujauddeen A
      #Last Modified: 14-Oct-2008 by Md Shujauddeen
      #Notes: None.
     #-------------------------------------------------------------------------------------------- 
   def publisher_traffic
       begin
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
                  #define and initialize an hash to get Contient name based on contient code.
                  @continent=@continent={"SA"=>"South America","NA"=>"North America","AS"=>"Asia","EU"=>"Europe","AF"=>"Africa","OC"=>"Oceania","CA"=>"Central America","ME"=>"Middle East"}
                  #initialize start and end date
                  @startdate=Time.parse(session[:report_start_on]).strftime('%Y-%m-%d')
                  @enddate=Time.parse(session[:report_end_on]).strftime('%Y-%m-%d')
                  @page= params[:page]
                  verifyDBconnection
                  user_id = @aes.decrypt(session[:key],session[:iv],session[:user_id])
                  user_info=User.find_by_id(user_id)
                  @check_access=user_info.access_on_analytics
                  unfilled_info=@check_access=='true' ? '(sum(fill_rate)+sum(impressions)) as traffic_acquired,sum(fill_rate) as unfilled,' : ''
                  @xml_traffic=@@obj.generate_query("#{session[:pub_id]}-#{session[:filled]}",'pub_geolocations','Traffic','continent_code','impressions',session[:report_adclient],session[:report_start_on], session[:report_end_on],'','publisher_analytic','')
                  @adclient_type=(session[:report_adclient]!='SMS' and session[:report_adclient]!='WAP')? " and client_id=#{session[:report_adclient]}" : " and (ad_client_type='#{session[:report_adclient].upcase}' or ad_client_type='#{session[:report_adclient].downcase}')"
                  #frame query to get hourly traffic recordset from database.
                  query= "select if(continent_code='CB','NA',continent_code) as continent, #{unfilled_info} sum(impressions) as sum_region,sum(clicks) as sum_clicks,((sum(clicks)/sum(impressions))*100) as sum_ctr,sum(revenue) as sum_revenue,((sum(revenue)/sum(impressions))*1000) as sum_ecpm,(sum(impressions)/(sum(fill_rate)+sum(impressions)))*100 as fr_percentage from pub_geolocations where pub_id =#{session[:pub_id]} and delivery_date>='#{@startdate} 00:00:00' and delivery_date<='#{@enddate} 23:59:59' and (impressions>0 or fill_rate>0 or clicks>0)" 
                  query+="#{@adclient_type}"
                  query+= " group by continent order by #{session[:filled]=='filled' ? "sum_region" : session[:filled]=='unfilled' ? "unfilled" : "traffic_acquired"} desc"
                  #following code is used to retrive recordset from database
                  @trafficdata_pages, @trafficdata = paginate_by_sql AdclientsSummary,query,10
               else
                  flash[:notice]="Your are not an authorized user. Please login with different username."
                  redirect_to :controller=>'login', :action=>'login'
              end
          end
       rescue Exception=>e
         puts "DEBUG :: ERROR :: in Publisher analytic controller :: publisher_traffic method :: #{e.to_s}"
   end
     
   end
     #--------------------------------------------------------------------------------------------
      #Method Name: traffic_country
      #Purpose: this method is used to construct traffic source country wise continent map
      #Version: 1.0
      #Author:Md Shujauddeen A
      #Last Modified: 14-Oct-2008 by Md Shujauddeen
      #Notes: None.
     #-------------------------------------------------------------------------------------------- 
    def traffic_country
       begin
            @aes = AESSecurity.new() #creating an object for AES Security
            if (session[:user_id]==nil)
                flash[:notice]="Your session has expired. Please login again."
                redirect_to :controller=>'login', :action=>'login'
            else
                if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
                    key='aditztd04azd4ezt'
                    iv='t0sez4e0sntgtt0s'
                    europe={"AL"=>"Albania","AD"=>"Andorra","AT"=>"Austria","BY"=>"Belarus","BE"=>"Belgium","BA"=>"Bosnia and Herzegovina","BG"=>"Bulgaria","HR"=>"Croatia","CZ"=>"Czech Republic","DK"=>"Denmark","EE"=>"Estonia","FI"=>"Finland","FR"=>"France","DE"=>"Germany","GR"=>"Greece","HU"=>"Hungary","IS"=>"Iceland","IE"=>"Ireland","IT"=>"Italy","LV"=>"Liechtenstein","LI"=>"Liechtenstein","LT"=>"Lithuania","LU"=>"Luxembourg","MK"=>"Macedonia","MT"=>"Malta","MD"=>"Moldova","MC"=>"Monaco","ME"=>"Montenegro","NL"=>"Netherlands","NO"=>"Norway","PL"=>"Poland","PT"=>"Portugal","RO"=>"Romania","SM"=>"San Marino","CS"=>"Serbia","SK"=>"Slovakia","SI"=>"Slovenia","ES"=>"Spain","SE"=>"Sweden","CH"=>"Switzerland","UA"=>"Ukraine","GB"=>"United Kingdom","VA"=>"Vatican City ","CY"=>"Cyprus","TR"=>"Turkey","RU"=>"Russia","AX"=>"Aland Islands","FO"=>"Faroe Islands","GI"=>"Gibraltar"}
                    northAmerica={"AG"=>"Antigua and Barbuda","BS"=>"Bahamas","BB"=>"Barbados","BZ"=>"Belize","CA"=>"Canada","CR"=>"Costa Rica","CU"=>"Cuba","DM"=>"Dominica","DO"=>"Dominican Rep.","SV"=>"El Salvador","GD"=>"Grenada","GT"=>"Guatemala","HT"=>"Haiti","HN"=>"Honduras","JM"=>"Jamaica","MX"=>"Mexico","NI"=>"Nicaragua","PA"=>"Panama","KN"=>"St. Kitts & Nevis","LC"=>"St. Lucia","VC"=>"St. Vincent & the Grenadines","TT"=>"Trinidad & Tobago","US"=>"United States","GL"=>"Greenland","PR"=>"Puerto Rico","KY"=>"Cayman Islands","AI"=>"Anguilla","AW"=>"Aruba","BM"=>"Bermuda","GP"=>"Guadeloupe","MQ"=>"Martinique","MS"=>"Montserrat","AN"=>"Netherlands Antilles","TC"=>"Turks And Caicos Islands","VG"=>"Virgin Islands - British","VI"=>"VIRGIN ISLANDS - U.S"}
                    southAmerica={"AR"=>"Argentina","BO"=>"Bolivia","BR"=>"Brazil","CL"=>"Chile","CO"=>"Colombia","EC"=>"Ecuador","FK"=>"Falkland Islands","GF"=>"French Guiana","GY"=>"Guyana","PY"=>"Paraguay","PE"=>"Peru","SR"=>"Suriname","UY"=>"Uruguay","VE"=>"Venezuela"}
                    asia={"AF"=>"Afghanistan","AM"=>"Armenia","AZ"=>"Azerbaijan","BD"=>"Bangladesh","BT"=>"Bhutan","BN"=>"Brunei","MM"=>"Burma (Myanmar)","KH"=>"Cambodia","CN"=>"China","TP"=>"East Timor","GE"=>"Georgia","IN"=>"India","ID"=>"Indonesia","IR"=>"Iran","JP"=>"Japan","KZ"=>"Kazakhstan","KP"=>"Korea (north)","KR"=>"Korea (south)","KG"=>"Kyrgyzstan","LA"=>"Laos","MY"=>"Malaysia","MN"=>"Mongolia","NP"=>"Nepal","PK"=>"Pakistan","PH"=>"Philippines","RU"=>"Russian Federation","SG"=>"Singapore","LK"=>"Sri Lanka","TJ"=>"Tajikistan","TH"=>"Thailand","TM"=>"Turkmenistan","UZ"=>"Uzbekistan","VN"=>"Vietnam","TW"=>"Taiwan","HK"=>"Hong Kong","MO"=>"Macau","IO"=>"BRITISH INDIAN OCEAN TERRITORY","MV"=>"Maldives"}
                    africa={"DZ"=>"Algeria","AO"=>"Angola","BJ"=>"Benin","BW"=>"Botswana","BF"=>"Burkina Faso","BI"=>"Burundi","CM"=>"Cameroon","CV"=>"Cape Verde","CF"=>"Central African Republic","TD"=>"Chad","KM"=>"Comoros","CI"=>"Cote d Ivoire","CD"=>"Democratic Republic of the Congo","DJ"=>"Djibouti","EG"=>"Egypt","GQ"=>"Equatorial Guinea","ER"=>"Eritrea","ET"=>"Ethiopia","GA"=>"Gabon","GH"=>"Ghana","GN"=>"Guinea","GW"=>"Guinea-Bissau","KE"=>"Kenya","LS"=>"Lesotho","LR"=>"Liberia","LY"=>"Libya","MG"=>"Madagascar","MW"=>"Malawi","ML"=>"Mali","MR"=>"Mauritania","MA"=>"Morocco","MZ"=>"Mozambique","NA"=>"Namibia","NE"=>"Niger","NG"=>"Nigeria","RW"=>"Rwanda","ST"=>"Sao Tome and Principe","SN"=>"Senegal","SY"=>"Seycelles","SL"=>"Sierra Leone","SO"=>"Somalia","ZA"=>"South Africa","SD"=>"Sudan","SZ"=>"Swaziland","TZ"=>"Tanzania","TG"=>"Togo","TN"=>"Tunisia","UG"=>"Uganda","WS"=>"Western Sahara","ZM"=>"Zambia","ZW"=>"Zimbabwe","GM"=>"Gambia","CG"=>"Congo","MU"=>"Mauritius","YT"=>"Mayotte","RE"=>"Reunion","SC"=>"SEYCHELLES"}
                    oceania={"AU"=>"Australia","FJ"=>"Fiji","KI"=>"Kiribati","MH"=>"Marshall Islands","FM"=>"Micronesia","NR"=>"Nauru","NZ"=>"New Zealand","PW"=>"Palau","PG"=>"Papua New Guinea","WS"=>"Samoa","SB"=>"Solomon Islands","TO"=>"Tonga","TV"=>"Tuvalu","VU"=>"Vanuatu","NC"=>"New Caledonia","AS"=>"American Samoa","CK"=>"Cook Islands","GU"=>"Guam","MP"=>"Northern Mariana Islands","NF"=>"Norfolk Islands","NU"=>"Niue","PF"=>"French Polynesia","TK"=>"Tokelau","UM"=>"United States Minor Outlying Islands"}
                    middleEast={"AF"=>"Afghanistan","BH"=>"Bahrain","IR"=>"Iran","IQ"=>"Iraq","IL"=>"Israel","JO"=>"Jordan","KW"=>"Kuwait","KG"=>"Kyrgyzstan ","LB"=>"Lebanon","OM"=>"Oman","PK"=>"Pakistan","QA"=>"Qatar","SA"=>"SaudiArabia","SY"=>"Syria","TI"=>"Tajikistan","TU"=>"Turkey","TX"=>"Turkmenistan","AE"=>"UnitedArabEmirates","UZ"=>"Uzbekistan","YE"=>"Yemen"}
                    centralAmerica={"BZ"=>"Belize","CR"=>"Costa Rica","SV"=>"El Salvador","GT"=>"Guatemala","HN"=>"Honduras","NI"=>"Nicaragua","PA"=>"Panama"}
                    session[:continent_info]=params[:id] if params[:id]!=nil && params[:id]!=''
                    @continent_code=session[:continent_info].split('/')[0]   #initialize continent code from params
                    flag=session[:continent_info].split('/')[3]
                    if flag==nil 
                        @pub_id=@aes.decrypt(key,iv,"#{session[:continent_info].split('/')[1]}")  # initialize publisher id 
                    elsif flag.to_s=='1'
                        @pub_id=@aes.decrypt(session[:key],session[:iv],"#{session[:continent_info].split('/')[1]}")  # initialize publisher id 
                    end
                    @adclientid=session[:continent_info].split('/')[2] # initialize adclient id
                    @countrycode=(@countrycode=='CB' or @countrycode=='' or @countrycode==nil) ? 'NA' : (@countrycode=='NA' or @countrycode=='SA' or @countrycode=='AS' or @countrycode=='OC' or @countrycode=='AF' or @countrycode=='EU' or @countrycode=='ME' or @countrycode=='CA') ? @countrycode : 'NA'
                    @countryHash = case @continent_code
                         when "NA" : northAmerica
                         when "SA" : southAmerica
                         when "AS" : asia
                         when "OC" : oceania
                         when "AF" : africa
                         when "EU" : europe
                         when "ME" : middleEast
                         when "CA" : centralAmerica
                     end
                    #intialize start and end daste
                    @startdate=Time.parse(session[:report_start_on]).strftime('%Y-%m-%d')
                    @enddate=Time.parse(session[:report_end_on]).strftime('%Y-%m-%d')
                    @page= params[:page]
                    continent_code=@continent_code=='NA' ? "'NA' or continent_code='CB'" : "'#{@continent_code}'"
                    verifyDBconnection
                    user_id = @aes.decrypt(session[:key],session[:iv],session[:user_id])
                    user_info=User.find_by_id(user_id)
                    @check_access=user_info.access_on_analytics
                    unfilled_info=@check_access=='true' ? '(sum(fill_rate)+sum(impressions)) as traffic_acquired,sum(fill_rate) as unfilled,' : ''
                    filter_info= @check_access=='true' ? '(impressions>0 or fill_rate>0 or clicks>0)' : '(impressions>0 or clicks>0)'
                    @adclient_type=(session[:report_adclient]!='SMS' and session[:report_adclient]!='WAP')? " and client_id=#{session[:report_adclient]}" : " and (ad_client_type='#{session[:report_adclient].upcase}' or ad_client_type='#{session[:report_adclient].downcase}')"
                    #call generate query method to construct traffic source- country wise query and to generate traffic source map.
                    @XML_traffic_continent=@@obj.generate_query("#{@pub_id}-#{session[:filled]}",'pub_geolocations','Traffic_Continent','country_code','impressions',@adclientid,@startdate, @enddate,@continent_code,'publisher_analytic','')
                    #frame query to retrive traffic source recordset from the database.
                    #sub_query="select  sum(impressions) from adclients_summaries where pub_id =#{session[:pub_id]} and delivery_date>='#{(Time.parse(@startdate)).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(@enddate)).strftime("%Y-%m-%d")} 23:59:59' and (continent_code=#{continent_code}) and (impressions!=0 or clicks!=0)" 
                    #sub_query+=" #{@adclient_type}" 
                    query= "select country_code,#{unfilled_info} sum(impressions) as sum_region,sum(clicks) as sum_clicks,((sum(clicks)/sum(impressions))*100) as sum_ctr,sum(revenue) as sum_revenue,((sum(revenue)/sum(impressions))*1000) as sum_ecpm,(sum(impressions)/(sum(fill_rate)+sum(impressions)))*100 as fr_percentage from pub_geolocations where pub_id =#{session[:pub_id]} and delivery_date>='#{@startdate} 00:00:00' and delivery_date<='#{@enddate} 23:59:59' and (continent_code=#{continent_code}) and #{filter_info}" 
                    query+= "#{@adclient_type}"
                    query+= " group by country_code order by #{session[:filled]=='filled' ? "sum_region" : session[:filled]=='unfilled' ? "unfilled" : "traffic_acquired"} desc"
                    @countrydata_pages, @countrydata = paginate_by_sql AdclientsSummary,query,10
                 else
                      flash[:notice]="Your are not an authorized user. Please login with different username."
                      redirect_to :controller=>'login', :action=>'login'
                  end
            end
         rescue Exception=>e
             puts "DEBUG :: ERROR :: in Publisher analytic controller :: traffic_country method :: #{e.to_s}"
          end
        end
      
  #--------------------------------------------------------------------------------------------
  #Method Name: publisher_handset_model
  #Purpose:this method to construct publisher handset chart
  #Version: 1.0
  #Author:Md Shujauddeen A
  #Last Modified: 07-Oct-2009 by Md Shujauddeen
  #Notes: None.
 #-------------------------------------------------------------------------------------------- 
      def publisher_handset_model
          begin
              @aes = AESSecurity.new() #creating an object for AES Security
              if (session[:user_id]==nil)
                  flash[:notice]="Your session has expired. Please login again."
                  redirect_to :controller=>'login', :action=>'login'
              else
                
               if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
                       # @handset_report = session[:xml_string]
                        @smartLable='1' #1 represent smartLable as Enabled
                        session[:handset]=params[:handset] if params[:handset]!=nil && params[:handset]!=''
                        @handset=session[:handset] #initialize handset code from params
                        @handset=@handset.gsub(/[~]/,'&')
                        @XML_handset_report=@@obj.generate_query("#{session[:pub_id]}-#{session[:filled]}",'pub_handsets','Pie_chart','handset_model','impressions',session[:report_adclient],session[:report_start_on],session[:report_end_on],@smartLable,'publisher_analytic',@handset)
                        #initialize start and end date
                        @startdate=Time.parse(session[:report_start_on]).strftime('%Y-%m-%d')
                        @enddate=Time.parse(session[:report_end_on]).strftime('%Y-%m-%d')
                        @page= params[:page]
                        verifyDBconnection
                        filter_column=session[:filled]=='filled' ? "and impressions>0" : session[:filled]=='unfilled' ? "and fill_rate>0" : "and (impressions>0 or fill_rate>0)"
                        @adclient_type=(session[:report_adclient]!='SMS' and session[:report_adclient]!='WAP')? " and client_id=#{session[:report_adclient]}" : ""
                        #frame query to get the devices summary report.
                        sub_query="select  #{session[:filled]=='filled' ? "sum(impressions)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(impressions)+sum(fill_rate))"} from pub_handsets where pub_id =#{session[:pub_id]} and delivery_date>='#{(Time.parse(@startdate)).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(@enddate)).strftime("%Y-%m-%d")} 23:59:59' and handset='#{@handset}' #{filter_column}" 
                        sub_query+=" #{@adclient_type}"
                        query= "select handset_model, #{session[:filled]=='filled' ? "sum(impressions)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(impressions)+sum(fill_rate))"} as sum_requests,(#{session[:filled]=='filled' ? "sum(impressions)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(impressions)+sum(fill_rate))"}/(#{sub_query})*100) as handset_percentage from pub_handsets where pub_id =#{session[:pub_id]} and delivery_date>='#{@startdate} 00:00:00' and delivery_date<='#{@enddate} 23:59:59' and handset='#{@handset}' #{filter_column}" 
                        query+=" #{@adclient_type}"
                        query+= " group by handset_model order by sum_requests desc"
                        #following code is used to retrive recordset from database.
                        @handsetdata_pages, @handsetdata = paginate_by_sql AdclientsSummary,query,10
                        render :action =>'publisher_handset_model' 
                    else
                        flash[:notice]="Your are not an authorized user. Please login with different username."
                        redirect_to :controller=>'login', :action=>'login'
                    end
                end
          rescue Exception=>e
              puts "DEBUG :: ERROR :: in Publisher analytic controller :: publisher_handset method :: #{e.to_s}"
          end
        end
        
     #--------------------------------------------------------------------------------------------
      #Method Name: generate_report
      #Purpose: this method  gets input as a parameter from the publisher and generate xml string and array. 
      #Version: 1.0
      #Author:Md Shujauddeen A
      #Last Modified: 10-Oct-2008 by Md Shujauddeen
      #Notes: None.
     #-------------------------------------------------------------------------------------------- 
   def generate_report
       begin
       p "pppppppppppppppppppppppppppppppppp"
            @aes = AESSecurity.new() #creating an object for AES Security
            if (session[:user_id]==nil)
                flash[:notice]="Your session has expired. Please login again."
                redirect_to :controller=>'login', :action=>'login'
            else
                if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
                      xml_string_hash=Hash.new
                      xml_array_hash=Hash.new
                      verifyDBconnection
                      smartLable='0' #0 represent smartLable as disabled
                      session[:report_adclient]=@aes.decrypt(session[:key],session[:iv],params[:adclient_dropdown]) #initialize adclient session 
                      session[:report_start_on]=params[:pub_start_on]#initialize start date session
                      session[:report_end_on]=params[:pub_end_on] #initialize end date session
                      session[:duration]=params[:duration] #initialize range (duration) session
                      session[:filled]=params[:filled]
                      #structure of parameter
                      #generate_query(publisher_id,table_name,report_type,first_columnm,second_column,adClient_Id,start_date,end_date)
                      #calls generate query method to construct TRAFFIC query and xml
                      xml_summary_report=@@obj.generate_query("#{session[:pub_id]}-#{session[:filled]}",'adclients_summaries','Traffic_summary','delivery_date','impressions',session[:report_adclient],params[:pub_start_on],params[:pub_end_on],params[:duration],'publisher_analytic','')
                      if xml_summary_report==nil 
                            xml_summary_report={:xml_string=>nil,:xml_array=>nil} 
                      end
                      #calls generate query method to construct HOURLY traffic query and xml
                      #~ xml_hourly_report=@@obj.generate_query("#{session[:pub_id]}-#{session[:filled]}",'adclients_summaries','hourly_report','delivery_hour','impressions',session[:report_adclient],params[:pub_start_on],params[:pub_end_on],'','publisher_analytic','')
                      #~ if xml_hourly_report==nil 
                            #~ xml_hourly_report={:xml_string=>nil,:xml_array=>nil} 
                      #~ end
                     #calls generate query method to construct DEMOGRAPHIC keyword and xml
#~ xml_channel_report=@@obj.generate_query("#{session[:pub_id]}-#{session[:filled]}",'pub_channels','Pie_chart','channel','requests',session[:report_adclient],params[:pub_start_on], params[:pub_end_on],smartLable,'publisher_analytic','')
#~ if xml_channel_report==nil 
#~ xml_channel_report={:xml_string=>nil,:xml_array=>nil} 
#~ end
                      #~ #calls generate query method to construct DEVICE keyword and xml
                        adclient_type=session[:report_adclient]
                        if session[:report_adclient].to_s!='SMS'and  session[:report_adclient].to_s!='WAP'
                              @adc=Adclient.find(session[:report_adclient]) 
                              adclient_type=(@adc.client_type).upcase
                        end

#~ xml_handset_report=@@obj.generate_query("#{session[:pub_id]}-#{session[:filled]}",'publisher_handset_overviews','Pie_chart','device','requests',session[:report_adclient],params[:pub_start_on], params[:pub_end_on],smartLable,'publisher_analytic','')  if adclient_type!='SMS'
#~ xml_handset_report={:xml_string=>nil,:xml_array=>nil} if adclient_type=='SMS'
#~ if xml_handset_report==nil and adclient_type=='WAP'
#~ xml_handset_report={:xml_string=>nil,:xml_array=>nil} 
#~ end
                          
                        #calls generate query method to construct URL query and xml
                       xml_url_report=@@obj.generate_query("#{session[:pub_id]}-#{session[:filled]}",'pub_urls','Pie_chart','url','requests',session[:report_adclient],params[:pub_start_on], params[:pub_end_on],smartLable)   if adclient_type!='SMS'
                       xml_url_report={:xml_string=>nil,:xml_array=>nil} if adclient_type=='SMS'
                       if xml_url_report==nil and adclient_type=='WAP'
                              xml_url_report={:xml_string=>nil,:xml_array=>nil} 
                       end 
                        #~ #calls generate query method to construct CARRIER query and xml
                      xml_carrier_report=@@obj.generate_query("#{session[:pub_id]}-#{session[:filled]}",'pub_carriers','Pie_chart','operator','requests',session[:report_adclient],params[:pub_start_on], params[:pub_end_on],smartLable,'publisher_analytic','')
                       if xml_carrier_report==nil 
                              xml_carrier_report={:xml_string=>nil,:xml_array=>nil} 
                       end 
                       #calls generate query method to construct UNIQUE VISITOR query and xml
                       xml_traffic_visitor=@@obj.generate_query("#{session[:pub_id]}-#{session[:filled]}",'publisher_unique_visitor_overviews','Visitors','delivery_date','request',session[:report_adclient],params[:pub_start_on], params[:pub_end_on],params[:duration],'publisher_analytic','')
                        if xml_traffic_visitor==nil 
                              xml_traffic_visitor={:xml_string=>nil,:xml_array=>nil} 
                       end 
                       #call generate query method to construct query and generate traffic source xml
                        xml_traffic=@@obj.generate_query("#{session[:pub_id]}-#{session[:filled]}",'pub_geolocations','Traffic','continent_code','impressions',session[:report_adclient],params[:pub_start_on], params[:pub_end_on],'','publisher_analytic','')
                         if xml_traffic==nil 
                              xml_traffic={:xml_string=>nil,:xml_array=>nil} 
                        end  
                        #assaign xml string to an hash and put it in a session variable
                        xml_string_hash={:summary=>xml_summary_report[:xml_string],:channel=>xml_channel_report[:xml_string],:handset=>xml_handset_report[:xml_string],:visitor=>xml_traffic_visitor[:xml_string],:traffic=>xml_traffic[:xml_string],:carrier=>xml_carrier_report[:xml_string]}
                        session[:xml_string]=xml_string_hash
                        
                        #assaign xml array to an hash and put it in a session variable
                        xml_array_hash={:channel_arr=>xml_channel_report[:xml_array],:handset_arr=>xml_handset_report[:xml_array],:url_arr=>xml_url_report[:xml_array],:carrier_arr=>xml_carrier_report[:xml_array]}
                         session[:xml_array]=xml_array_hash 
                        redirect_to :controller=>"publisher_analytic", :action=>"publisher_home"
                  else
                      flash[:notice]="Your are not an authorized user. Please login with different username."
                      redirect_to :controller=>'login', :action=>'login'
                  end
              end
        rescue Exception=>e
          puts "DEBUG :: ERROR :: in Publisher analytic controller::generate_report method :: #{e.to_s}"
        end
      end
      
      #~ mine---testing the generate report
      #~ ---------
      def generate_report_test
       begin
          @aes = AESSecurity.new() #creating an object for AES Security
            if (session[:user_id]==nil)
                flash[:notice]="Your session has expired. Please login again."
                redirect_to :controller=>'login', :action=>'login'
            else
                if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
                    puts "generate_report_test"
                      xml_string_hash=Hash.new
                      xml_array_hash=Hash.new
                      verifyDBconnection
                      smartLable='0' #0 represent smartLable as disabled
                      session[:report_adclient]=@aes.decrypt(session[:key],session[:iv],params[:adclient_dropdown]) #initialize adclient session 
                      session[:report_start_on]=params[:pub_start_on]#initialize start date session
                      session[:report_end_on]=params[:pub_end_on] #initialize end date session
                      session[:duration]=params[:duration] #initialize range (duration) session
                      session[:filled]=params[:filled]
                      #structure of parameter
                      #generate_query(publisher_id,table_name,report_type,first_columnm,second_column,adClient_Id,start_date,end_date)
                      #calls generate query method to construct TRAFFIC query and xml
                     adclient_type = session[:report_adclient]
                      xml_handset_report=@@obj1.generate_query_data("#{session[:pub_id]}-#{session[:filled]}",'publisher_handset_overviews','Pie_chart','device','requests',session[:report_adclient],params[:pub_start_on], params[:pub_end_on],smartLable,'publisher_analytic','',"notreport")  if adclient_type!='SMS'
                     xml_handset_report={:xml_string=>nil,:xml_array=>nil} if adclient_type=='SMS'
                      if xml_handset_report==nil 
                            xml_handset_report={:xml_string=>nil,:xml_array=>nil} 
                      end
                          
                          xml_carrier_report=@@obj1.generate_query_data("#{session[:pub_id]}-#{session[:filled]}",'publisher_traffic_carrier_overviews','Pie_chart','carrier','traffic',session[:report_adclient],params[:pub_start_on], params[:pub_end_on],smartLable,'publisher_analytic','',"notreport")
                          puts smartLable
                       if xml_carrier_report==nil 
                              xml_carrier_report={:xml_string=>nil,:xml_array=>nil} 
                      end 
                            
                            xml_traffic=@@obj1.generate_query_data("#{session[:pub_id]}-#{session[:filled]}",'publisher_traffic_contient_overviews','Traffic','continent_code','impressions',session[:report_adclient],params[:pub_start_on], params[:pub_end_on],'','publisher_analytic','',"notreport")
                         if xml_traffic==nil 
                              xml_traffic={:xml_string=>nil,:xml_array=>nil} 
                        end  
                            
                          xml_traffic_visitor=@@obj1.generate_query_data("#{session[:pub_id]}-#{session[:filled]}",'publisher_unique_visitor_overviews','Visitors','delivery_date','requests',session[:report_adclient],params[:pub_start_on], params[:pub_end_on],params[:duration],'publisher_analytic','',"notreport")
                        if xml_traffic_visitor==nil 
                              xml_traffic_visitor={:xml_string=>nil,:xml_array=>nil} 
                       end
                           puts xml_traffic_visitor
                           xml_channel_report=@@obj1.generate_query_data("#{session[:pub_id]}-#{session[:filled]}",'publisher_traffic_channel_overviews','Pie_chart','channel','traffic',session[:report_adclient],params[:pub_start_on], params[:pub_end_on],smartLable,'publisher_analytic','',"notreport")
                           #~ puts xml_channel_report
                      if xml_channel_report==nil 
                            xml_channel_report={:xml_string=>nil,:xml_array=>nil} 
                      end
                       #assaign xml string to an hash and put it in a session variable
                        xml_string_hash={:handset=>xml_handset_report[:xml_string],:channel=>xml_channel_report[:xml_string],:visitor=>xml_traffic_visitor[:xml_string],:carrier=>xml_carrier_report[:xml_string],:traffic=>xml_traffic[:xml_string]}
                         
                        
                        session[:xml_string]=xml_string_hash
                        #assaign xml array to an hash and put it in a session variable
                        xml_array_hash={:channel_arr=>xml_channel_report[:xml_array],:handset_arr=>xml_handset_report[:xml_array],:carrier_arr=>xml_carrier_report[:xml_array]}
                         session[:xml_array]=xml_array_hash
                         
                         #~ puts "xml_array_hash:::::handset ::#{xml_array_hash[:handset]}"
                         
                         
                       
                        redirect_to :controller=>"publisher_analytic", :action=>"publisher_home"
                  else
                      flash[:notice]="Your are not an authorized user. Please login with different username."
                      redirect_to :controller=>'login', :action=>'login'
                  end
              end
        rescue Exception=>e
          puts "DEBUG :: ERROR :: in Publisher analytic controller::generate_report method :: #{e.to_s}"
        end
      end
      
     
      #--------------------------------------------------------------------------------------------
      #Method Name: daysinmonth
      #Purpose: this method is used to get the number of days in a given month.
      #Version: 1.0
      #Author:Md Shujauddeen A
      #Last Modified: 25-Aug-2008 by Md Shujauddeen
      #Notes: None.
     #-------------------------------------------------------------------------------------------- 
      def daysinmonth(year, month)
          begin
              @aes = AESSecurity.new() #creating an object for AES Security
              if (session[:user_id]==nil)
                  flash[:notice]="Your session has expired. Please login again."
                  redirect_to :controller=>'login', :action=>'login'
              else
                  if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
                        return (Date.new(year, 12, 31) << (12-month)).day
                  else
                      flash[:notice]="Your are not an authorized user. Please login with different username."
                      redirect_to :controller=>'login', :action=>'login'
                  end
              end
         rescue Exception=>e
             puts "DEBUG :: ERROR :: in Publisher analytic controller :: daysinmonth method :: #{e.to_s}"
          end
      end      
     #--------------------------------------------------------------------------------------------
      #Method Name: updateChart
      #Purpose: this method is used to update the charts using Ajax Updater method.
      #Version: 1.0
      #Author:Md Shujauddeen A
      #Last Modified: 24-Oct-2008 by Md Shujauddeen
      #Notes: None.
     #-------------------------------------------------------------------------------------------- 
    def updateChart
          begin
              @aes = AESSecurity.new() #creating an object for AES Security
              if (session[:user_id]==nil)
                  flash[:notice]="Your session has expired. Please login again."
                  redirect_to :controller=>'login', :action=>'login'
              else
                  if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
                    puts "updateChart::::::::::#{params[:report_type]}:::::::::#{}"
                       @XML_summary_report=@@obj.generate_query("#{session[:pub_id]}-#{session[:filled]}",'adclients_summaries','Traffic_summary','delivery_date',params[:report_type],session[:report_adclient],session[:report_start_on],session[:report_end_on],session[:duration]) 
                       session[:chartType]=params[:report_type]
                       @chart=@XML_summary_report[:xml_string]
                       render :action=>'updateChart',:layout=>false
                  else
                      flash[:notice]="Your are not an authorized user. Please login with different username."
                      redirect_to :controller=>'login', :action=>'login'
                  end
              end
          rescue Exception=>e
              puts "DEBUG :: ERROR :: in Publisher analytic controller :: updateChart method :: #{e.to_s}"
         end
       end
    #--------------------------------------------------------------------------------------------
      #Method Name: showTextReport
      #Purpose:This method is used to render summary table on Publisher home page
      #Version: 1.0
      #Author:Md Shujauddeen A
      #Last Modified: 24-Oct-2008 by Md Shujauddeen
      #Notes: None.
     #-------------------------------------------------------------------------------------------- 
    def showTextReport
       begin
            @aes = AESSecurity.new() #creating an object for AES Security
            if (session[:user_id]==nil)
                flash[:notice]="Your session has expired. Please login again."
                redirect_to :controller=>'login', :action=>'login'
            else
                if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
                      verifyDBconnection
                      @adclient_type=(session[:report_adclient]!='SMS' and session[:report_adclient]!='WAP')? " and client_id=#{session[:report_adclient]}" : " and (ad_client_type='#{session[:report_adclient].upcase}' or ad_client_type='#{session[:report_adclient].downcase}')"
                      query="select #{session[:filled]=='filled' ? "sum(impressions)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(impressions)+sum(fill_rate))"} as sum_impressions,sum(clicks) as sum_clicks,((sum(clicks)/#{session[:filled]=='filled' ? "sum(impressions)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(impressions)+sum(fill_rate))"})*100) as sum_ctr,sum(revenue) as sum_revenue,((sum(revenue)/#{session[:filled]=='filled' ? "sum(impressions)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(impressions)+sum(fill_rate))"})*1000) as sum_ecpm, date_format(delivery_date,'%Y/%m/%d') as delivered_date from adclients_summaries" 
                      query+=" where pub_id =#{session[:pub_id]}" 
                      query+=" and delivery_date>='#{(Time.parse(session[:report_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:report_end_on])).strftime("%Y-%m-%d")} 23:59:59'"
                      query+=" #{@adclient_type}" 
                      query+=" group by Year(delivery_date),MONTH(delivery_date),Day(delivery_date)"
                      @summarydata_pages, @summrydata = paginate_by_sql AdclientsSummary,query,10
                      #~ @total_rec=AdclientsSummary.find_by_sql("select  count(distinct(delivery_date)) as rec_length from adclients_summaries where pub_id =#{session[:pub_id]} and delivery_date>='#{(Time.parse(session[:report_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:report_end_on])).strftime("%Y-%m-%d")} 23:59:59' and client_id =16 ")
                      render :action=>'showTextReport',:layout=>false
                else
                    flash[:notice]="Your are not an authorized user. Please login with different username."
                    redirect_to :controller=>'login', :action=>'login'
                end
            end
      rescue Exception=>e
          puts "DEBUG :: ERROR :: in Publisher analytic controller :: showTextReport method :: #{e.to_s}"
      end
    end
    
        #--------------------------------------------------------------------------------------------
        #Method Name: generate_Csv
        #Purpose: This method will be used to export summary table value to csv
        #Version: 1.0
        #Author:Md Shujauddeen
        #Last Modified: 24-Oct-2008 by Md Shujauddeen
        #Notes: None.
      #-------------------------------------------------------------------------------------------- .
       def generate_Csv
        begin
             @aes = AESSecurity.new() #creating an object for AES Security
              if (session[:user_id]==nil)
                  flash[:notice]="Your session has expired. Please login again."
                  redirect_to :controller=>'login', :action=>'login'
              else
                  if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
                        filename = "zestadz_#{params[:heading]}" + ".csv"
                        send_data(session[:csv_string],:type => 'text/csv; charset=utf-8; header=present',:filename => filename)
                  else
                      flash[:notice]="Your are not an authorized user. Please login with different username."
                      redirect_to :controller=>'login', :action=>'login'
                  end
              end
          rescue Exception=>e
              puts "DEBUG :: ERROR :: in Publisher analytic controller :: daysinmonth method :: #{e.to_s}"
         end
       end #generate csv method ends here
    #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    #Method Name: adv_generate_csv
    #Purpose: To avoid action not responded to "dashboard_move" error.
    #Version: 1.0
    #Author: Md Shujauddeen  A
    #Last Modified: 08-April-2009 by Md Shujauddeen A
    #Notes: None
    #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------      
    def dashboard_move
        begin
              @aes = AESSecurity.new() #creating an object for AES Security
              if (session[:user_id]==nil)
                  flash[:notice]="Your session has expired. Please login again."
                  redirect_to :controller=>'login', :action=>'login'
              else
                  if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
                  else
                        flash[:notice]="Your are not an authorized user. Please login with different username."
                        redirect_to :controller=>'login', :action=>'login'
                  end
              end
        rescue Exception=>e
            puts "DEBUG :: ERROR :: in advertiser_analytic_controller - adv_generate_csv method Exception :: #{e.to_s}"
            render :action=>'adv_generate_csv'
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
