#/*
# * admin_analytics_controller.rb
# *
# * Author :Sathish Kumar and Shuja
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
# * Functionality: Admin analytics controller is used to control the flow of requests for Admin requests. 
# */
##
#
require 'rubygems'
require 'mongo'
include Mongo
require 'csv'
require 'aes_security.rb' #this is to require AES security component
require 'analytics_data.rb'
require 'fastercsv/lib/faster_csv'
#~ require 'faster_csv'
@@pub_obj = PublisherXmlBuilder.new()
@@obj = AdvertiserXmlBuilder.new()
#~ @@objXmlBuilder= AdminXmlBuilder.new()
@@objXmlBuilder= AdminXml.new()
@@objXml=AdminTrafficXmlBuilder.new()
@@objMem=AnalyticsAdminEngine.new()




#--------------------------------------------------------------------------------------------
  #Class Name: AdminAnalyticController
  #Purpose: This Class is used to display the Charts for all the Admin Operations.
  #Version: 1.0
  #Author:Dipti Uppal
  #Last Modified:
  #Notes: None.
#-------------------------------------------------------------------------------------------- .
class AdminAnalyticController < ApplicationController
  auto_complete_for :campaign, :campaign_name
  auto_complete_for :publisher, :publisher_name
  auto_complete_for :analytics_country_list, :country_name
  auto_complete_for :owner, :carrier
  auto_complete_for :advertiser, :name
  auto_complete_for :adclient, :app_name
  auto_complete_for :analytics_state, :state_name
  auto_complete_for :analytics_city, :city_name
  
   # Variables that will be used to set the data in the session, for displaying the Chart and the Labels.
  @xml_string_hash=Hash.new
  @xml_array_hash=Hash.new
  @XML_Campaign_report=Hash.new
  @intPage = 0 
  
  #~ auto_complete_for :publisher, :publisher_name
  def index
      render :action=>'admin_home'
  end
    
    #--------------------------------------------------------------------------------------------
  #Method Name: daysinmonth
  #Purpose: Used to calc and return no of days in the given month and year.
  #Version: 1.0
  #Author:Md Shujauddeen
  #Last Modified:
  #Notes: None.
#-------------------------------------------------------------------------------------------- .         
      def daysinmonth(year, month)
          return (Date.new(year, 12, 31) << (12-month)).day
        end
        
  def admin_home
    begin
        @aes = AESSecurity.new() #creating an object for AES Security
        if (session[:user_id]==nil)
            flash[:notice]="Your session has expired. Please login again."
            redirect_to :controller=>'login', :action=>'login'
        else
            if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                 session[:disp_username]=nil
                 session[:adminstart_on]=nil
                 session[:adminend_on]=nil
                 session[:duration]=nil
                 session[:pub_name]=nil
                 session[:adv_name]=nil
                 session[:limit]=nil
                 session[:handset]=nil
                 session[:country_name]=nil
                 session[:xml_string]=nil
                 session[:xml_array]=nil
                 session[:advxml_string]=nil
                 session[:advxml_array]=nil
            else
                flash[:notice]="Your are not an authorized user. Please login with different username."
                redirect_to :controller=>'login', :action=>'login'
            end
        end
      rescue
          puts"An Error occurred in admin home:: #{e.to_s}"
      end
  end
#--------------------------------------------------------------------------------------------
  #Method Name: admin_campaign_performance
  #Purpose: Chart will display the performance of each and every campaign.
  #Version: 1.0
  #Author:Dipti Uppal
  #Last Modified:
  #Notes: None.
#-------------------------------------------------------------------------------------------- .

    def admin_campaign_performance
          begin
          @aes = AESSecurity.new() #creating an object for AES Security
          @aes.inspect
                if (session[:user_id]==nil)
                      flash[:notice]="Your session has expired. Please login again."
                      redirect_to :controller=>'login', :action=>'login'
                else
                    if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                        # Variables to get for the drop down selection.
                        @adminxml_string_hash=Hash.new
                        @adminxml_array_hash=Hash.new
                        session[:advxml_string]=nil
                        session[:advxml_array]=nil
                        verifyDBconnection
                        session[:disp_username]=nil
                        @@objMem.set_campaign_detail
                        @camp_name=@@objMem.campaign_names()
                        if params[:update]
                            if params[:report_type]=='ctr'
                                 session[:adminreport_type]=@adminreport_type="((sum(clicks)/sum(impressions))*100)"
                                 session[:adminreport_name]=@adminreport_name=params[:report_type]
                            else
                                session[:adminreport_type]=@adminreport_type=(params[:report_type]!=nil) ? "sum(cs.#{params[:report_type]})" : 'sum(impressions)'
                                session[:adminreport_name]=@adminreport_name=(params[:report_type]!=nil) ? "#{params[:report_type]}" : 'impressions' 
                            end
                            @recordset=AdvertiserOverview.overall_campaigns_performance(session[:order],session[:adminstart_on],session[:adminend_on])
                            @adminXML_overall_report=AdminXml.generateCampaignPerformancePiechartXML(@recordset,session[:adminreport_name],session[:limit],'campaign_name')
                            if @adminXML_overall_report!=nil
                                  # assign xml string to an hash and put it in a session variable for the Chart.
                                  @adminxml_string_hash.merge!({:overall=>@adminXML_overall_report[:xml_string]})
                                end
                               
                            if @campaignId== nil or @campaignId=='All'
                              puts "check 1"
                                  #~ @strSql="select campaign_id, sum(clicks) as clicks , sum(impressions) as impressions ,sum(amount_spent) as amt_spent,((sum(clicks)/sum(impressions))*100) as ctr, ((traffic/traffic_total)*100) as percentage from admin_campaign_wise_reports where daydate>='#{Time.parse(session[:adminstart_on]).strftime("%Y-%m-%d")}' and daydate<='#{Time.parse(session[:adminend_on]).strftime("%Y-%m-%d")}'  group by campaign_id order by #{@adminreport_name=='amount_spent' ? 'amt_spent' : @adminreport_name}  #{session[:order]}"
                                  p "---------@adminreport_name1--#{@adminreport_name}--"
                                  @strSql="select campaign_id, sum(traffic_clicks) as clicks , sum(traffic) as impressions ,sum(cost_clicks) as amt_spent,((sum(traffic_clicks)/sum(traffic))*100) as ctr, ((traffic/traffic_total)*100) as percentage from advertiser_overviews where daydate>='#{Time.parse(session[:adminstart_on]).strftime("%Y-%m-%d")}' and daydate<='#{Time.parse(session[:adminend_on]).strftime("%Y-%m-%d")}'  group by campaign_id order by #{@adminreport_name=='amount_spent' ? 'amt_spent' : @adminreport_name} #{session[:order]}"
                                 @instCampaignData_pages, @instCampaignData = paginate_by_sql AdvertiserOverview,@strSql,session[:limit].to_i
                                end
                            @adminXML_summary_report=AdminXml.generateCampaignPerformancePiechartXML(@instCampaignData,session[:adminreport_name],session[:limit],'campaign_name')
                            if @adminXML_summary_report!=nil
                                    # assign xml string to an hash and put it in a session variable for the Chart.
                                    @adminxml_string_hash.merge!({:summary=>@adminXML_summary_report[:xml_string]})
                            end
                          session[:adminxml_string]=@adminxml_string_hash	
                          render :action=>:admin_campaign_updatechart,:layout=>false
                          elsif params[:csv]
                                  filename = "zestadz_admin_campaign_performance" + ".csv"
                                  send_data(session[:csv_string] ,:type => 'text/csv; charset=utf-8; header=present',:filename => filename)
                                  else
                                      if params[:page]==nil
                                            session[:adminstart_on]=(params[:adminstart_on]!=nil) ? params[:adminstart_on] : session[:adminstart_on]!=nil ? session[:adminstart_on] : (Time.now-86400).strftime("%d-%b-%Y")
                                            session[:adminend_on]=(params[:adminend_on]!=nil) ? params[:adminend_on] : session[:adminend_on]!=nil ? session[:adminend_on] : (Time.now-86400).strftime("%d-%b-%Y")
                                            session[:limit]=(params[:limit]!=nil) ? params[:limit] : 10
                                            session[:order]=(params[:order]!=nil) ? params[:order] : 'desc'
                                            session[:duration]=(params[:duration]!=nil) ? params[:duration] : session[:duration]!=nil ? session[:duration] : 1
                                            if params[:report_type]=='ctr'
                                                session[:adminreport_type]=@adminreport_type="((sum(clicks)/sum(impressions))*100)"
                                                session[:adminreport_name]=@adminreport_name=params[:report_type]
                                            else
                                                session[:adminreport_type]=@adminreport_type=(params[:report_type]!=nil) ? "sum(#{params[:report_type]})" : 'sum(impressions)'
                                                session[:adminreport_name]=@adminreport_name=(params[:report_type]!=nil) ? params[:report_type] : 'impressions'
                                            end
                                      end
                                      if session[:adminstart_on]!=nil and session[:adminend_on]!=nil
                                      # ad id will ad the condition on query depends upon the selection
                                            @camp_details= AdvertiserOverview.top_bar(session[:adminstart_on],session[:adminend_on])
                                            begin
                                                      @impressions=@camp_details[0].impressions
                                                      @clicks=@camp_details[0].clicks
                                                      @ctr=@camp_details[0].ctr.to_f
                                                      @amount_spent=@camp_details[0].amt_spent.to_f
                                            rescue Exception=>e
                                                        puts "DEBUG :: ERROR :: generate_adv_report :: admin_campaign_performance calculation of ctr.  Exception is #{e.to_s}"
                                                        @impressions=0
                                                        @clicks=0
                                                        @ctr=0
                                                        @amount_spent=0
                                            end
                                      end
                                  #~ @camp_names =Array.new
                                  @recordset=AdvertiserOverview.overall_campaigns_performance(session[:order],session[:adminstart_on],session[:adminend_on])
                                  @adminXML_overall_report=AdminXml.generateCampaignPerformancePiechartXML(@recordset,session[:adminreport_name],session[:limit],'campaign_name')
                                  if @adminXML_overall_report!=nil
                                        # assign xml string to an hash and put it in a session variable for the Chart.
                                        @adminxml_string_hash.merge!({:overall=>@adminXML_overall_report[:xml_string]})
                                      end
                                      p "---------@adminreport_name--#{@adminreport_name}--"
                                  @strSql="select campaign_id, sum(traffic_clicks) as clicks , sum(traffic) as impressions ,sum(cost_clicks) as amt_spent,((sum(traffic_clicks)/sum(traffic))*100) as ctr, ((traffic/traffic_total)*100) as percentage from advertiser_overviews where daydate>='#{Time.parse(session[:adminstart_on]).strftime("%Y-%m-%d")}' and daydate<='#{Time.parse(session[:adminend_on]).strftime("%Y-%m-%d")}'  group by campaign_id order by impressions #{session[:order]}"
                                  @instCampaignData_pages, @instCampaignData = paginate_by_sql AdvertiserOverview,@strSql,session[:limit].to_i
                                  @adminXML_summary_report=AdminXml.generateCampaignPerformancePiechartXML(@instCampaignData,session[:adminreport_name],session[:limit],'campaign_name')
                                  if @adminXML_summary_report!=nil
                                        # assign xml string to an hash and put it in a session variable for the Chart.
                                        @adminxml_string_hash.merge!({:summary=>@adminXML_summary_report[:xml_string]})
                                  end
                                  session[:adminxml_string]=@adminxml_string_hash	
                              end
                          else
                          flash[:notice]="Your are not an authorized user. Please login with different username."
                          redirect_to :controller=>'login', :action=>'login'
                          end
                  end
          rescue Exception=>e
          puts "DEBUGGER :: ERROR :: in Admin_Analytic_Controller.rb - admin_campaign_performance :: #{e.to_s}"
          end
    end # End of admin_campaign_performance
      
      
#--------------------------------------------------------------------------------------------
  #Method Name: admin_campaign_updatechart
  #Purpose: Chart will display the performance of each and every campaign.
  #Version: 1.0
  #Author:Dipti Uppal
  #Last Modified:
  #Notes: None.
#-------------------------------------------------------------------------------------------- .

    def admin_campaign_updatechart
        begin
            puts "--------------------admin_cap_update------------------"
            @aes = AESSecurity.new() #creating an object for AES Security
            if (session[:user_id]==nil)
                flash[:notice]="Your session has expired. Please login again."
                redirect_to :controller=>'login', :action=>'login'
            else
                if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                    render :layout=>false
                 else
                    flash[:notice]="Your are not an authorized user. Please login with different username."
                    redirect_to :controller=>'login', :action=>'login'
                 end
            end
          rescue Exception=>e
              puts "DEBUGGER :: ERROR :: in Admin_Analytic_Controller.rb - admin_campaign_updatechart :: #{e.to_s}"
          end
      end # End of admin_campaign_updatechart
      
 #--------------------------------------------------------------------------------------------
  #Method Name: admin_campaign_performanceDIPTI
  #Purpose: Chart will display the performance of each and every campaign.
  #Version: 1.0
  #Author:Dipti Uppal
  #Last Modified:
  #Notes: None.
#-------------------------------------------------------------------------------------------- .
 def admin_campaign_performanceDIPTI
   begin
   puts "----------------------1-------------------------"
    @aes = AESSecurity.new() #creating an object for AES Security
   	 if (session[:user_id]==nil)
          flash[:notice]="Your session has expired. Please login again."
          redirect_to :controller=>'login', :action=>'login'
     else
          if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                # Variables to get for the drop down selection.
                @campaignId = params[:campaign] 
                adId = params[:ads] 
                startDate =  params[:start_on]
                endDate =  params[:end_on] 
                @intPage = params[:page]==nil ? 0 :  (params[:page].to_i*10 - 10)
                verifyDBconnection
                # To get all the campaigns  from the Database to display in Drop Down. 
                @strQuery = "select Campaign_Id, campaign_name from campaigns_summaries group by campaign_name"
                @tblCampaign = Campaign.find_by_sql(@strQuery)
                # Display the Data in Chart.
                @XML_Campaign_report = @@objXmlBuilder.campaign_performance(@intPage,@campaignId,adId,startDate,endDate)
                puts "-------------2------------------"
                puts @XML_Campaign_report.inspect
                if @campaignId== nil or @campaignId=='All'
                    # For Table.
                    @strSql="select Campaign_Id, Campaign_Name, sum(Impressions) as Impressions, Clicks,CTR, CPM, ZestADZ_Revenue, CPC from campaigns_summaries group by Campaign_Name order by Impressions desc"
                    #~ @strSql="select Campaign_Id, sum(Impressions) as Impressions, Clicks from admin_campaign_wise_reports group by Campaign_id order by Impressions desc"
                    @instCampaignData_pages, @instCampaignData = paginate_by_sql CampaignsSummary,@strSql,10
                    # assign xml string to an hash and put it in a session variable for the Chart.
                    @xml_string_hash={:sesCampaignXML=>@XML_Campaign_report[:xml_string]}
                    session[:xml_string]=@xml_string_hash
                    # assign xml array to an hash and put it in a session variable for the Labels.
                    @xml_array_hash={:sesCampaignARR=>@XML_Campaign_report[:xml_array]}
                    session[:xml_array]=@xml_array_hash
                end
                # To put the page number in session, so as to retrieve while generating the PDF or CSV 
                session[:intPage]=@intPage
          else
              flash[:notice]="Your are not an authorized user. Please login with different username."
              redirect_to :controller=>'login', :action=>'login'
          end
      end
     rescue Exception=>e
       puts "DEBUGGER :: ERROR :: in Admin_Analytic_Controller.rb - admin_campaign_performance :: #{e.to_s}"
     end
 end # End of admin_campaign_performance
  
#--------------------------------------------------------------------------------------------
  #Method Name: admin_publisher_performance
  #Purpose: Advertiser Performance Reports.
  #Version: 1.0
  #Author:Dipti Uppal
  #Last Modified:
  #Notes: None.
#-------------------------------------------------------------------------------------------- .
 def admin_publisher_performance
        begin
            @aes = AESSecurity.new() #creating an object for AES Security
            if (session[:user_id]==nil)
                flash[:notice]="Your session has expired. Please login again."
                redirect_to :controller=>'login', :action=>'login'
            else
                if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                      # Variables to get for the drop down selection.
                      @adminxml_string_hash=Hash.new
                      @adminxml_array_hash=Hash.new
                      session[:xml_string]=nil
                      session[:xml_array]=nil
                      session[:disp_username]=nil
                      verifyDBconnection
                      if params[:update]
                          if params[:report_type]=='ctr'
                            session[:adminreport_type]=@adminreport_type="((sum(clicks)/sum(impressions))*100)"
                            session[:adminreport_name]=@adminreport_name=params[:report_type]
                          elsif params[:report_type]=='ecpm'
                            session[:adminreport_type]=@adminreport_type="((sum(revenue)/sum(impressions))*1000)"
                            session[:adminreport_name]=@adminreport_name=params[:report_type]
                          else
                            session[:adminreport_type]=@adminreport_type=(params[:report_type]!=nil) ? "sum(#{params[:report_type]})" : 'sum(impressions)'
                            session[:adminreport_name]=@adminreport_name=(params[:report_type]!=nil) ? params[:report_type] : 'impressions'
                          end
                          @adminXML_overall_report=@@objXmlBuilder.generate_query("adclients_summaries-#{session[:duration]}",'Overall_Performance','pub_id',@adminreport_name,session[:adminstart_on],session[:adminend_on],session[:order],session[:limit],'pub_name')
                          if @adminXML_overall_report!=nil
                            # assign xml string to an hash and put it in a session variable for the Chart.
                            @adminxml_string_hash.merge!({:overall=>@adminXML_overall_report[:xml_string]})
                          end
                          @adminXML_summary_report=@@objXmlBuilder.generate_query("adclients_summaries-#{session[:duration]}",'Campaigns_Performance','pub_id',@adminreport_name,session[:adminstart_on],session[:adminend_on],session[:order],session[:limit],'pub_name',((params[:page]!=nil) ? ((params[:page].to_i*session[:limit].to_i)-session[:limit].to_i) : 0 ))
                          if @adminXML_summary_report!=nil
                            # assign xml string to an hash and put it in a session variable for the Chart.
                            @adminxml_string_hash.merge!({:summary=>@adminXML_summary_report[:xml_string]})
                          end
                          session[:adminxml_string]=@adminxml_string_hash	
                          @strSql="select pub_id, p.publisher_name as pub_name, sum(clicks) as clicks , sum(impressions) as impressions ,((sum(clicks)/sum(impressions))*100) as ctr,sum(revenue) as  revenue,((sum(revenue)/sum(impressions))*1000) as ecpm, ((#{@adminreport_type})/(select (#{@adminreport_type}) as #{@adminreport_name} from adclients_summaries  where delivery_date>='#{(Time.parse(session[:adminstart_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:adminend_on])).strftime("%Y-%m-%d")} 23:59:59' and (impressions>0 or clicks>0) ))*100 as percentage from adclients_summaries ad,publishers p where delivery_date>='#{(Time.parse(session[:adminstart_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:adminend_on])).strftime("%Y-%m-%d")} 23:59:59' and p.id=ad.pub_id and (ad.impressions>0 or ad.clicks>0) group by pub_id order by #{@adminreport_name} #{session[:order]}"
                          @instPublisherData_pages, @instPublisherData = paginate_by_sql AdvCarrier,@strSql,session[:limit].to_i
                          render :action=>:admin_publisher_updatechart,:layout=>false
                      elsif params[:csv]
                          filename = "zestadz_admin_publisher_performance" + ".csv"
                          send_data(session[:csv_string] ,:type => 'text/csv; charset=utf-8; header=present',:filename => filename)
                      else
                          if params[:page]==nil
                              session[:adminstart_on]=(params[:adminstart_on]!=nil) ? Time.parse(params[:adminstart_on]).strftime("%d-%b-%Y") : session[:adminstart_on]!=nil ? session[:adminstart_on] : (Time.now-86400).strftime("%d-%b-%Y")
                              session[:adminend_on]=(params[:adminend_on]!=nil) ? Time.parse(params[:adminend_on]).strftime("%d-%b-%Y") : session[:adminend_on]!=nil ? session[:adminend_on] : (Time.now-86400).strftime("%d-%b-%Y")
                              session[:limit]=(params[:limit]!=nil) ? params[:limit] : 10
                              session[:order]=(params[:order]!=nil) ? params[:order] : 'desc'
                              session[:duration]=(params[:duration]!=nil) ? params[:duration] : session[:duration]!=nil ? session[:duration] : 1
                              if params[:report_type]=='ctr'
                                session[:adminreport_type]=@adminreport_type="((sum(clicks)/sum(impressions))*100)"
                                session[:adminreport_name]=@adminreport_name=params[:report_type]
                              else
                                session[:adminreport_type]=@adminreport_type=(params[:report_type]!=nil) ? "sum(#{params[:report_type]})" : 'sum(impressions)'
                                session[:adminreport_name]=@adminreport_name=(params[:report_type]!=nil) ? params[:report_type] : 'impressions'
                              end
                              #~ session[:adminstart_on]=session[:adminstart_on]? session[:adminstart_on] : (Time.now).strftime("%d-%b-%Y")
                              #~ session[:adminend_on]=session[:adminend_on]? session[:adminend_on] : (Time.now).strftime("%d-%b-%Y")
                            end
                          if session[:adminstart_on]!=nil and session[:adminend_on]!=nil
                              # ad id will ad the condition on query depends upon the selection
                              count_imp_click="select sum(clicks) as clicks , sum(impressions) as impressions ,((sum(clicks)/sum(impressions))*100) as ctr, sum(revenue) as  revenue,((sum(revenue)/sum(impressions))*1000) as ecpm from adclients_summaries where delivery_date>='#{(Time.parse(session[:adminstart_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:adminend_on])).strftime("%Y-%m-%d")} 23:59:59'"
                              @pub_details= AdvCarrier.find_by_sql(count_imp_click)
                              begin
                                  @impressions=@pub_details[0].impressions
                                  @clicks=@pub_details[0].clicks
                                  @ctr=@pub_details[0].ctr.to_f
                                  @earning=@pub_details[0].revenue.to_f
                                  @ecpm=@pub_details[0].ecpm.to_f
                              rescue Exception=>e
                                  puts "DEBUG :: ERROR :: generate_adv_report calculation of ctr.  Exception is #{e.to_s}"
                                  @impressions=0
                                  @clicks=0
                                  @ctr=0
                                  @earning=0
                                  @ecpm=0
                              end
                            end
                            @adminXML_overall_report=@@objXmlBuilder.generate_query("adclients_summaries-#{session[:duration]}",'Overall_Performance','pub_id',session[:adminreport_name],session[:adminstart_on],session[:adminend_on],session[:order],session[:limit],'pub_name')
                            if @adminXML_overall_report!=nil
                                # assign xml string to an hash and put it in a session variable for the Chart.
                                @adminxml_string_hash.merge!({:overall=>@adminXML_overall_report[:xml_string]})
                            end
                            @adminXML_summary_report=@@objXmlBuilder.generate_query("adclients_summaries-#{session[:duration]}",'Campaigns_Performance','pub_id',session[:adminreport_name],session[:adminstart_on],session[:adminend_on],session[:order],session[:limit],'pub_name',((params[:page]!=nil) ? ((params[:page].to_i*session[:limit].to_i)-session[:limit].to_i) : 0 ))
                            if @adminXML_summary_report!=nil
                                # assign xml string to an hash and put it in a session variable for the Chart.
                                @adminxml_string_hash.merge!({:summary=>@adminXML_summary_report[:xml_string]})
                            end
                            session[:adminxml_string]=@adminxml_string_hash	
                             @strSql="select pub_id, p.publisher_name as pub_name, sum(clicks) as clicks , sum(impressions) as impressions ,((sum(clicks)/sum(impressions))*100) as ctr,sum(revenue) as  revenue,((sum(revenue)/sum(impressions))*1000) as ecpm,((#{session[:adminreport_type]})/(select (#{session[:adminreport_type]}) as #{session[:adminreport_name]} from adclients_summaries  where delivery_date>='#{(Time.parse(session[:adminstart_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:adminend_on])).strftime("%Y-%m-%d")} 23:59:59' and pub_id!=0 and (impressions>0 or clicks>0)))*100 as percentage from adclients_summaries ad,publishers p where delivery_date>='#{(Time.parse(session[:adminstart_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:adminend_on])).strftime("%Y-%m-%d")} 23:59:59' and p.id=ad.pub_id and (ad.impressions>0 or ad.clicks>0) group by pub_id order by #{session[:adminreport_name]} #{session[:order]}"
                            @instPublisherData_pages, @instPublisherData = paginate_by_sql AdvCarrier,@strSql,session[:limit].to_i
                      end
              else
                  flash[:notice]="Your are not an authorized user. Please login with different username."
                  redirect_to :controller=>'login', :action=>'login'
              end
        end
          rescue Exception=>e
              puts "DEBUGGER :: ERROR :: in Admin_Analytic_Controller.rb - admin_publisher_performance :: #{e.to_s}"
          end
      end # End of admin_advertiser_performance
      
      
 #--------------------------------------------------------------------------------------------
  #Method Name: admin_publisher_updatechart
  #Purpose: Chart will display the performance of each and every campaign.
  #Version: 1.0
  #Author:Dipti Uppal
  #Last Modified:
  #Notes: None.
#-------------------------------------------------------------------------------------------- .
    def admin_publisher_updatechart
        begin
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
                flash[:notice]="Your session has expired. Please login again."
                redirect_to :controller=>'login', :action=>'login'
          else
                if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                    render :layout=>false
                else
                    flash[:notice]="Your are not an authorized user. Please login with different username."
                    redirect_to :controller=>'login', :action=>'login'
                end
            end
        rescue Exception=>e
          puts "DEBUGGER :: ERROR :: in Admin_Analytic_Controller.rb - admin_publisher_updatechart :: #{e.to_s}"
        end
    end # End of admin_advertiser_updatechart
  
 #--------------------------------------------------------------------------------------------
  #Method Name: admin_advertiser_performance
  #Purpose: Advertiser Performance Reports.
  #Version: 1.0
  #Author:Dipti Uppal
  #Last Modified:
  #Notes: None.
#-------------------------------------------------------------------------------------------- .
 def admin_advertiser_performance
        begin
            @aes = AESSecurity.new() #creating an object for AES Security
            if (session[:user_id]==nil)
                flash[:notice]="Your session has expired. Please login again."
                redirect_to :controller=>'login', :action=>'login'
            else
                if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                      # Variables to get for the drop down selection.
                      @adminxml_string_hash=Hash.new
                      @adminxml_array_hash=Hash.new
                      session[:advxml_string]=nil
                      session[:advxml_array]=nil
                      verifyDBconnection
                      session[:disp_username]=nil
                      if params[:updatechart]
                          if params[:report_type]=='ctr'
                            session[:adminreport_type]=@adminreport_type="((sum(clicks)/sum(impressions))*100)"
                            session[:adminreport_name]=@adminreport_name=params[:report_type]
                          elsif params[:report_type]=='ecpm'
                            session[:adminreport_type]=@adminreport_type="((sum(revenue)/sum(impressions))*1000)"
                            session[:adminreport_name]=@adminreport_name=params[:report_type]
                          else
                            session[:adminreport_type]=@adminreport_type=(params[:report_type]!=nil) ? "sum(#{params[:report_type]})" : 'sum(impressions)'
                            session[:adminreport_name]=@adminreport_name=(params[:report_type]!=nil) ? params[:report_type] : 'impressions'
                          end
                          @adminXML_overall_report=@@objXmlBuilder.generate_query("campaigns_summaries-#{session[:duration]}",'Overall_Performance','advertiser_id',@adminreport_name,session[:adminstart_on],session[:adminend_on],session[:order],session[:limit],'advertiser_name')
                          if @adminXML_overall_report!=nil
                              # assign xml string to an hash and put it in a session variable for the Chart.
                              @adminxml_string_hash.merge!({:overall=>@adminXML_overall_report[:xml_string]})
                          end
                          @adminXML_summary_report=@@objXmlBuilder.generate_query("campaigns_summaries-#{session[:duration]}",'Campaigns_Performance','advertiser_id',@adminreport_name,session[:adminstart_on],session[:adminend_on],session[:order],session[:limit],'advertiser_name',((params[:page]!=nil) ? ((params[:page].to_i*session[:limit].to_i)-session[:limit].to_i) : 0 ))
                          if @adminXML_summary_report!=nil
                              # assign xml string to an hash and put it in a session variable for the Chart.
                              @adminxml_string_hash.merge!({:summary=>@adminXML_summary_report[:xml_string]})
                          end
                          session[:adminxml_string]=@adminxml_string_hash	
                          if @campaignId== nil or @campaignId=='All'
                              # For Table.
                               @strSql="select advertiser_id, a.name as advertiser_name, sum(clicks) as clicks , sum(impressions) as impressions ,((sum(clicks)/sum(impressions))*100) as ctr,sum(amount_spent) as amt_spent, ((#{@adminreport_type})/(select (#{@adminreport_type}) as #{@adminreport_name} from campaigns_summaries  where delivery_date>='#{(Time.parse(session[:adminstart_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:adminend_on])).strftime("%Y-%m-%d")} 23:59:59' and (impressions>0 or clicks>0) ))*100 as percentage from campaigns_summaries cs,advertisers a where delivery_date>='#{(Time.parse(session[:adminstart_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:adminend_on])).strftime("%Y-%m-%d")} 23:59:59' and a.id=cs.advertiser_id and (cs.impressions>0 or cs.clicks>0) group by advertiser_id order by #{@adminreport_name} #{session[:order]}"
                              @instAdvertiserData_pages, @instAdvertiserData = paginate_by_sql AdvCarrier,@strSql,session[:limit].to_i
                          end
                          render :action=>:admin_advertiser_updatechart,:layout=>false
                      elsif params[:csv]
                          filename = "zestadz_admin_advertiser_performance" + ".csv"
                          send_data(session[:csv_string] ,:type => 'text/csv; charset=utf-8; header=present',:filename => filename)
                      else
                          if params[:page]==nil
                              session[:adminstart_on]=(params[:adminstart_on]!=nil) ? params[:adminstart_on] : session[:adminstart_on]!=nil ? session[:adminstart_on] :(Time.now-86400).strftime("%d-%b-%Y")
                              session[:adminend_on]=(params[:adminend_on]!=nil) ? params[:adminend_on] : session[:adminend_on]!=nil ? session[:adminend_on] : (Time.now-86400).strftime("%d-%b-%Y")
                              session[:limit]=(params[:limit]!=nil) ? params[:limit] : 10
                              session[:order]=(params[:order]!=nil) ? params[:order] : 'desc'
                              session[:duration]=(params[:duration]!=nil) ? params[:duration] : session[:duration]!=nil ? session[:duration] : 1
                              if params[:report_type]=='ctr'
                                session[:adminreport_type]="((sum(clicks)/sum(impressions))*100)"
                                session[:adminreport_name]=params[:report_type]
                              elsif params[:report_type]=='ecpm'
                                session[:adminreport_type]=@adminreport_type="((sum(revenue)/sum(impressions))*1000)"
                                session[:adminreport_name]=@adminreport_name=params[:report_type]
                              else
                                session[:adminreport_type]=@adminreport_type=(params[:report_type]!=nil) ? "sum(#{params[:report_type]})" : 'sum(impressions)'
                                session[:adminreport_name]=@adminreport_name=(params[:report_type]!=nil) ? params[:report_type] : 'impressions'
                              end
                          end
                          if session[:adminstart_on]!=nil and session[:adminend_on]!=nil
                              # ad id will ad the condition on query depends upon the selection
                               count_imp_click="select sum(clicks) as clicks , sum(impressions) as impressions ,((sum(clicks)/sum(impressions))*100) as ctr, sum(amount_spent) as  amount_spent from campaigns_summaries where delivery_date>='#{(Time.parse(session[:adminstart_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:adminend_on])).strftime("%Y-%m-%d")} 23:59:59'"
                              @camp_details= AdvCarrier.find_by_sql(count_imp_click)
                              begin
                                  @impressions=@camp_details[0].impressions
                                  @clicks=@camp_details[0].clicks
                                  @ctr=@camp_details[0].ctr.to_f
                                  @amount_spent=@camp_details[0].amount_spent.to_f
                              rescue Exception=>e
                                  puts "DEBUG :: ERROR :: generate_adv_report calculation of ctr.  Exception is #{e.to_s}"
                                  @impressions=0
                                  @clicks=0
                                  @ctr=0
                                  @amount_spent=0
                              end
                            end
                        @adminXML_overall_report=@@objXmlBuilder.generate_query("campaigns_summaries-#{session[:duration]}",'Overall_Performance','advertiser_id',session[:adminreport_name],session[:adminstart_on],session[:adminend_on],session[:order],session[:limit],'advertiser_name')
                          if @adminXML_overall_report!=nil
                              # assign xml string to an hash and put it in a session variable for the Chart.
                              @adminxml_string_hash.merge!({:overall=>@adminXML_overall_report[:xml_string]})
                            end
                          @adminXML_summary_report=@@objXmlBuilder.generate_query("campaigns_summaries-#{session[:duration]}",'Campaigns_Performance','advertiser_id',session[:adminreport_name],session[:adminstart_on],session[:adminend_on],session[:order],session[:limit],'advertiser_name',((params[:page]!=nil) ? ((params[:page].to_i*session[:limit].to_i)-session[:limit].to_i) : 0 ))
                          if @adminXML_summary_report!=nil
                              # assign xml string to an hash and put it in a session variable for the Chart.
                              @adminxml_string_hash.merge!({:summary=>@adminXML_summary_report[:xml_string]})
                            end
                          session[:adminxml_string]=@adminxml_string_hash	
                          #if @campaignId== nil or @campaignId=='All'
                              # For Table.
                               @strSql="select advertiser_id, a.name as advertiser_name, sum(clicks) as clicks , sum(impressions) as impressions ,((sum(clicks)/sum(impressions))*100)  as ctr,sum(amount_spent) as amt_spent,((#{session[:adminreport_type]})/(select (#{session[:adminreport_type]}) as #{session[:adminreport_name]} from campaigns_summaries  where delivery_date>='#{(Time.parse(session[:adminstart_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:adminend_on])).strftime("%Y-%m-%d")} 23:59:59' and (impressions>0 or clicks>0) ))*100 as percentage from campaigns_summaries cs,advertisers a where delivery_date>='#{(Time.parse(session[:adminstart_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:adminend_on])).strftime("%Y-%m-%d")} 23:59:59' and a.id=cs.advertiser_id and (cs.impressions>0 or cs.clicks>0) group by advertiser_id order by #{session[:adminreport_name]} #{session[:order]}"
                              @instAdvertiserData_pages, @instAdvertiserData = paginate_by_sql AdvCarrier,@strSql,session[:limit].to_i
                          #end
                      end
                 else
                    flash[:notice]="Your are not an authorized user. Please login with different username."
                    redirect_to :controller=>'login', :action=>'login'
                 end
            end
          rescue Exception=>e
                puts "DEBUGGER :: ERROR :: in Admin_Analytic_Controller.rb - admin_advertiser_performance :: #{e.to_s}"
          end
      end # End of admin_advertiser_performance
 
 #--------------------------------------------------------------------------------------------
  #Method Name: admin_campaign_updatechart
  #Purpose: Chart will display the performance of each and every campaign.
  #Version: 1.0
  #Author:Dipti Uppal
  #Last Modified:
  #Notes: None.
#-------------------------------------------------------------------------------------------- .
    def admin_advertiser_updatechart
        begin
            @aes = AESSecurity.new() #creating an object for AES Security
            if (session[:user_id]==nil)
                flash[:notice]="Your session has expired. Please login again."
                redirect_to :controller=>'login', :action=>'login'
            else
                if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                      render :layout=>false
                  else
                        flash[:notice]="Your are not an authorized user. Please login with different username."
                        redirect_to :controller=>'login', :action=>'login'
                  end
              end
        rescue Exception=>e
              puts "DEBUGGER :: ERROR :: in Admin_Analytic_Controller.rb - admin_advertiser_updatechart :: #{e.to_s}"
        end
      end # End of admin_advertiser_updatechart
      
  #--------------------------------------------------------------------------------------------
  #Method Name: admin_pub_traffic_growth
  #Purpose:  Display chart for the publisher Traffic Growth.
  #Version: 1.0
  #Author:Dipti Uppal
  #Last Modified:
  #Notes: None.
#-------------------------------------------------------------------------------------------- 
 def admin_pub_traffic_growth
  begin
        @aes = AESSecurity.new() #creating an object for AES Security
        if (session[:user_id]==nil)
            flash[:notice]="Your session has expired. Please login again."
            redirect_to :controller=>'login', :action=>'login'
        else
            if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                verifyDBconnection
                @publishers=Publisher.find_by_sql("select u.username as pub_name,p.id as pub_id from publishers p, users u where u.status='Active' and u.id=p.user_id")
                @enddate=(Time.now-86400).strftime("%d-%b-%Y")
                @startdate= (Time.now-86400).strftime("%d-%b-%Y")
                session[:adminstart_on] = (params[:adminstart_on]!=nil && params[:adminstart_on]!="") ? params[:adminstart_on] : (session[:adminstart_on]!=nil && session[:adminstart_on]!='') ? session[:adminstart_on] : @startdate 
                session[:adminend_on] = (params[:adminend_on]!=nil && params[:adminend_on]!="") ? params[:adminend_on] : (session[:adminend_on]!=nil && session[:adminend_on]!='') ? session[:adminend_on] : @enddate 
                session[:duration]=(params[:duration]!=nil && params[:duration]!="") ? params[:duration] : (session[:duration]!=nil && session[:duration]!='') ? session[:duration] : 1 
                session[:pub_name]=params[:publisher_name] if params[:page]==nil
                if session[:pub_name]!=nil and session[:pub_id]!=""
                    if session[:pub_name].downcase=='all'
                        getPubId='All'
                    else
                        @publisher=Advertiser.find_by_sql("select p.id as pub_id from publishers p, users u where u.username='#{session[:pub_name]}' and u.id=p.user_id")
                        if @publisher!=nil
                            if @publisher.size>0
                              getPubId=@publisher[0].pub_id
                            else
                              getPubId=0
                            end
                        else
                          getPubId=0
                        end
                    end
                else
                    getPubId='All'
                end
                if session[:duration].to_s=='custom'
                  dur_diff=Time.parse(session[:adminend_on]) - Time.parse(session[:adminstart_on])
                  dur_diff=dur_diff/(60*60*24)
                  @chartType=dur_diff>30 ? 'bar' : 'line'
                elsif (session[:duration].to_s=='0' || session[:duration].to_s == '1' || session[:duration].to_s == '6' || session[:duration].to_s == '29')
                  @chartType='line'
                else
                  @chartType='bar'
                end
                if session[:duration].to_s=='89'
                    calc_startDate=Time.parse(session[:adminend_on]).months_ago(3)
                    @start_year= calc_startDate.strftime("%Y-%m-%d").split('-')[0] #selects only year
                    @start_month=calc_startDate.strftime("%Y-%m-%d").split('-')[1]
                    get_startdate=@start_year+'-'+@start_month+'-'+'01'
                    endDate=calc_endDate(session[:adminend_on])
                    startDate=get_startdate
                elsif session[:duration].to_s=='179'
                    calc_startDate=Time.parse(session[:adminend_on]).months_ago(6)
                    @start_year= calc_startDate.strftime("%Y-%m-%d").split('-')[0] #selects only year
                    @start_month=calc_startDate.strftime("%Y-%m-%d").split('-')[1]
                    get_startdate=@start_year+'-'+@start_month+'-'+'01'
                    endDate=calc_endDate(session[:adminend_on])
                    startDate=get_startdate
                elsif session[:duration].to_s=='364'
                    calc_startDate=Time.parse(session[:adminend_on]).months_ago(12)
                    @start_year= calc_startDate.strftime("%Y-%m-%d").split('-')[0] #selects only year
                    @start_month=calc_startDate.strftime("%Y-%m-%d").split('-')[1]
                    get_startdate=@start_year+'-'+@start_month+'-'+'01'
                    endDate=calc_endDate(session[:adminend_on])
                    startDate=get_startdate
                elsif session[:duration].to_s=='6'
                     startDate = Time.parse(session[:adminstart_on]).strftime("%Y-%m-%d") 
                     endDate = Time.parse(session[:adminend_on]).strftime("%Y-%m-%d")
                elsif session[:duration].to_s=='1'
                     startDate = (Time.now - 2592000). strftime("%Y-%m-%d") 
                     endDate = Time.parse(session[:adminend_on]).strftime("%Y-%m-%d")
                else
                     startDate = session[:duration].to_s=='0' ? (Time.now - 2505600). strftime("%Y-%m-%d") : Time.parse(session[:adminstart_on]).strftime("%Y-%m-%d") 
                     endDate = Time.parse(session[:adminend_on]).strftime("%Y-%m-%d")
                end
                session[:adminstart_on]=(session[:duration].to_s=='0' || session[:duration].to_s=='1') ? Time.parse(session[:adminstart_on]).strftime("%Y-%m-%d") : startDate
                session[:adminend_on]=endDate
                start_date= startDate
                @XML_PubTraffic_report =@@objXml.publisher_traffic_growth(getPubId,start_date,endDate,@chartType,session[:duration])
                @xml_string_hash={:sesPubTrafficXML=>@XML_PubTraffic_report}
                session[:xml_string]=@xml_string_hash
                column1=@chartType=='bar' ? 'monthname(delivery_date) as month' : 'delivery_date'
                adv_id= (getPubId=='All' || getPubId==nil || getPubId=='') ? "" : " and pub_id='#{getPubId}'"
                group_value= @chartType=='bar' ? "year(Delivery_Date), month(Delivery_Date)" : "year(Delivery_Date), month(Delivery_Date),Day(delivery_date)"
                @strQuery="select #{column1}, sum(impressions) as sum_impression from  adclients_summaries"
                @strQuery+=" where delivery_date>='#{session[:adminstart_on]} 00:00:00' and delivery_date<='#{session[:adminend_on]} 23:59:59' #{adv_id}"
                @strQuery+=" group by #{group_value}" 
                @pub_traffic_pages, @pub_traffic = paginate_by_sql AdclientsSummary,@strQuery,20
            else
                flash[:notice]="Your are not an authorized user. Please login with different username."
                redirect_to :controller=>'login', :action=>'login'
            end
        end 
    rescue Exception=>e
     puts "DEBUGGER :: ERROR :: in Admin_Analytic_Controller.rb - admin_pub_traffic_growth :: #{e.to_s}"
  end
end# End of admin_pub_traffic_growth

  #--------------------------------------------------------------------------------------------
  #Method Name: advertiser_traffic_growth
  #Purpose: Used to display the Charts for the Publisher Traffic Growth Screen.
  #Version: 1.0
  #Author: Md Shujauddeen 
  #Last Modified: 
  #Notes: to calc and format end for traffic growth.
#-------------------------------------------------------------------------------------------- .     
  def calc_endDate(*args)
        get_endate=Time.parse(args[0]).months_ago(1)
        end_year= get_endate.strftime("%Y-%m-%d").split('-')[0] #selects only year
        end_month=get_endate.strftime("%Y-%m-%d").split('-')[1]
        end_day=daysinmonth(end_year.to_i, end_month.to_i)
        formatdate=end_year.to_s+'-'+end_month.to_s+'-'+end_day.to_s
        return formatdate
  end
#--------------------------------------------------------------------------------------------
  #Method Name: admin_advertiser_traffic_growth
  #Purpose: Display chart for the Advertiser Traffic Growth.
  #Version: 1.0
  #Author:Md Shujauddeen A
  #Last Modified: 
  #Notes: None.  
#-------------------------------------------------------------------------------------------- 
  def admin_advertiser_traffic_growth
      begin
        @aes = AESSecurity.new() #creating an object for AES Security
        if (session[:user_id]==nil)
            flash[:notice]="Your session has expired. Please login again."
            redirect_to :controller=>'login', :action=>'login'
        else
            if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                # Variable Declaration
                verifyDBconnection
                #~ @advertisers=Advertiser.find_by_sql("select u.username as adv_name,a.id as adv_id from advertisers a, users u where u.status='Active' and u.id=a.user_id")
                @enddate=(Time.now-86400).strftime("%d-%b-%Y")
                @startdate= (Time.now-86400).strftime("%d-%b-%Y")
                session[:adminstart_on] = (params[:adminstart_on]!=nil && params[:adminstart_on]!="") ? params[:adminstart_on] : (session[:adminstart_on]!=nil && session[:adminstart_on]!='') ? session[:adminstart_on] : @startdate 
                session[:adminend_on] = (params[:adminend_on]!=nil && params[:adminend_on]!="") ? params[:adminend_on] : (session[:adminend_on]!=nil && session[:adminend_on]!='') ? session[:adminend_on] : @enddate
                session[:duration]=(params[:duration]!=nil && params[:duration]!="") ? params[:duration] :  (session[:duration]!=nil &&  session[:duration]!='') ?  session[:duration] : 1 
                session[:adv_name]=params[:advertiser_name] if params[:page]==nil
                if session[:adv_name]!=nil and session[:adv_name]!=""
                    if session[:adv_name].downcase=='all'
                        getAdvId='All'
                    else
                        @advertiser=Advertiser.find_by_sql("select a.id as adv_id from advertisers a, users u where u.username='#{session[:adv_name]}' and u.id=a.user_id")
                        if @advertiser!=nil
                            if @advertiser.size>0
                              getAdvId=@advertiser[0].adv_id
                            else
                              getAdvId=0
                            end
                        else
                          getAdvId=0
                        end
                    end
                else
                    getAdvId='All'
                end
                if session[:duration].to_s=='custom'
                  dur_diff=Time.parse(session[:adminend_on]) - Time.parse(session[:adminstart_on])
                  dur_diff=dur_diff/(60*60*24)
                  @chartType=dur_diff>30 ? 'bar' : 'line'
                elsif (session[:duration].to_i==0 || session[:duration].to_i == 1 || session[:duration].to_i == 6 || session[:duration].to_i == 29)
                  @chartType='line'
                else
                  @chartType='bar'
                end
                if session[:duration].to_s=='89'
                    calc_startDate=Time.parse(session[:adminend_on]).months_ago(3)
                    @start_year= calc_startDate.strftime("%Y-%m-%d").split('-')[0] #selects only year
                    @start_month=calc_startDate.strftime("%Y-%m-%d").split('-')[1]
                    startDate=@start_year+'-'+@start_month+'-'+'01'
                    endDate=calc_endDate(session[:adminend_on])
                elsif session[:duration].to_s=='179'
                    calc_startDate=Time.parse(session[:adminend_on]).months_ago(6)
                    @start_year= calc_startDate.strftime("%Y-%m-%d").split('-')[0] #selects only year
                    @start_month=calc_startDate.strftime("%Y-%m-%d").split('-')[1]
                    startDate=@start_year+'-'+@start_month+'-'+'01'
                    endDate=calc_endDate(session[:adminend_on])
                elsif session[:duration].to_s=='364'
                    calc_startDate=Time.parse(session[:adminend_on]).months_ago(12)
                    @start_year= calc_startDate.strftime("%Y-%m-%d").split('-')[0] #selects only year
                    @start_month=calc_startDate.strftime("%Y-%m-%d").split('-')[1]
                    startDate=@start_year+'-'+@start_month+'-'+'01'
                    endDate=calc_endDate(session[:adminend_on])
                elsif session[:duration].to_s=='6'
                     startDate = Time.parse(session[:adminstart_on]).strftime("%Y-%m-%d") 
                     endDate = Time.parse(session[:adminend_on]).strftime("%Y-%m-%d")
                elsif session[:duration].to_s=='1'
                     startDate = (Time.now - 2592000). strftime("%Y-%m-%d") 
                     endDate = Time.parse(session[:adminend_on]).strftime("%Y-%m-%d")
                else
                     startDate = session[:duration].to_s=='0' ? (Time.now - 2505600). strftime("%Y-%m-%d") : Time.parse(session[:adminstart_on]).strftime("%Y-%m-%d") 
                     endDate = Time.parse(session[:adminend_on]).strftime("%Y-%m-%d")
                end
                 session[:adminstart_on]= (session[:duration].to_s=='0' || session[:duration].to_s=='1') ? Time.parse(session[:adminstart_on]).strftime("%Y-%m-%d") : startDate
                 session[:adminend_on]=endDate
                 start_date= startDate
                # Display the Data in Chart.
                @XML_AdvTraffic_report = @@objXml.advertiser_traffic_growth(getAdvId,start_date,endDate,@chartType,session[:duration])
                # assign xml string to an hash and put it in a session variable for the Chart.
                @xml_string_hash={:sesAdvTrafficXML=>@XML_AdvTraffic_report}
                session[:xml_string]=@xml_string_hash
                column1=@chartType=='bar' ? 'monthname(delivery_date) as month' : 'delivery_date'
                adv_id= (getAdvId=='All' || getAdvId==nil || getAdvId=='') ? "" : " and advertiser_id='#{getAdvId}'"
                group_value= @chartType=='bar' ? "year(Delivery_Date), month(Delivery_Date)" : "year(Delivery_Date), month(Delivery_Date),Day(delivery_date)"
                @strQuery="select #{column1}, sum(impressions) as sum_impression from  campaigns_summaries"
                @strQuery+=" where delivery_date>='#{session[:adminstart_on]} 00:00:00' and delivery_date<='#{session[:adminend_on]} 23:59:59' #{adv_id}"
                @strQuery+=" group by #{group_value}"   
                @adv_traffic_pages, @adv_traffic = paginate_by_sql CampaignsSummary,@strQuery,20
            else
                flash[:notice]="Your are not an authorized user. Please login with different username."
                redirect_to :controller=>'login', :action=>'login'
            end
        end  
      rescue Exception=>e
          puts "DEBUGGER :: ERROR :: in Admin_Analytic_Controller.rb - admin_advertiser_traffic_growth :: #{e.to_s}"        
      end
  end # End of admin_advertiser_traffic_growth

#--------------------------------------------------------------------------------------------
  #Method Name: admin_pub_traffic_growth
  #Purpose:  Display chart for the Admin Traffic Growth by location.
  #Version: 1.0
  #Author:Dipti Uppal
  #Last Modified:
  #Notes: None.
#-------------------------------------------------------------------------------------------- 
 def admin_traffic_growth
      begin
          @aes = AESSecurity.new() #creating an object for AES Security
           if (session[:user_id]==nil)
                flash[:notice]="Your session has expired. Please login again."
                redirect_to :controller=>'login', :action=>'login'
           else
               if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                    @enddate=(Time.now-86400).strftime("%d-%b-%Y")
                    @startdate= (Time.now-86400).strftime("%d-%b-%Y")
                    verifyDBconnection
                    session[:adminstart_on] = (params[:adminstart_on]!=nil && params[:adminstart_on]!="") ? params[:adminstart_on] : @startdate if params[:page]==nil
                    session[:adminend_on] = (params[:adminend_on]!=nil && params[:adminend_on]!="") ? params[:adminend_on] : @enddate  if params[:page]==nil
                    session[:user_type]=(params[:user_type]!=nil && params[:user_type]!="") ? params[:user_type] : 'adv_geolocations' if params[:page]==nil
                    session[:duration]=(params[:duration]!=nil && params[:duration]!="") ?  params[:duration] : (session[:duration]!=nil && session[:duration]!="") ?  session[:duration] : 1 if params[:page]==nil
                    #@continent={"SA"=>"SOUTH AMERICA","NA"=>"NORTH AMERICA","AS"=>"ASIA","EU"=>"EUROPE","AF"=>"AFRICA","OC"=>"OCEANIA","CA"=>"CENTRAL AMERICA","ME"=>"MIDDLE EAST"}
                    @countrynameHash={"NA.AG"=>"Antigua and Barbuda","NA.BS"=>"Bahamas","NA.BB"=>"Barbados","CA.BZ"=>"Belize","NA.CA"=>"Canada","CA.CR"=>"Costa Rica","NA.CU"=>"Cuba","NA.DM"=>"Dominica","NA.DO"=>"Dominican Rep.","CA.SV"=>"El Salvador","NA.GD"=>"Grenada","CA.GT"=>"Guatemala","NA.HT"=>"Haiti","CA.HN"=>"Honduras","NA.JM"=>"Jamaica","NA.MX"=>"Mexico","CA.NI"=>"Nicaragua","CA.PA"=>"Panama","NA.KN"=>"St. Kitts & Nevis","NA.LC"=>"St. Lucia","NA.VC"=>"St. Vincent & the Grenadines","NA.TT"=>"Trinidad & Tobago","NA.US"=>"United States","NA.GL"=>"Greenland","SA.AR"=>"Argentina","SA.BO"=>"Bolivia","SA.BR"=>"Brazil","SA.CL"=>"Chile","SA.CO"=>"Colombia","SA.EC"=>"Ecuador","SA.FK"=>"Falkland Islands","SA.GF"=>"French Guiana","SA.GY"=>"Guyana","SA.PY"=>"Paraguay","SA.PE"=>"Peru","SA.SR"=>"Suriname","SA.UY"=>"Uruguay","SA.VE"=>"Venezuela","AF.DZ"=>"Algeria","AF.AO"=>"Angola","AF.BJ"=>"Benin","AF.BW"=>"Botswana","AF.BF"=>"Burkina Faso","AF.BI"=>"Burundi","AF.CM"=>"Cameroon","AF.CV"=>"Cape Verde","AF.CF"=>"Central African Republic","AF.TD"=>"Chad","AF.KM"=>"Comoros","AF.CI"=>"Cote d Ivoire","AF.CD"=>"Democratic Republic of the Congo","AF.DJ"=>"Djibouti","AF.EG"=>"Egypt","AF.GQ"=>"Equatorial Guinea","AF.ER"=>"Eritrea","AF.ET"=>"Ethiopia","AF.GA"=>"Gabon","AF.GH"=>"Ghana","AF.GN"=>"Guinea","AF.GW"=>"Guinea-Bissau","AF.KE"=>"Kenya","AF.LS"=>"Lesotho","AF.LR"=>"Liberia","AF.LY"=>"Libya","AF.MG"=>"Madagascar","AF.MW"=>"Malawi","AF.ML"=>"Mali","AF.MR"=>"Mauritania","AF.MA"=>"Morocco","AF.MZ"=>"Mozambique","AF.NA"=>"Namibia","AF.NE"=>"Niger","AF.NG"=>"Nigeria","AF.RW"=>"Rwanda","AF.ST"=>"Sao Tome and Principe","AF.SN"=>"Senegal","AF.SL"=>"Sierra Leone","AF.SO"=>"Somalia","AF.ZA"=>"South Africa","AF.SD"=>"Sudan","AF.SZ"=>"Swaziland","AF.TZ"=>"Tanzania","AF.TG"=>"Togo","AF.TN"=>"Tunisia","AF.UG"=>"Uganda","AF.ZM"=>"Zambia","AF.ZW"=>"Zimbabwe","AF.GM"=>"Gambia","AF.CG"=>"Congo","AF.MU"=>"Mauritius","AS.AF"=>"Afghanistan","AS.AM"=>"Armenia","AS.AZ"=>"Azerbaijan","AS.BD"=>"Bangladesh","AS.BT"=>"Bhutan","AS.BN"=>"Brunei","AS.MM"=>"Burma (Myanmar)","AS.KH"=>"Cambodia","AS.CN"=>"China","AS.TP"=>"East Timor","AS.GE"=>"Georgia","AS.IN"=>"India","AS.ID"=>"Indonesia","ME.IR"=>"Iran","AS.JP"=>"Japan","AS.KZ"=>"Kazakhstan","AS.KR"=>"Korea - South","AS.KG"=>"Kyrgyzstan","AS.LA"=>"Laos","AS.MY"=>"Malaysia","AS.MN"=>"Mongolia","AS.NP"=>"Nepal","AS.PK"=>"Pakistan","AS.PH"=>"Philippines","AS.RU"=>"Russian Federation","AS.SG"=>"Singapore","AS.LK"=>"Sri Lanka","AS.TJ"=>"Tajikistan","AS.TH"=>"Thailand","ME.TM"=>"Turkmenistan","ME.UZ"=>"Uzbekistan","AS.VN"=>"Vietnam","AS.TW"=>"Taiwan","AS.HK"=>"Hong Kong","AS.MO"=>"Macau","EU.AL"=>"Albania","EU.AD"=>"Andorra","EU.AT"=>"Austria","EU.BY"=>"Belarus","EU.BE"=>"Belgium","EU.BA"=>"Bosnia and Herzegovina","EU.BG"=>"Bulgaria","EU.HR"=>"Croatia","EU.CZ"=>"Czech Republic","EU.DK"=>"Denmark","EU.EE"=>"Estonia","EU.FI"=>"Finland","EU.FR"=>"France","EU.DE"=>"Germany","EU.GR"=>"Greece","EU.HU"=>"Hungary","EU.IS"=>"Iceland","EU.IE"=>"Ireland","EU.IT"=>"Italy","EU.LV"=>"Latvia","EU.LI"=>"Liechtenstein","EU.LT"=>"Lithuania","EU.LU"=>"Luxembourg","EU.MK"=>"Macedonia","EU.MT"=>"Malta","EU.MD"=>"Moldova","EU.MC"=>"Monaco","EU.MO"=>"Montenegro","EU.NL"=>"Netherlands","EU.NO"=>"Norway","EU.PL"=>"Poland","EU.PT"=>"Portugal","EU.RO"=>"Romania","EU.SM"=>"San Marino","EU.CS"=>"Serbia","EU.SK"=>"Slovakia","EU.SL"=>"Slovenia","EU.ES"=>"Spain","EU.SE"=>"Sweden","EU.CH"=>"Switzerland","EU.UA"=>"Ukraine","EU.UK"=>"United Kingdom","EU.VA"=>"Vatican City","EU.CY"=>"Cyprus","EU.TR"=>"Turkey","EU.RU"=>"Russia","OC.AU"=>"Australia","OC.FJ"=>"Fiji","OC.KI"=>"Kiribati","OC.MH"=>"Marshall Islands","OC.FM"=>"Micronesia","OC.NR"=>"Nauru","OC.NZ"=>"New Zealand","OC.PW"=>"Palau","OC.PG"=>"Papua New Guinea","OC.WS"=>"Samoa","OC.SB"=>"Solomon Islands","OC.TO"=>"Tonga","OC.TV"=>"Tuvalu","OC.VU"=>"Vanuatu","OC.NC"=>"New Caledonia","ME.BH"=>"Bahrain","ME.IQ"=>"Iraq","ME.IL"=>"Israel","ME.JO"=>"Jordan","ME.KW"=>"Kuwait","ME.LB"=>"Lebanon","ME.OM"=>"Oman","ME.QA"=>"Qatar","ME.SA"=>"Saudi Arabia","ME.SY"=>"Syria","ME.AE"=>"UnitedArabEmirates","ME.YE"=>"Yemen","NA.PR"=>"Puerto Rico","NA.KY"=>"Cayman Islands","AF.YT"=>"Mayotte","AF.RE"=>"Reunion","AQ.AQ"=>"Antarctica","AS.MV"=>"Maldives","EU.AX"=>"Aland Islands","EU.GI"=>"Gibraltar","EU.FO"=>"Faroe Islands","NA.BM"=>"Bermuda","NA.TC"=>"Turks and Caicos Islands","NA.AI"=>"Anguilla","NA.MS"=>"Montserrat","NA.VI"=>"Virgin Islands - British","NA.GP"=>"Guadeloupe","NA.AW"=>"Aruba","NA.AN"=>"Netherlands Antilles","NA.MQ"=>"Martinique","OC.MP"=>"Northern Mariana Islands","OC.CK"=>"Cook Islands","OC.GU"=>"Guam","OC.PF"=>"French Polynesia","OC.NU"=>"Niue","OC.NF"=>"Norfolk Island","OC.UM"=>"United States Minor Outlying Islands","OC.TK"=>"Tokelau","OC.AS"=>"American Samoa","EU.GB"=>"United Kingdom","EU.JE"=>"Jersey","AF.SC"=>"Seycelles","AS.KP"=>"Korea - North","AS.PS"=>"Palestinian Territory","AS.IO"=>"British Indian Ocean Territory","CA.PM"=>"Saint Pierre and Miquelon","NA.VG"=>"Virgin Islands"}
                    request='impressions'
                    #frame query to get hourly traffic recordset from database.
                    query= "select continent_code,country_code, sum(#{request}) as sum_requests from #{session[:user_type]}" 
                    query+=" where delivery_date>='#{(Time.parse(session[:adminstart_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:adminend_on])).strftime("%Y-%m-%d")} 23:59:59' and #{request} > 0" 
                    query+= " group by continent_code,country_code order by sum_requests desc"
                    #following code is used to retrive recordset from database
                    @trafficdata_pages, @trafficdata = paginate_by_sql CampaignsSummary,query,20                
                    @XML_Traffic_report = @@objXml.admin_traffic_growth_continent(session[:adminstart_on],session[:adminend_on],session[:user_type])
                    @xml_string_hash={:sesTrafficXML=>@XML_Traffic_report}
                    session[:xml_string]=@xml_string_hash
                else
                    flash[:notice]="Your are not an authorized user. Please login with different username."
                    redirect_to :controller=>'login', :action=>'login'
                end
            end
      rescue Exception=>e
          puts "DEBUGGER :: ERROR :: in Admin_Analytic_Controller.rb - admin_traffic_growth_continent :: #{e.to_s}"
      end
end# End of admin_traffic_growth_continent
 #--------------------------------------------------------------------------------------------
  #Method Name: admin_device_summary
  #Purpose: Display chart for the top 5 Devices being served.
  #Version: 1.0
  #Author:Dipti Uppal
  #Last Modified: Md Shujauddeen
  #Notes: None.
#-------------------------------------------------------------------------------------------- .
def admin_handset_model
    begin
        @aes = AESSecurity.new() #creating an object for AES Security
        if (session[:user_id]==nil)
            flash[:notice]="Your session has expired. Please login again."
            redirect_to :controller=>'login', :action=>'login'
        else
            if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                # Get the Today and One Month Back Date for the UI.
                @enddate=(Time.now-86400).strftime("%d-%b-%Y")
                @startdate= (Time.now-86400).strftime("%d-%b-%Y")
                verifyDBconnection
                session[:adminstart_on] = (params[:adminstart_on]!=nil && params[:adminstart_on]!="") ? params[:adminstart_on] : (session[:adminstart_on]!=nil && session[:adminstart_on]!="") ? session[:adminstart_on] : @startdate if params[:page]==nil
                session[:adminend_on] = (params[:adminend_on]!=nil && params[:adminend_on]!="") ? params[:adminend_on] : (session[:adminend_on]!=nil && session[:adminend_on]!="") ? session[:adminend_on] :@enddate if params[:page]==nil
                # Display the Data in Chart.
                session[:handset]=params[:model] if params[:model] !=nil && params[:model]!=''
                @handset='Unknown'   #handset param can only be unknown since we comment the models
                session[:country_name] = (params[:country_name]!=nil && params[:country_name]!="") ? params[:country_name] : (session[:country_name]!='' and session[:country_name]!=nil) ? session[:country_name]  : 'All' if params[:page]==nil
                session[:filled] = (params[:filled]!=nil && params[:filled]!="") ? params[:filled] : (session[:filled]!=nil and session[:filled]!="") ? session[:filled] : 'filled' if params[:page]==nil
                session[:duration]=(params[:duration]!=nil && params[:duration]!="") ?  params[:duration] : (session[:duration]!=nil && session[:duration]!="") ?  session[:duration] : 1 if params[:page]==nil
                session[:limit]=limit=(params[:limit]!=nil && params[:limit]!="") ? params[:limit] : (session[:limit]!=nil && session[:limit]!="") ? session[:limit] : 10  if params[:page]==nil
                @xml_deivce_model = @@objXml.device_model_summary(session[:adminstart_on],session[:adminend_on],session[:limit],session[:country_name],session[:filled],@handset) if session[:handset].to_s!='Unknown'
                get_col=session[:filled]=='filled' ? "sum(impressions)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "sum(fill_rate)+sum(impressions)"
                filter_col=session[:filled]=='filled' ? "and impressions>0" : session[:filled]=='unfilled' ? "and fill_rate>0" : "and (impressions>0 or fill_rate>0)"
                get_country=session[:country_name].upcase=='ALL' ? "" : "ac.country_name='#{session[:country_name]}' and ad.continent_code=ac.continent_code and ad.country_code=ac.country_code and"
                filter_table=session[:country_name].upcase=='ALL' ? "devices_summaries ad" : "devices_summaries ad,analytics_country_list ac"
                get_handset=@handset.to_s=='Unknown' ? "and handset=''"  : "and handset='#{@handset}'"
                browser_type=@handset.to_s=='Unknown' ? "(select wd.browser_type from analytics_wurfl_devices wd where wd.user_agent=ad.user_agent) as browser,"  : ""
                sub_sql="((#{get_col})/(select #{get_col} as total_c from #{filter_table} where #{get_country} delivery_date>='#{(Time.parse(session[:adminstart_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse( session[:adminend_on] )).strftime("%Y-%m-%d")} 23:59:59' #{get_handset} #{filter_col}))*100 as percentage"
                sql="select #{@handset.to_s=='Unknown' ? 'user_agent' : 'handset_model'} as device_model,#{browser_type}#{get_col} as traffic, #{sub_sql} from #{filter_table} where #{get_country} delivery_date>='#{(Time.parse(session[:adminstart_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse( session[:adminend_on] )).strftime("%Y-%m-%d")} 23:59:59' #{get_handset} #{filter_col} group by device_model order by traffic desc"
                @handset_model_pages, @handset_model = paginate_by_sql CampaignsSummary,sql,20
            else
                flash[:notice]="Your are not an authorized user. Please login with different username."
                redirect_to :controller=>'login', :action=>'login'
            end
        end 
    rescue Exception=>e
          puts "DEBUGGER :: ERROR :: in Admin_Analytic_Controller.rb - admin_device_summary :: #{e.to_s}"
    end
end # End of admin_advertiser_performance

 #--------------------------------------------------------------------------------------------
  #Method Name: admin_device_summary
  #Purpose: Display chart for the top 5 Devices being served.
  #Version: 1.0
  #Author:Dipti Uppal
  #Last Modified: Md Shujauddeen
  #Notes: None.
#-------------------------------------------------------------------------------------------- .
def admin_devices_summary
    begin
        @aes = AESSecurity.new() #creating an object for AES Security
        if (session[:user_id]==nil)
            flash[:notice]="Your session has expired. Please login again."
            redirect_to :controller=>'login', :action=>'login'
        else
            if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                # Get the Today and One Month Back Date for the UI.
                @enddate=(Time.now-86400).strftime("%d-%b-%Y")
                @startdate= (Time.now-86400).strftime("%d-%b-%Y")
                verifyDBconnection
                session[:adminstart_on] = (params[:adminstart_on]!=nil && params[:adminstart_on]!="") ? params[:adminstart_on] : (session[:adminstart_on]!=nil && session[:adminstart_on]!="") ? session[:adminstart_on] : @startdate if params[:page]==nil
                session[:adminend_on] = (params[:adminend_on]!=nil && params[:adminend_on]!="") ? params[:adminend_on] : (session[:adminend_on]!=nil && session[:adminend_on]!="") ? session[:adminend_on] : @enddate if params[:page]==nil
                # Display the Data in Chart.
                session[:country_name] = (params[:country_name]!=nil && params[:country_name]!="") ? params[:country_name] : (session[:country_name]!='' and session[:country_name]!=nil) ? session[:country_name]  : 'All' if params[:page]==nil
                session[:filled] = (params[:filled]!=nil && params[:filled]!="") ? params[:filled] : (session[:filled]!=nil and session[:filled]!="") ? session[:filled] : 'filled' if params[:page]==nil
                session[:duration]=(params[:duration]!=nil && params[:duration]!="") ? params[:duration] : (session[:duration]!=nil && session[:duration]!="") ? session[:duration] : 1 if params[:page]==nil
                session[:limit]=limit=(params[:limit]!=nil && params[:limit]!="") ? params[:limit] : (session[:limit]!=nil && session[:limit]!="") ? session[:limit] : 10  if params[:page]==nil
                @xml_device_summary = @@objXml.device_summary(session[:adminstart_on],session[:adminend_on],session[:limit],session[:country_name],session[:filled])
                get_col=session[:filled]=='filled' ? "sum(impressions)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "sum(fill_rate)+sum(impressions)"
                filter_col=session[:filled]=='filled' ? "and impressions>0" : session[:filled]=='unfilled' ? "and fill_rate>0" : "and (impressions>0 or fill_rate>0)"
                get_country=session[:country_name].upcase=='ALL' ? "" : "ac.country_name='#{session[:country_name]}' and ad.continent_code=ac.continent_code and ad.country_code=ac.country_code and"
                filter_table=session[:country_name].upcase=='ALL' ? "devices_summaries" : "devices_summaries ad,analytics_country_list ac"
                sub_sql="((#{get_col})/(select #{get_col} as total_c from #{filter_table} where #{get_country} delivery_date>='#{(Time.parse(session[:adminstart_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse( session[:adminend_on] )).strftime("%Y-%m-%d")} 23:59:59' #{filter_col}))*100 as percentage"
                sql="select handset,#{get_col} as traffic, #{sub_sql} from #{filter_table} where #{get_country} delivery_date>='#{(Time.parse(session[:adminstart_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse( session[:adminend_on] )).strftime("%Y-%m-%d")} 23:59:59' #{filter_col} group by handset order by traffic desc"
                @handsets_pages, @handsets = paginate_by_sql CampaignsSummary,sql,20
            else
                flash[:notice]="Your are not an authorized user. Please login with different username."
                redirect_to :controller=>'login', :action=>'login'
            end
        end 
    rescue Exception=>e
          puts "DEBUGGER :: ERROR :: in Admin_Analytic_Controller.rb - admin_device_summary :: #{e.to_s}"
    end
end # End of admin_advertiser_performance
   
   #--------------------------------------------------------------------------------------------
  #Method Name: pdf_open
  #Purpose: This method will be used to display the Data in the PDF format.
  #Version: 1.0
  #Author:Dipti Uppal
  #Last Modified:
  #Notes: None.
#-------------------------------------------------------------------------------------------- .
 
   def pdf_open()
     begin
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                  if session[:intPage]!=nil
                    @intPage = session[:intPage]
                    @intPage.to_i*10 - 10
                  end
                  if params[:ReportType]!= nil
                    @reportType=params[:ReportType]
                    @c2="Impressions"
                    @c3="Clicks" 
                    @c4="CTR"
                 end
                 if @reportType=="Campaign_Performance"
                 #Initialize array with pdf table column name.
                  @c1="Campaign Name"  
                  @c5="CPM"  
                  @c6="CPC"  
                  @c7="ZestADZ Revenue"                                    
                  @pdf_arr=[@c1,@c2,@c3,@c4,@c5,@c6,@c7] 
                  # Execute the Query.
                  @strQuery="select Campaign_Name, sum(Impressions) as Impressions, Clicks,CTR, CPM,CPC, ZestADZ_Revenue from campaigns_summaries group by Campaign_Name order by Impressions desc limit 10 offset #{@intPage}"
                  @recordset = CampaignsSummary.find_by_sql(@strQuery)
                elsif @reportType=="Publisher_Performance"
                 #Initialize array with pdf table column name.
                  @c1="Publisher Name"  
                  @c5="ECPM"  
                  @c6="Publisher Revenue"                                    
                  @pdf_arr=[@c1,@c2,@c3,@c4,@c5,@c6] #initialize array with pdf table column name.
                  # Execute the Query.
                  @strQuery="select pub_name as Publisher_Name, impressions as Impressions, clicks as Clicks ,ctr as CTR, ecpm as ECPM , revenue as Publisher_Revenue from adclients_summaries group by pub_name order by Impressions desc limit 10 offset #{@intPage}"
                  @recordset = AdclientsSummary.find_by_sql(@strQuery)
                elsif @reportType=="Advertiser_Performance"
                 #Initialize array with pdf table column name.
                  @c1="Advertiser Name"  
                  @c5="CPM"  
                  @c6="CPC"                                    
                  @pdf_arr=[@c1,@c2,@c3,@c4,@c5,@c6] #initialize array with pdf table column name.
                  # Execute the Query.
                  @strQuery="select Advertiser_Name,Impressions,Clicks,CTR,CPM,CPC from campaigns_summaries group by Advertiser_Name order by Impressions desc limit 10 offset #{@intPage}"
                  @recordset = CampaignsSummary.find_by_sql(@strQuery)            
                end
                pdf = PDF::Writer.new
                pdf.margins_pt(33,21)
                pdf.select_font("Helvetica")
                pdf.image "#{RAILS_ROOT}/public/images/zestadz_logo.JPG",:resize => 0.80
                #pdf.text("No Date", :font_size => 7,:justification => :right)
                pdf.text("")
                PDF::SimpleTable.new do |tab|
                  tab.title = "Zestadz #{params[:ReportType]} Report"
                  tab.column_order.push(*@pdf_arr)
                  tab.columns[@reportType] = PDF::SimpleTable::Column.new(@column1) { |col|
                    col.heading = @reportType
                    col.width = 90
                  }
                  tab.show_lines    = :all
                  tab.show_headings = true
                  tab.orientation   = :center
                  tab.position      = :center
                  data = []
                  
                  for pdf_data in @recordset
                    if @reportType=="Campaign_Performance" 
                      data << { "#{@c1}" => "#{pdf_data.Campaign_Name}", "#{@c2}" => "#{pdf_data.Impressions==nil ? 0 : pdf_data.Impressions}", "#{@c3}" => "#{pdf_data.Clicks==nil ? 0 : pdf_data.Clicks}", "#{@c4}" => "#{pdf_data.CTR==nil ? 0.00 : sprintf('%.2f',pdf_data.CTR)}%" , "#{@c5}" => "#{pdf_data.CPM}",  "#{@c6}" => "#{pdf_data.CPC}", "#{@c7}" => "#{pdf_data.ZestADZ_Revenue}"}
                    elsif @reportType=="Publisher_Performance"  
                      data << { "#{@c1}" => "#{pdf_data.Publisher_Name}", "#{@c2}" => "#{pdf_data.Impressions==nil ? 0 : pdf_data.Impressions}", "#{@c3}" => "#{pdf_data.Clicks==nil ? 0 : pdf_data.Clicks}", "#{@c4}" => "#{pdf_data.CTR==nil ? 0.00 : sprintf('%.2f',pdf_data.CTR)}%" , "#{@c5}" => "#{pdf_data.ECPM}",  "#{@c6}" => "#{pdf_data.Publisher_Revenue}"}
                    elsif @reportType=="Advertiser_Performance"
                      data << { "#{@c1}" => "#{pdf_data.Advertiser_Name}", "#{@c2}" => "#{pdf_data.Impressions==nil ? 0 : pdf_data.Impressions}", "#{@c3}" => "#{pdf_data.Clicks==nil ? 0 : pdf_data.Clicks}", "#{@c4}" => "#{pdf_data.CTR==nil ? 0.00 : sprintf('%.2f',pdf_data.CTR)}%" , "#{@c5}" => "#{pdf_data.CPM}",  "#{@c6}" => "#{pdf_data.CPC}"}
                    end
                  end
                  tab.data.replace data
                  tab.render_on(pdf)
                  send_data pdf.render, :filename => "zestAdz.pdf",:type => "application/pdf"
                end
              else
                  flash[:notice]="Your are not an authorized user. Please login with different username."
                  redirect_to :controller=>'login', :action=>'login'
              end
          end
        rescue Exception=>e
            puts "DEBUG :: ERROR :: in AdminAnalyticController - pdf_open method Exception :: #{e.to_s}"
        end
    end # end of pdf_open 
  
#--------------------------------------------------------------------------------------------
  #Method Name: csv_open
  #Purpose: This method will be used to display the Data in the CSV format.
  #Version: 1.0
  #Author:Dipti Uppal
  #Last Modified:
  #Notes: None.
#-------------------------------------------------------------------------------------------- .
 
  def csv_open()
      begin
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                  verifyDBconnection
                  if session[:intPage]!=nil
                      @intPage = session[:intPage]
                      @intPage.to_i*10 - 10
                  end
                  csv_string = FasterCSV.generate do |csv|    
                  if params[:ReportType] != nil
                      @reportType=params[:ReportType] 
                      @c2="Impressions"
                      @c3="Clicks" 
                      @c4="CTR"
                  end
                   if @reportType=="Campaign_Performance"
                        #Initialize array with pdf table column name.
                        @c1="Campaign Name"  
                        @c5="CPM"  
                        @c6="CPC"  
                        @c7="ZestADZ Revenue"                                    
                        csv << ["#{@c1}","#{@c2}","#{@c3}","#{@c4}", "#{@c5}","#{@c6}","#{@c7}"]
                        # Execute the Query.
                        @strQuery="select Campaign_Name, sum(Impressions) as Impressions, Clicks,CTR, CPM,CPC, ZestADZ_Revenue from campaigns_summaries group by Campaign_Name order by Impressions desc limit 10 offset #{@intPage}"
                        @recordset = CampaignsSummary.find_by_sql(@strQuery)
                    elsif @reportType=="Publisher_Performance"
                        #Initialize array with pdf table column name.
                        @c1="Publisher Name"  
                        @c5="ECPM"  
                        @c6="Publisher Revenue"                                    
                        csv << ["#{@c1}","#{@c2}","#{@c3}","#{@c4}", "#{@c5}","#{@c6}"]
                        # Execute the Query.
                        @strQuery="select pub_name as Publisher_Name, impressions as Impressions, clicks as Clicks ,ctr as CTR, ecpm as ECPM , revenue as Publisher_Revenue from adclients_summaries group by pub_name order by Impressions desc limit 10 offset #{@intPage}"
                        @recordset = AdclientsSummary.find_by_sql(@strQuery)
                    elsif @reportType=="Advertiser_Performance"
                        #Initialize array with pdf table column name.
                        @c1="Advertiser Name"  
                        @c5="CPM"  
                        @c6="CPC"                                    
                        csv << ["#{@c1}", "#{@c2}","#{@c3}","#{@c4}","#{@c5}","#{@c6}"]
                        # Execute the Query.
                        @strQuery="select Advertiser_Name,Impressions,Clicks,CTR,CPM,CPC from campaigns_summaries group by Advertiser_Name order by Impressions desc limit 10 offset #{@intPage}"
                        @recordset = CampaignsSummary.find_by_sql(@strQuery)            
                    end
                    for  csv_data in @recordset
                        if @reportType=="Campaign_Performance" 
                            csv << [csv_data.Campaign_Name,"#{csv_data.Impressions==nil ? 0 : csv_data.Impressions}","#{csv_data.Clicks==nil ? 0 : csv_data.Clicks}","#{csv_data.CTR==nil ? 0.00 : sprintf('%.2f',csv_data.CTR)}%","#{csv_data.CPM}","#{csv_data.CPC}","#{csv_data.ZestADZ_Revenue}"]                    
                        elsif @reportType=="Publisher_Performance"  
                            csv << [csv_data.Publisher_Name,"#{csv_data.Impressions==nil ? 0 : csv_data.Impressions}","#{csv_data.Clicks==nil ? 0 : csv_data.Clicks}","#{csv_data.CTR==nil ? 0.00 : sprintf('%.2f',csv_data.CTR)}%","#{csv_data.ECPM}","#{csv_data.Publisher_Revenue}"]                    
                        elsif @reportType=="Advertiser_Performance"
                            csv << [csv_data.Advertiser_Name,"#{csv_data.Impressions==nil ? 0 : csv_data.Impressions}","#{csv_data.Clicks==nil ? 0 : csv_data.Clicks}","#{csv_data.CTR==nil ? 0.00 : sprintf('%.2f',csv_data.CTR)}%","#{csv_data.CPM}","#{csv_data.CPC}"]                                        
                        end
                      end
                    end  #csv do ends here
                    filename = "zestadzAdmin".downcase.gsub(/[^0-9a-z]/, "_") + ".csv" 
                    send_data(csv_string, :type => 'text/csv; charset=utf-8; header=present', :filename => filename)
            else
                flash[:notice]="Your are not an authorized user. Please login with different username."
                redirect_to :controller=>'login', :action=>'login'
            end
        end
      rescue Exception=>e
          puts "DEBUG :: ERROR :: in AdminAnalyticController - csv_open method Exception :: #{e.to_s}"
      end # end of csv_open
  end
  

 #**********************************************************************************************************************************************************
 #-------------------------------------------------------------advertiser section integration starts here-----------------------------------------------------------------------------
 #**********************************************************************************************************************************************************
 
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#Method Name: get_ad_list
	#Purpose: To list  ads list for particular campaign in advertiser analytic home page.
	#Version: 1.0
	#Author: Sathish Kumar Sadhasivam
	#Last Modified: 20-Sep-2008 by Sathish Kumar Sadhasivam
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	def get_adlist
      begin
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                  verifyDBconnection
                  @camp_id=@aes.decrypt(session[:key],session[:iv],params[:campaign_id])
                  if @camp_id!='SMS' and @camp_id!='WAP'
                      @ad_list=Ad.find(:all,:conditions=>["campaign_id = ?",@camp_id])
                  end
                  render :action=>'get_adlist',:layout=>false
              else
                  flash[:notice]="Your are not an authorized user. Please login with different username."
                  redirect_to :controller=>'login', :action=>'login'
              end
          end
      rescue Exception => e
          puts "DEBUGGER :: ERROR :: in admin_analytic_controller - get_ad_list method :: #{e.to_s}"
          render :layout=>false
      end
	end
 
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#Method Name: advertiser_home
	#Purpose: rendering the advertiser analytic home page.
	#Version: 1.0
	#Author: Sathish Kumar Sadhasivam
	#Last Modified: 08-Oct-2008 by Md Shujauddeen A
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    def advertiser_home
      begin
      puts"---------------------adv_home---------------------"
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                  @enddate=(session[:adminend_on]==nil || session[:adminend_on]=="") ? (Time.now-86400).strftime("%d-%b-%Y") : session[:adminend_on]
                  @startdate= (session[:adminstart_on]==nil || session[:adminstart_on]=="") ? (Time.now-86400).strftime("%d-%b-%Y") : session[:adminstart_on]
                  session[:page]=params[:page]==""? 0 : params[:page].to_i*10
                  verifyDBconnection
                  session[:advreport_camp_id] =@aes.decrypt(session[:key],session[:iv],params[:campaign_id]) if params[:campaign_id]!=nil
                  analytic=params[:analytic] 
                  session[:check_history]=@history=params[:from] if params[:from]
                  session[:advertiser_id]=@aes.decrypt(session[:key],session[:iv],params[:advertiser_id]) if params[:advertiser_id]!=nil
                  @camp_list=Campaign.find(:all, :conditions=>["id = ? ",session[:advreport_camp_id]],:order => "status='Approved' desc")  if @history=='campaign'or (@history==nil and session[:advreport_camp_id])
                  @camp_list=Campaign.find(:all, :conditions=>["advertiser_id = ? ",session[:advertiser_id]],:order => "status='Approved' desc") if @history=='advertiser' or (@history==nil and session[:advertiser_id])
                  disp_adv_id=@camp_list[0].advertiser_id
                  disp_user_id=Advertiser.find_by_id(disp_adv_id.to_i).user_id
                  session[:disp_username]=User.find_by_id(disp_user_id).username
                  @ad_list=Ad.find(:all,:conditions=>["campaign_id = ?",session[:advreport_camp_id]],:order => "status='Approved' desc") if session[:advreport_camp_id]!='SMS' and session[:advreport_camp_id]!='WAP'
                  if analytic=='refresh' 
                        session[:adv_id]=disp_adv_id
                        selectCamp=params[:from]=='campaign' ? @camp_list[0].id : "WAP"
                        redirect_to :action=>'generate_adv_report',:advertiser_id=>@aes.encrypt(session[:key],session[:iv],"#{params[:advertiser_id]}"),:campaign_id=>@aes.encrypt(session[:key],session[:iv],"#{selectCamp}"),:ad_id=>@aes.encrypt(session[:key],session[:iv],"All"),:adv_start_on=>@startdate,:adv_end_on=>@enddate,:statistics=>'impressions',:duration=>"#{session[:duration]}",:from=>@history
                  else
                        @adid=session[:advreport_ad_id]
                        # ad id will ad the condition on query depends upon the selection
                        @adid= (@adid=="All" || @adid=="" || @adid==nil) ? "" : " and ad_id=#{@adid} "
                        campaignId= (session[:advreport_camp_id]=="SMS" || session[:advreport_camp_id]=="WAP" || session[:advreport_camp_id]==nil) ? "" : " and campaign_id=#{session[:advreport_camp_id]} "
                        ad_type=(session[:advreport_camp_id]=="SMS" || session[:advreport_camp_id]=="WAP" ) ? " and ad_client_type='#{session[:advreport_camp_id]}'" : ""
                        count_imp_click="select sum(clicks) as clicks , sum(impressions) as impressions ,((sum(clicks)/sum(impressions))*100)  as ctr, sum(amount_spent) as amount_spent from campaigns_summaries where advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' #{ad_type} group by advertiser_id"
                         puts "----------------------------------------"
                         puts count_imp_click.inspect
                         @camp_details= AdvCarrier.find_by_sql(count_imp_click)
                        begin
                            if @camp_details!=nil
                                if @camp_details[0]!=nil
                                    @impressions=@camp_details[0].impressions
                                    @clicks=@camp_details[0].clicks
                                    @ctr=@camp_details[0].ctr.to_f
                                    @amount_spent=@camp_details[0].amount_spent.to_f
                                else
                                    @impressions=0
                                    @clicks=0
                                    @ctr=0
                                    @amount_spent=0
                                end
                            end
                        rescue Exception=>e
                        end
                  end
              else
                  flash[:notice]="Your are not an authorized user. Please login with different username."
                  redirect_to :controller=>'login', :action=>'login'
              end
        end
      rescue Exception=>e
          puts "DEBUGGER :: ERROR :: in admin_analytic_controller - advertiser_home method :: #{e.to_s}"
      end
    end
  
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#Method Name: generate_adv_report
	#Purpose: To genenrate the all charts xml. 
	#Version: 1.0
	#Author: Sathish Kumar Sadhasivam
	#Last Modified: 08-Oct-2008 by Md Shujauddeen A
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	  
	def generate_adv_report
		begin
         @aes = AESSecurity.new() #creating an object for AES Security
         if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                    #creating the neccessary variables.
                    advxml_string_hash=Hash.new
                    advxml_array_hash=Hash.new
                    @smartLabel='0' #0 represent smartLable as disabled
                    verifyDBconnection
                    session[:advreport_camp_id]=@aes.decrypt(session[:key],session[:iv],params[:campaign_id]) if params[:campaign_id]!=nil
                    session[:advreport_ad_id]=@aes.decrypt(session[:key],session[:iv],"#{params[:ad_id]}")
                    session[:adminstart_on]=session[:advreport_start_on]=params[:adv_start_on] if params[:adv_start_on]!=nil
                    session[:adminend_on]=session[:advreport_end_on]=params[:adv_end_on] if params[:adv_end_on]!=nil
                    session[:duration]=params[:duration]
                    session[:page]=params[:page]==""? 0 : params[:page].to_i
                    #~ @campaign=Campaign.find(session[:advreport_camp_id]) if params[:campaign_id]!=nil
                    report_type=session[:advreport_type]=params[:statistics] if params[:statistics]!=nil
                    # building the start and end date
                    @enddate= session[:advreport_end_on]? session[:advreport_end_on]:(Time.now).strftime("%d-%b-%Y") 
                    @startdate= session[:advreport_start_on]? session[:advreport_start_on]:(Time.now-(60*60*24*30)).strftime("%d-%b-%Y")
                    camp_id=@aes.decrypt(session[:key],session[:iv],params[:campaign_id])
                    history=params[:from] if params[:from]
                    #~ camp_list=Campaign.find(:all, :conditions=>["id = ? ",params[:campaign_id]]) if history=='campaign'
                    #~ camp_list=Campaign.find(:all, :conditions=>["advertiser_id = ? ",@campaign.advertiser_id]) if history=='advertiser'
                    ad_id=params[:ad_id]
                    #~ session[:advreport_camp_id]=camp_list[0].id if params[:campaign_id]==nil
                    #~ @ad_list=Ad.find(:all,:conditions=>["campaign_id = ?",session[:advreport_camp_id]]) if camp_list!=nil
                    #~ @campaign=Campaign.find(camp_id)
                    if camp_id!='WAP' and camp_id!='SMS'
                        campaign=Campaign.find(camp_id) 
                        ad_type=(campaign.ad_medium).upcase
                    end
                    if ad_id!=nil and ad_id!=""
                        #calls generate query method to construct TRAFFIC query and xml - Query for Traffic Sources 
                          advXML_summary_report=@@obj.generate_query(session[:advreport_camp_id],session[:advreport_ad_id],"#{session[:adv_id]}-campaigns_summaries-#{session[:duration]}",'Campaigns_Summary','delivery_date',report_type,params[:adv_start_on],params[:adv_end_on])
                          if advXML_summary_report==nil
                                  advXML_summary_report={:xml_string=>nil,:xml_array=>nil} 
                          end
                          #calls generate query method to construct summary on devices (Handsets) query and xml - Query for Device_Summary
                          advXML_handset_report=@@obj.generate_query(session[:advreport_camp_id],session[:advreport_ad_id],"#{session[:adv_id]}-adv_handsets-#{session[:duration]}-#{@smartLabel}",'Device_Summary','delivery_date',report_type,params[:adv_start_on],params[:adv_end_on],'handset','impressions','','admin_analytic') if ad_type!='SMS' and camp_id!='SMS'
                           if advXML_handset_report==nil
                                    advXML_handset_report={:xml_string=>nil,:xml_array=>nil} 
                          end
                          #calls generate query method to construct summary on hour basis (hourly traffic) query and xml - Query for hourly_report
                          #~ advXML_hourly_report=@@obj.generate_query(session[:advreport_camp_id],session[:advreport_ad_id],"#{session[:adv_id]}-campaigns_summaries-#{session[:duration]}",'hourly_report','delivery_hour','impressions',params[:adv_start_on],params[:adv_end_on]) 
                          #~ if advXML_hourly_report==nil
                              #~ advXML_hourly_report={:xml_string=>nil,:xml_array=>nil} 
                          #~ end
                          #calls generate query method to construct summary on carrier (carrier traffic) query and xml - Query for Carrier_Traffic
                          advXML_carrier_report=@@obj.generate_query(session[:advreport_camp_id],session[:advreport_ad_id],"#{session[:adv_id]}-adv_carriers-#{session[:duration]}-#{@smartLabel}",'Carrier_Traffic','delivery_date',report_type,params[:adv_start_on],params[:adv_end_on],'operator', 'requests','','admin_analytic')  if ad_type!='SMS' and camp_id!='SMS'
                          if advXML_carrier_report==nil
                              advXML_carrier_report={:xml_string=>nil,:xml_array=>nil} 
                          end
                          #calls generate query method to construct summary on continent (traffic) query and xml - Query for Carrier_Traffic
                          advXML_continent_traffic_report=@@obj.generate_query(session[:advreport_camp_id],session[:advreport_ad_id],"#{session[:adv_id]}-adv_geolocations-#{session[:duration]}",'Traffic','delivery_date',report_type,params[:adv_start_on],params[:adv_end_on],'continent_code', 'impressions','continent_code','admin_analytic')  if ad_type!='SMS' and camp_id!='SMS'
                          if advXML_continent_traffic_report==nil
                              advXML_continent_traffic_report={:xml_string=>nil,:xml_array=>nil} 
                          end
                          #calls generate query method to construct summary on device property query and xml - Query for Device Property 
                          advXML_device_property_traffic_report=@@obj.generate_query(session[:advreport_camp_id],session[:advreport_ad_id],"#{session[:adv_id]}-adv_devicesproperties-#{session[:duration]}-#{@smartLabel}",'DeviceProperties_Traffic','delivery_date',report_type,params[:adv_start_on],params[:adv_end_on])  if ad_type!='SMS' and camp_id!='SMS'
                          if advXML_device_property_traffic_report==nil
                              advXML_device_property_traffic_report={:xml_string=>nil,:xml_array=>nil} 
                          end
                          #calls generate query method to construct campaign's ad wise summary query and xml - Query for ad wise  
                          advXML_ad_wise_report=@@obj.generate_query(session[:advreport_camp_id],session[:advreport_ad_id],"#{session[:adv_id]}-campaigns_summaries-#{session[:duration]}",'Ad_Wise','a.name as ad_name',report_type,params[:adv_start_on],params[:adv_end_on])  
                          if advXML_ad_wise_report==nil
                              advXML_ad_wise_report={:xml_string=>nil,:xml_array=>nil}
                          end
                            
                           advXML_visitor_report=@@obj.generate_query(session[:advreport_camp_id],session[:advreport_ad_id],"#{session[:adv_id]}-campaigns_summaries-#{session[:duration]}",'Campaigns_Summary','delivery_date','unique_visitors',params[:adv_start_on],params[:adv_end_on])
                          if advXML_visitor_report==nil
                                  advXML_visitor_report={:xml_string=>nil,:xml_array=>nil} 
                          end 
                            
                    else
                          #AD Id is nil, reset all the hashs to nil
                          advXML_summary_report={:xml_string=>nil,:xml_array=>nil} 
                          advXML_handset_report={:xml_string=>nil,:xml_array=>nil}
                          advXML_hourly_report={:xml_string=>nil,:xml_array=>nil}
                          advXML_carrier_report={:xml_string=>nil,:xml_array=>nil} 
                          advXML_continent_traffic_report={:xml_string=>nil,:xml_array=>nil} 
                          advXML_device_property_traffic_report={:xml_string=>nil,:xml_array=>nil} 
                          advXML_ad_wise_report={:xml_string=>nil,:xml_array=>nil}
                          advXML_visitor_report={:xml_string=>nil,:xml_array=>nil} 
                         end
                    advXML_string_hash={:summary=>advXML_summary_report[:xml_string],:handset=>advXML_handset_report[:xml_string],:carrier=>advXML_carrier_report[:xml_string],:continent_traffic=>advXML_continent_traffic_report[:xml_string],:device_property=>advXML_device_property_traffic_report[:xml_string],:adwise=>advXML_ad_wise_report[:xml_string],:unique_visitor=>advXML_visitor_report[:xml_string]}
                    advXML_array_hash={:handsets_arr=>advXML_handset_report[:xml_array],:carrier_arr=>advXML_carrier_report[:xml_array],:device_property_arr=>advXML_device_property_traffic_report[:xml_array],:adwise_arr=>advXML_ad_wise_report[:xml_array]}
                    # putting the hashes into the session variables to access that in views
                    session[:advxml_string]=advXML_string_hash
                    session[:advxml_array]=advXML_array_hash
                    #rendering the advertiser_home action 
                    redirect_to :controller=>'admin_analytic', :action=>'advertiser_home',:from=>history, :getAdid=>ad_id
              else
                  flash[:notice]="Your are not an authorized user. Please login with different username."
                  redirect_to :controller=>'login', :action=>'login'
              end
          end
      rescue Exception=>e
          puts "DEBUGGER :: ERROR :: in advertiser_analytic_controller - generate_adv_report method Exception :: #{e.to_s}"
      end
    end
    
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#Method Name: advertiser_continent	
	#Purpose: To show the adwise chart in adwise home page. It shows the particular campaign's all ads performance chart. 
	#Version: 1.0
	#Author: Sathish Kumar Sadhasivam
	#Last Modified: 20-Sep-2008 by Md Shujauddeen
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  def advertiser_uniquevisitor
      begin
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                  adid= (session[:advreport_ad_id]=="All" ) ? "" : " and ad_id=#{session[:advreport_ad_id]} "
                  campaignId= (session[:advreport_camp_id]=="SMS" || session[:advreport_camp_id]=="WAP" || session[:advreport_camp_id]==nil) ? "" : " and campaign_id=#{session[:advreport_camp_id]} "
                  @xml_unique_visitors=@@obj.generate_query(session[:advreport_camp_id],session[:advreport_ad_id],"#{session[:adv_id]}-campaigns_summaries-#{session[:duration]}",'Campaigns_Summary','delivery_date','unique_visitors',session[:advreport_start_on],session[:advreport_end_on])
                  ad_type=(session[:advreport_camp_id]=="SMS" || session[:advreport_camp_id]=="WAP" ) ? " and ad_client_type='#{session[:advreport_camp_id]}'" : ""
                  sub_query="select sum(unique_visitors) from campaigns_summaries where advertiser_id =#{session[:adv_id]} #{campaignId} #{adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and unique_visitors>0" 
                  query= "select date_format(delivery_date,'%Y/%m/%d') as delivered_date, sum(unique_visitors) as sum_visitor,(sum(unique_visitors) /(#{sub_query})*100) as visitor_percentage from campaigns_summaries where advertiser_id =#{session[:adv_id]} #{campaignId} #{adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and unique_visitors>0 #{ad_type}" 
                  query+= " group by delivery_date"
                  #following code is used to retrive visitor recordset from databse
                  @visitordata_pages, @visitordata = paginate_by_sql CampaignsSummary,query,10
              else
                flash[:notice]="Your are not an authorized user. Please login with different username."
                redirect_to :controller=>'login', :action=>'login'
              end
          end
      rescue Exception=>e
          puts "DEBUG :: ERROR :: in advertiser_analytic_controller - advertiser_continent method Exception :: #{e.to_s}"
          render :action=>'advertiser_continent'
      end
  end
  
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#Method Name: advertiser_continent	
	#Purpose: To show the adwise chart in adwise home page. It shows the particular campaign's all ads performance chart. 
	#Version: 1.0
	#Author: Sathish Kumar Sadhasivam
	#Last Modified: 20-Sep-2008 by Md Shujauddeen
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	def advertiser_continent
      begin
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                @continent=@continent={"SA"=>"South America","NA"=>"North America","AS"=>"Asia","EU"=>"Europe","AF"=>"Africa","OC"=>"Oceania","CA"=>"Central America","ME"=>"Middle East"}
                session[:page]=params[:page]==""? 0 : params[:page].to_i
                verifyDBconnection
                # ad id will ad the condition on query depends upon the selection
                adid= (session[:advreport_ad_id]=="All" ) ? "" : " and ad_id=#{session[:advreport_ad_id]} "
                campaignId= (session[:advreport_camp_id]=="SMS" || session[:advreport_camp_id]=="WAP" || session[:advreport_camp_id]==nil) ? "" : " and campaign_id=#{session[:advreport_camp_id]} "
                report_type='impressions'
                @advXML_continent_report=@@obj.generate_query(session[:advreport_camp_id],session[:advreport_ad_id],"#{session[:adv_id]}-adv_geolocations-#{session[:duration]}",'Traffic','delivery_date',report_type,session[:advreport_start_on],session[:advreport_end_on],'continent_code', 'impressions','continent_code','admin_analytic') 
                #frame query to retrive traffic source recordset from the database.
                # sub query  which is used inside the main query.
                sub_query="select sum(impressions) as sum_region from adv_geolocations where advertiser_id=#{session[:adv_id]} #{campaignId} #{adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and impressions>0"   
                # Main query
                query="select if(continent_code='CB','NA',continent_code) as continent, sum(impressions) as sum_region,((sum(impressions)/(#{sub_query}))*100) as percentage from adv_geolocations where advertiser_id=#{session[:adv_id]} #{campaignId} #{adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and impressions>0 group by continent order by sum_region desc "
                @countrydata_pages, @countrydata = paginate_by_sql CampaignsSummary,query,20
              else
                flash[:notice]="Your are not an authorized user. Please login with different username."
                redirect_to :controller=>'login', :action=>'login'
            end
        end
      rescue Exception=>e
          puts "DEBUG :: ERROR :: in advertiser_analytic_controller - advertiser_continent method Exception :: #{e.to_s}"
          render :action=>'advertiser_continent'
      end
	end
 
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#Method Name: traffic_country	
	#Purpose: To show the adwise chart in adwise home page. It shows the particular campaign's all ads performance chart. 
	#Version: 1.0
	#Author: Sathish Kumar Sadhasivam
	#Last Modified: 20-July-2009 by Sathish Kumar Sadhasivam
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  def advertiser_traffic_continent
       begin
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                   key='rh21nr8e0vav0h0v'
                   iv='1pnee1ng36nuare8'
                   session[:adv_continent_info]=params[:params] if params[:params]!=nil && params[:params]!=''
                   @continent_code=session[:adv_continent_info].split('/')[0]   #initialize continent code from params
                   @campaign_id=session[:adv_continent_info].split('/')[1]  # initialize campaign id
                  flag=session[:adv_continent_info].split('/')[3]
                  if flag==nil 
                      @campaign_id=@aes.decrypt(key,iv,"#{@campaign_id}")
                  elsif flag.to_s=='1'
                      @campaign_id=@aes.decrypt(session[:key],session[:iv],"#{@campaign_id}")  # initialize publisher id 
                  end
                   @adid=session[:adv_continent_info].split('/')[2] # initialize ad id 
                   @countryHash=returnCountryhash(@continent_code)
                   session[:page]=params[:page]==""? 0 : params[:page].to_i
                   verifyDBconnection
                   # ad id will ad the condition on query depends upon the selection
                   @adid= (session[:advreport_ad_id]=="All" ) ? "" : " and ad_id=#{session[:advreport_ad_id]} "
                   campaignId= (session[:advreport_camp_id]=="SMS" || session[:advreport_camp_id]=="WAP" || session[:advreport_camp_id]==nil) ? "" : " and campaign_id=#{session[:advreport_camp_id]} "
                   #intialize start and end date
                   @startdate=Time.parse(session[:advreport_start_on]).strftime('%Y-%m-%d')
                   @enddate=Time.parse(session[:advreport_end_on]).strftime('%Y-%m-%d')
                   continent_code=@continent_code=='NA' ? "'NA' or continent_code='CB'" : "'#{@continent_code}'"
                   @advXML_continent_traffic_report=@@obj.generate_query(session[:advreport_camp_id],session[:advreport_ad_id],"#{session[:adv_id]}-adv_geolocations-#{session[:duration]}",'Traffic_Continent','delivery_date',session[:advreport_type],session[:advreport_start_on],session[:advreport_end_on],'country_code', 'impressions','continent_code',@continent_code)
                   #frame query to retrive traffic source recordset from the database.
                   sub_query="select sum(impressions) as sum_region from adv_geolocations where (continent_code=#{continent_code}) and advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and impressions>0"   
                   # main query
                   query="select country_code as country_code , sum(impressions) as sum_region,((sum(impressions)/(#{sub_query}))*100) as percentage from adv_geolocations  where (continent_code=#{continent_code}) and  advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and impressions>0 group by country_code order by sum_region desc "
                   @countrydata_pages, @countrydata = paginate_by_sql CampaignsSummary,query,20
              else
                flash[:notice]="Your are not an authorized user. Please login with different username."
                redirect_to :controller=>'login', :action=>'login'
            end
        end
     rescue Exception=>e
        puts "DEBUGGER :: ERROR :: in advertiser_analytic_controller - advertiser_traffic_continent method Exception :: #{e.to_s}"
        render :action=>'advertiser_traffic_continent'
     end
end

  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#Method Name: advertiser_adwise	
	#Purpose: To show the adwise chart in adwise home page. It shows the particular campaign's all ads performance chart. 
	#Version: 1.0
	#Author: Sathish Kumar Sadhasivam
	#Last Modified: 20-Sep-2008 by Sathish Kumar Sadhasivam
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	def advertiser_adwise
      begin
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                   @smartLabel='1'
                  session[:page]=params[:page]==""? 0 : params[:page].to_i
                  verifyDBconnection
                  #~ @adid= (session[:advreport_ad_id]=="All" ) ? "" : " and ad_id=#{session[:advreport_ad_id]} "
                  report_type='impressions'
                  campaignId= (session[:advreport_camp_id]=="SMS" || session[:advreport_camp_id]=="WAP" || session[:advreport_camp_id]==nil) ? "" : " and campaign_id=#{session[:advreport_camp_id]} "
                  ad_type=(session[:advreport_camp_id]=="SMS" || session[:advreport_camp_id]=="WAP" ) ? " and ad_client_type='#{session[:advreport_camp_id]}'" : ""
                  @adid= (session[:advreport_ad_id]=="All" ) ? "" : " and ad_id=#{session[:advreport_ad_id]} "
                  @advXML_ad_wise_report=@@obj.generate_query(session[:advreport_camp_id],session[:advreport_ad_id],"#{session[:adv_id]}-campaigns_summaries-#{session[:duration]}-#{@smartLabel}",'Ad_Wise','a.name as ad_name',report_type,session[:advreport_start_on],session[:advreport_end_on])
                  sql ="select ad_id , sum(impressions) as impressions,sum(clicks) as sum_clicks,((sum(clicks)/sum(impressions))*100)  as sum_ctr,sum(amount_spent) as sum_amount_spent from campaigns_summaries where advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and impressions>0 #{ad_type} group by ad_id order by impressions desc"
                  @adwise_pages, @adwises = paginate_by_sql CampaignsSummary,sql,20
              else
                  flash[:notice]="Your are not an authorized user. Please login with different username."
                  redirect_to :controller=>'login', :action=>'login'
              end
          end
      rescue Exception=>e
        puts "DEBUG :: ERROR :: in advertiser_analytic_controller - advertiser_adwise method Exception :: #{e.to_s}"
        render :action=>'advertiser_adwise'
      end
  end
 
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#Method Name: advertiser_update_chart	
	#Purpose: To show campaign's performance chart in advertiser analytic home page. Performance based in impressions, clicks, etc.,
	#Version: 1.0
	#Author: Sathish Kumar Sadhasivam
	#Last Modified: 08-Oct-2008 by Sathish Kumar Sadhasivam
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	def advertiser_update_chart
      begin
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                  @report_type=params[:report_type]
                  @chart=nil
                  if session[:advreport_ad_id]!=nil and session[:advreport_ad_id]!=""
                      @advXML_summary_report=@@obj.generate_query(session[:advreport_camp_id],session[:advreport_ad_id],"#{session[:adv_id]}-campaigns_summaries-#{session[:duration]}",'Campaigns_Summary','delivery_date',@report_type,session[:advreport_start_on],session[:advreport_end_on])
                      @chart=@advXML_summary_report[:xml_string]
                  else
                  end
                  render :action=>'advertiser_update_chart',:layout=>false
              else
                  flash[:notice]="Your are not an authorized user. Please login with different username."
                  redirect_to :controller=>'login', :action=>'login'
              end
          end
      rescue Exception=>e
        puts "DEBUG :: ERROR :: in advertiser_analytic_controller - advertiser_update_chart method Exception :: #{e.to_s}"
        render :action=>'advertiser_update_chart'
      end
	end
  
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#Method Name: advertiser_update_text	
	#Purpose: To show campaign's performance text report in advertiser analytic home page. Performance based in impressions, clicks, etc.,
	#Version: 1.0
	#Author: Sathish Kumar Sadhasivam
	#Last Modified: 08-Oct-2008 by Sathish Kumar Sadhasivam
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	def advertiser_update_text
		begin
      @aes = AESSecurity.new() #creating an object for AES Security
		  if (session[:user_id]==nil)
          flash[:notice]="Your session has expired. Please login again."
          redirect_to :controller=>'login', :action=>'login'
      else
          if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                @report_type=params[:report_type]
                session[:page]=params[:page]==""? 0 : params[:page].to_i
                verifyDBconnection
                @adid= (session[:advreport_ad_id]=="All" || session[:advreport_ad_id]=="" || session[:advreport_ad_id]==nil) ? "" : " and ad_id=#{session[:advreport_ad_id]} "
                campaignId= (session[:advreport_camp_id]=="SMS" || session[:advreport_camp_id]=="WAP" || session[:advreport_camp_id]==nil) ? "" : " and campaign_id=#{session[:advreport_camp_id]} "
                ad_type=(session[:advreport_camp_id]=="SMS" || session[:advreport_camp_id]=="WAP" ) ? " and ad_client_type='#{session[:advreport_camp_id]}'" : ""
                sql="select date_format(delivery_date,'%Y/%m/%d') as delivered_date, sum(impressions) as impressions, sum(clicks) as clicks, ((sum(clicks)/sum(impressions))*100)  as ctr, sum(amount_spent) as amount_spent from campaigns_summaries where  advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' #{ad_type} group by Year(delivery_date),MONTH(delivery_date),Day(delivery_date)"
                @AdvCampaignSummaries_pages, @AdvCampaignSummaries = paginate_by_sql AdvCarrier,sql,20
                render :action=>'advertiser_update_text',:layout=>false
          else
              flash[:notice]="Your are not an authorized user. Please login with different username."
              redirect_to :controller=>'login', :action=>'login'
          end
      end
		rescue Exception=>e
			puts "DEBUG :: ERROR :: in advertiser_analytic_controller - advertiser_update_text method Exception :: #{e.to_s} -- #{sql}"
			render :action=>'advertiser_update_text'
		end
	end
  
  
  
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#Method Name: advertiser_deviceproperty	
	#Purpose: To show the device property(eg., video, audio, mp3, etc.,) chart for the particular campaign and list the other device properties with traffic on it.
	#Version: 1.0
	#Author: Sathish Kumar Sadhasivam
	#Last Modified: 20-Sep-2008 by Sathish Kumar Sadhasivam
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	def advertiser_deviceproperty
		begin
        @aes = AESSecurity.new() #creating an object for AES Security
        if (session[:user_id]==nil)
            flash[:notice]="Your session has expired. Please login again."
            redirect_to :controller=>'login', :action=>'login'
        else
            if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                @xml_string_hash=Hash.new
                @xml_array_hash=Hash.new
                @smartLabel='1'
                session[:page]=params[:page]==""? 0 : params[:page].to_i
                verifyDBconnection
                @adid= (session[:advreport_ad_id]=="All" ) ? "" : " and ad_id=#{session[:advreport_ad_id]} "
                campaignId= (session[:advreport_camp_id]=="SMS" || session[:advreport_camp_id]=="WAP" || session[:advreport_camp_id]==nil) ? "" : " and campaign_id=#{session[:advreport_camp_id]} "
                report_type=session[:advreport_type]
                @advXML_device_property_traffic_report=@@obj.generate_query(session[:advreport_camp_id],session[:advreport_ad_id],"#{session[:adv_id]}-adv_devicesproperties-#{session[:duration]}-#{@smartLabel}",'DeviceProperties_Traffic','delivery_date',session[:advreport_start_on],session[:advreport_start_on],session[:advreport_end_on])
                sql = " select properties as property_name, sum(requests) as property_count,((sum(requests)/( select sum(requests) as counter from adv_devicesproperties where advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and requests>0))*100) as percentage from adv_devicesproperties where advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and requests>0 group by property_name order by property_count desc"
                @deviceproperty_pages, @deviceproperty = paginate_by_sql AdvDevicesproperty,sql,20
            else
                flash[:notice]="Your are not an authorized user. Please login with different username."
                redirect_to :controller=>'login', :action=>'login'
            end
        end
		rescue Exception=>e
			puts "DEBUG :: ERROR :: in advertiser_analytic_controller - advertiser_deviceproperty method Exception :: #{e.to_s}"
			render :action=>'advertiser_deviceproperty'
		end
	end
	
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#Method Name: advertiser_hour_traffic
	#Purpose: To show the hourly traffic on particular campaign and find the peak hour for the campaign and list the particular hour traffic.
	#Version: 1.0
	#Author: Sathish Kumar Sadhasivam
	#Last Modified: 20-Sep-2008 by Sathish Kumar Sadhasivam
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	def advertiser_hourtraffic
		begin
        @aes = AESSecurity.new() #creating an object for AES Security
        if (session[:user_id]==nil)
            flash[:notice]="Your session has expired. Please login again."
            redirect_to :controller=>'login', :action=>'login'
        else
            if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                session[:page]=params[:page]==""? 0 : params[:page].to_i
                verifyDBconnection
                @adid= (session[:advreport_ad_id]=="All" ) ? "" : " and ad_id=#{session[:advreport_ad_id]} "
                campaignId= (session[:advreport_camp_id]=="SMS" || session[:advreport_camp_id]=="WAP" || session[:advreport_camp_id]==nil) ? "" : " and campaign_id=#{session[:advreport_camp_id]} "
                ad_type=(session[:advreport_camp_id]=="SMS" || session[:advreport_camp_id]=="WAP" ) ? " and ad_client_type='#{session[:advreport_camp_id]}'" : ""
                report_type=session[:advreport_type]
                @advXML_hour_traffic_report=@@obj.generate_query(session[:advreport_camp_id],session[:advreport_ad_id],"#{session[:adv_id]}-campaigns_summaries-#{session[:duration]}",'hourly_report','delivery_hour','impressions',session[:advreport_start_on],session[:advreport_end_on]) 			
                sql="select delivery_hour , sum(impressions) as impressions, ((sum(impressions)/(select sum(impressions) as impressions from campaigns_summaries where advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and impressions>0))*100) as percentage from campaigns_summaries where advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and impressions>0 #{ad_type} group by delivery_hour"
                @hourtraffic_pages, @hour_traffic = paginate_by_sql CampaignsSummary,sql,24
                #assaign xml array to an hash and put it in a session variable			
            else
                flash[:notice]="Your are not an authorized user. Please login with different username."
                redirect_to :controller=>'login', :action=>'login'
            end
        end
		rescue Exception=>e
			puts "DEBUG :: ERROR :: in advertiser_analytic_controller - advertiser_hour_traffic method Exception :: #{e.to_s}"
			render :action=>'advertiser_hourtraffic'
		end
	end
	
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#Method Name: advertiser_carrier
	#Purpose: To show the top 5 carrier traffic on particular campaign  and list the other carriers with traffic on it.  eg. airtel, bsnl, idea, etc., 
	#Version: 1.0
	#Author: Sathish Kumar Sadhasivam
	#Last Modified: 20-Sep-2008 by Sathish Kumar Sadhasivam
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  def advertiser_carrier
		begin
        @aes = AESSecurity.new() #creating an object for AES Security
        if (session[:user_id]==nil)
            flash[:notice]="Your session has expired. Please login again."
            redirect_to :controller=>'login', :action=>'login'
        else
            if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                @smartLabel='1'
                @encodeUrl={'&'=>'~'}
                session[:page]=params[:page]==""? 0 : params[:page].to_i
                @adid= (session[:advreport_ad_id]=="All" ) ? "" : " and ad_id=#{session[:advreport_ad_id]} "
                campaignId= (session[:advreport_camp_id]=="SMS" || session[:advreport_camp_id]=="WAP" || session[:advreport_camp_id]==nil) ? "" : " and campaign_id=#{session[:advreport_camp_id]} "
                report_type=session[:advreport_type]
                verifyDBconnection
                @advXML_carrier_report=@@obj.generate_query(session[:advreport_camp_id],session[:advreport_ad_id],"#{session[:adv_id]}-adv_carriers-#{session[:duration]}-#{@smartLabel}",'Carrier_Traffic','delivery_date',report_type,session[:advreport_start_on],session[:advreport_end_on],'operator', 'requests','','admin_analytic')
                sql="select carriers as operator , sum(requests) as requests,(sum(requests)/(select sum(requests) from adv_carriers where advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid}  and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and requests>0)*100) as percentage from adv_carriers where advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and requests>0 group by operator order by requests desc"                
                @carriers_pages, @carriers = paginate_by_sql AdvCarrier,sql,20      
            else
                flash[:notice]="Your are not an authorized user. Please login with different username."
                redirect_to :controller=>'login', :action=>'login'
            end
        end
		rescue Exception=>e
			puts "DEBUG :: ERROR :: in admin_analytic_controller - advertiser_carrier method Exception :: #{e.to_s}"
			render :action=>'advertiser_carrier'
		end
	end
	
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#Method Name: advertiser_handset
	#Purpose: To show the top 5 handsets traffic on particular campaigns performance and list the other handsets with traffic on it.
	#Version: 1.0
	#Author: Sathish Kumar Sadhasivam
	#Last Modified: 20-Sep-2008 by Sathish Kumar Sadhasivam
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	def advertiser_handset
		begin
        @aes = AESSecurity.new() #creating an object for AES Security
        if (session[:user_id]==nil)
            flash[:notice]="Your session has expired. Please login again."
            redirect_to :controller=>'login', :action=>'login'
        else
            if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                @smartLabel='1'
                session[:page]=params[:page]==""? 0 : params[:page].to_i
                verifyDBconnection
                @adid= (session[:advreport_ad_id]=="All" ) ? "" : " and ad_id=#{session[:advreport_ad_id]} "
                campaignId= (session[:advreport_camp_id]=="SMS" || session[:advreport_camp_id]=="WAP" || session[:advreport_camp_id]==nil) ? "" : " and campaign_id=#{session[:advreport_camp_id]} "
                report_type=session[:advreport_type]
                @advXML_handset_report=@@obj.generate_query(session[:advreport_camp_id],session[:advreport_ad_id],"#{session[:adv_id]}-adv_handsets-#{session[:duration]}-#{@smartLabel}",'Device_Summary','delivery_date',session[:advreport_type],session[:advreport_start_on],session[:advreport_end_on],'handset','impressions','','admin_analytic')
                #Original query to check
                sql="	select delivery_date ,handset ,sum(impressions) as requests, ((sum(impressions))/(select sum(impressions) as total_c from adv_handsets where advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and impressions>0))*100 as percentage from adv_handsets where advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and impressions>0 group by handset order by requests desc"
                @handsets_pages, @handsets = paginate_by_sql CampaignsSummary,sql,20
            else
                flash[:notice]="Your are not an authorized user. Please login with different username."
                redirect_to :controller=>'login', :action=>'login'
            end
        end
		rescue Exception=>e
			puts "DEBUG :: ERROR :: in advertiser_analytic_controller - advertiser_handset method Exception :: #{e.to_s}"
			render :action=>'advertiser_handset'
		end
	end
    #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#Method Name: traffic_country	
	#Purpose: To show the adwise chart in adwise home page. It shows the particular campaign's all ads performance chart. 
	#Version: 1.0
	#Author: Sathish Kumar Sadhasivam
	#Last Modified: 20-Sep-2008 by Sathish Kumar Sadhasivam
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  def advertiser_owner
       begin
           @aes = AESSecurity.new() #creating an object for AES Security
            if (session[:user_id]==nil)
                flash[:notice]="Your session has expired. Please login again."
                redirect_to :controller=>'login', :action=>'login'
            else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                    key='rh21nr8e0vav0h0v'
                    iv='1pnee1ng36nuare8'
                    @smartLabel='1'
                    session[:adm_operator]=params[:operator] if params[:operator]!=nil && params[:operator]!=''
                    @operator=session[:adm_operator].split('/')[0]   #initialize continent code from params
                    @campaign_id=session[:adm_operator].split('/')[1]  # initialize campaign id
                    @campaign_id=@aes.decrypt(key,iv,"#{@campaign_id}")
                    @adid=session[:adm_operator].split('/')[2] # initialize ad id 
                    @operator=@operator.gsub(/[~]/,'&')
                    session[:page]=params[:page]==""? 0 : params[:page].to_i
                    verifyDBconnection
                    #intialize start and end date
                    @startdate=Time.parse(session[:advreport_start_on]).strftime('%Y-%m-%d')
                    @enddate=Time.parse(session[:advreport_end_on]).strftime('%Y-%m-%d')
                    #call generate query method to construct traffic source- country wise query and to generate traffic source map.
                    #frame query to retrive traffic source recordset from the database.
                    @adid= (session[:advreport_ad_id]=="All" ) ? "" : " and ad_id=#{session[:advreport_ad_id]} "
                    campaignId= (session[:advreport_camp_id]=="SMS" || session[:advreport_camp_id]=="WAP" || session[:advreport_camp_id]==nil) ? "" : " and campaign_id=#{session[:advreport_camp_id]} "
                    @advXML_owner_report=@@obj.generate_query(session[:advreport_camp_id],session[:advreport_ad_id],"#{session[:adv_id]}-adv_carriers-#{session[:duration]}-#{@smartLabel}",'Owner_Traffic','delivery_date',session[:advreport_type],session[:advreport_start_on],session[:advreport_end_on],'carrier', 'requests',@operator)
                    #~ sql="select delivery_date , owner , sum(requests) as requests, ((((sum(requests))/(select sum(requests) from adv_carriers where campaign_id=#{session[:advreport_camp_id]} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and owner!='ip' and owner!='')))*100) as percentage from adv_carriers where  campaign_id=#{session[:advreport_camp_id]} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and owner!='ip' and owner!='' group by owner order by requests desc"
                    sql="select carr.owner as carrier,sum(carr.requests) as requests,(sum(carr.requests)/(select sum(carr.requests) from adv_carriers carr, owners own where advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and carr.owner=own.carrier and own.operator='#{@operator}' and requests>0)*100) as percentage  from adv_carriers carr,owners own where advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00'  and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and carr.owner=own.carrier and own.operator='#{@operator}' and requests>0 group by carrier order by requests desc"
                    @owner_pages, @owner = paginate_by_sql AdvCarrier,sql,20
              else
                  flash[:notice]="Your are not an authorized user. Please login with different username."
                  redirect_to :controller=>'login', :action=>'login'
              end
        end
       rescue Exception=>e
          puts "DEBUGGER :: ERROR :: in advertiser_analytic_controller - advertiser_owner method Exception :: #{e.to_s}"
          render :action=>'advertiser_owner'
       end
    end
    
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#Method Name: advertiser_handset
	#Purpose: To show the top 5 handsets traffic on particular campaigns performance and list the other handsets with traffic on it.
	#Version: 1.0
	#Author: Md Shujauddeen
	#Last Modified: 20-Sep-2008 by Md Shujauddeen
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	def advertiser_handset_model
		begin
         @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                  @smartLabel='1'
                  session[:page]=params[:page]==""? 0 : params[:page].to_i
                  verifyDBconnection
                  session[:handset]=params[:handset] if params[:handset]!=nil && params[:handset]!=''
                  @handset=session[:handset] #initialize handset code from params
                  @handset=@handset.gsub(/[~]/,'&')
                  @adid= (session[:advreport_ad_id]=="All" ) ? "" : " and ad_id=#{session[:advreport_ad_id]} "
                  campaignId= (session[:advreport_camp_id]=="SMS" || session[:advreport_camp_id]=="WAP" || session[:advreport_camp_id]==nil) ? "" : " and campaign_id=#{session[:advreport_camp_id]} "
                  report_type=session[:advreport_type]
                  @advXML_handset_report=@@obj.generate_query(session[:advreport_camp_id],session[:advreport_ad_id],"#{session[:adv_id]}-adv_handsets-#{session[:duration]}-#{@smartLabel}",'Model_Summary','delivery_date',session[:advreport_type],session[:advreport_start_on],session[:advreport_end_on],'handset_model','impressions',@handset)
                  #Original query to check
                  sql="	select handset_model,sum(impressions) as requests, ((sum(impressions))/(select sum(impressions) as total_c from adv_handsets where advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and handset='#{@handset}' and impressions>0))*100 as percentage from adv_handsets where  advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and handset='#{@handset}' and impressions>0 group by handset_model order by requests desc"
                  @handsets_pages, @handsets = paginate_by_sql CampaignsSummary,sql,10
             else
                flash[:notice]="Your are not an authorized user. Please login with different username."
                redirect_to :controller=>'login', :action=>'login'
            end
        end
		rescue Exception=>e
			puts "DEBUG :: ERROR :: in admin_analytic_controller - advertiser_handset method Exception :: #{e.to_s}"
			render :action=>'advertiser_handset_model'
		end
	end
  
  #****************************************************************************************************************************************************
  #*                                                                          PUBLISHER CODE BEGINS HERE
  #***************************************************************************************************************************************************
  
   #--------------------------------------------------------------------------------------------
  #Method Name: publisher_home
  #Purpose: this method is used to display publisher homepage with all the charts
  #Version: 1.0
  #Author:Md Shujauddeen A
  #Last Modified: 30-Oct-2008 by Md Shujauddeen
  #Notes: None.
#-------------------------------------------------------------------------------------------- 
      def publisher_home
        begin
            @aes = AESSecurity.new() #creating an object for AES Security
            if (session[:user_id]==nil)
                flash[:notice]="Your session has expired. Please login again."
                redirect_to :controller=>'login', :action=>'login'
            else
                if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                        #initialize start and end date
                        @enddate=(session[:adminend_on]==nil || session[:adminend_on]=="") ? (Time.now-86400).strftime("%d-%b-%Y") : session[:adminend_on]
                        @startdate= (session[:adminstart_on]==nil || session[:adminstart_on]=="") ? (Time.now-86400).strftime("%d-%b-%Y") : session[:adminstart_on]
                        analytic=params[:analytic]
                        verifyDBconnection
                        session[:pub_id]=@aes.decrypt(session[:key],session[:iv],params[:pub_id]) if params[:pub_id]!=nil and params[:pub_id]!=""
                        disp_user_id=Publisher.find_by_id(session[:pub_id].to_i).user_id
                        session[:disp_username]=User.find_by_id(disp_user_id).username
                        #retrieve the adclient list from the database
                        @adclient_list=Adclient.find_by_sql("select id, app_name from adclients where publisher_id=#{session[:pub_id]}")
                        if analytic=="refresh"
                              redirect_to :action=>'generate_report',:adclient_dropdown=>@aes.encrypt(session[:key],session[:iv],'WAP'),:pub_start_on=>@startdate,:pub_end_on=>@enddate,:duration=>"#{session[:duration]}",:filled=>'filled'
                        end
                        @adclient_summary= @@pub_obj.performance_summary(session[:pub_id],session[:report_adclient]!=nil ? session[:report_adclient] : 'WAP' ,session[:report_start_on]!=nil ? session[:report_start_on] : @startdate ,session[:report_end_on]!=nil ? session[:report_end_on] : @enddate,session[:filled])
                        @summry_report = session[:xml_string] #retrieves the hash from the session
                else
                    flash[:notice]="Your are not an authorized user. Please login with different username."
                    redirect_to :controller=>'login', :action=>'login'
                end
            end
        rescue Exception=>e
                puts "DEBUG :: ERROR :: in Admin analytic controller :: publisher_home method :: #{e.to_s}"
       end
     end
   #--------------------------------------------------------------------------------------------
  #Method Name: publisher_handset
  #Purpose:this method to construct publisher handset chart
  #Version: 1.0
  #Author:Md Shujauddeen A
  #Last Modified: 30-Oct-2008 by Md Shujauddeen
  #Notes: None.
 #-------------------------------------------------------------------------------------------- 
      def publisher_handset
          begin
              @aes = AESSecurity.new() #creating an object for AES Security
              if (session[:user_id]==nil)
                  flash[:notice]="Your session has expired. Please login again."
                  redirect_to :controller=>'login', :action=>'login'
              else
                  if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                     # @handset_report = session[:xml_string]
                      @smartLable='1' #1 represent smartLable as Enabled
                      @XML_handset_report=@@pub_obj.generate_query("#{session[:pub_id]}-#{session[:filled]}",'pub_handsets','Pie_chart','handset','impressions',session[:report_adclient],session[:report_start_on],session[:report_end_on],@smartLable,'admin_analytic','')
                      #initialize start and end date
                      @startdate=Time.parse(session[:report_start_on]).strftime('%Y-%m-%d')
                      @enddate=Time.parse(session[:report_end_on]).strftime('%Y-%m-%d')
                      verifyDBconnection
                      adclient_type=(session[:report_adclient]!='SMS' and session[:report_adclient]!='WAP')? " and client_id=#{session[:report_adclient]}" : ""
                      #frame query to get the devices summary report.
                      filter_column=session[:filled]=='filled' ? "and impressions>0" : session[:filled]=='unfilled' ? "and fill_rate>0" : "and (impressions>0 or fill_rate>0)"
                      sub_query="select #{session[:filled]=='filled' ? "sum(impressions)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(impressions)+sum(fill_rate))"} from pub_handsets where pub_id =#{session[:pub_id]} and delivery_date>='#{(Time.parse(@startdate)).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(@enddate)).strftime("%Y-%m-%d")} 23:59:59' #{filter_column}" 
                      sub_query+=" #{adclient_type}"
                      query= "select handset as vendor, #{session[:filled]=='filled' ? "sum(impressions)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(impressions)+sum(fill_rate))"} as sum_requests,(#{session[:filled]=='filled' ? "sum(impressions)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(impressions)+sum(fill_rate))"}/(#{sub_query})*100) as handset_percentage from pub_handsets where pub_id =#{session[:pub_id]} and delivery_date>='#{@startdate} 00:00:00' and delivery_date<='#{@enddate} 23:59:59' #{filter_column}" 
                      query+=" #{adclient_type}"
                      query+= " group by vendor order by sum_requests desc"
                      #following code is used to retrive recordset from database.
                      @handsetdata_pages, @handsetdata = paginate_by_sql AdclientsSummary,query,20
                      render :action =>'publisher_handset' 
                  else
                      flash[:notice]="Your are not an authorized user. Please login with different username."
                      redirect_to :controller=>'login', :action=>'login'
                  end
              end
          rescue Exception=>e
              puts "DEBUG :: ERROR :: in Admin analytic controller :: publisher_handset method :: #{e.to_s}"
          end
        end
      #--------------------------------------------------------------------------------------------
      #Method Name: publisher_channel
      #Purpose: this method is used to construct publisher channel chart
      #Version: 1.0
      #Author:Md Shujauddeen A
      #Last Modified: 30-Oct-2008 by Md Shujauddeen
      #Notes: None.
     #-------------------------------------------------------------------------------------------- 
      def publisher_channel
             begin
                  @aes = AESSecurity.new() #creating an object for AES Security
                  if (session[:user_id]==nil)
                      flash[:notice]="Your session has expired. Please login again."
                      redirect_to :controller=>'login', :action=>'login'
                  else
                      if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                          @smartLable='1' #1 represent smartLable as Enabled
                          @XML_channel_report=@@pub_obj.generate_query("#{session[:pub_id]}-#{session[:filled]}",'pub_channels','Pie_chart','channel','requests',session[:report_adclient],session[:report_start_on], session[:report_end_on],@smartLable,'admin_analytic','')
                          adclient_type=(session[:report_adclient]!='SMS' and session[:report_adclient]!='WAP')? " and client_id=#{session[:report_adclient]}" : " and (ad_client_type='#{session[:report_adclient].upcase}' or ad_client_type='#{session[:report_adclient].downcase}')"
                          #initialize start and end date.
                          @startdate=Time.parse(session[:report_start_on]).strftime('%Y-%m-%d')
                          @enddate=Time.parse(session[:report_end_on]).strftime('%Y-%m-%d')
                          verifyDBconnection
                          #frame query to retrive demographic data from database
                          filter_column=session[:filled]=='filled' ? "and requests>0" : session[:filled]=='unfilled' ? "and fill_rate>0" : "and (requests>0 or fill_rate>0)"
                          sub_query="select #{session[:filled]=='filled' ? "sum(requests)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(requests)+sum(fill_rate))"} from pub_channels where pub_id =#{session[:pub_id]} and delivery_date>='#{(Time.parse(@startdate)).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(@enddate)).strftime("%Y-%m-%d")} 23:59:59' #{filter_column}" 
                          sub_query+=" #{adclient_type}"
                          query= "select channel, #{session[:filled]=='filled' ? "sum(requests)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(requests)+sum(fill_rate))"} as sum_requests,(#{session[:filled]=='filled' ? "sum(requests)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(requests)+sum(fill_rate))"}/(#{sub_query})*100) as channel_percentage from pub_channels where pub_id =#{session[:pub_id]} and delivery_date>='#{@startdate} 00:00:00' and delivery_date<='#{@enddate} 23:59:59' #{filter_column}" 
                          query+=" #{adclient_type}"
                          query+= " group by channel order by sum_requests desc"
                          #following code is used to retrive recordset from database
                          @channeldata_pages, @channeldata = paginate_by_sql PubChannel,query,20
                      else
                          flash[:notice]="Your are not an authorized user. Please login with different username."
                          redirect_to :controller=>'login', :action=>'login'
                      end
                  end
            rescue Exception=>e
                  puts "DEBUG :: ERROR :: in Admin analytic controller :: publisher_channel method :: #{e.to_s}"
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
                    if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                        @smartLable='1' #1 represent smartLable as Enabled
                        @XML_carrier_report=@@pub_obj.generate_query("#{session[:pub_id]}-#{session[:filled]}",'pub_carriers','Pie_chart','operator','requests',session[:report_adclient],session[:report_start_on], session[:report_end_on],@smartLable,'admin_analytic','')
                        #initialze start and end date
                        @startdate=Time.parse(session[:report_start_on]).strftime('%Y-%m-%d')
                        @enddate=Time.parse(session[:report_end_on]).strftime('%Y-%m-%d')
                        verifyDBconnection
                        filter_column=session[:filled]=='filled' ? "and requests>0" : session[:filled]=='unfilled' ? "and fill_rate>0" : "and (requests>0 or fill_rate>0)"
                        adclient_type=(session[:report_adclient]!='SMS' and session[:report_adclient]!='WAP')? " and client_id=#{session[:report_adclient]}" : " and (ad_client_type='#{session[:report_adclient].upcase}' or ad_client_type='#{session[:report_adclient].downcase}')"
                        #frame query to retrive keyword data from database
                        sql="select carriers as operator ,#{session[:filled]=='filled' ? "sum(requests)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(requests)+sum(fill_rate))"} as sum_carrier,(#{session[:filled]=='filled' ? "sum(requests)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(requests)+sum(fill_rate))"}/(select #{session[:filled]=='filled' ? "sum(requests)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(requests)+sum(fill_rate))"} from pub_carriers carr where pub_id=#{session[:pub_id]} #{adclient_type} and delivery_date>='#{@startdate} 00:00:00' #{filter_column} and delivery_date<='#{@enddate} 23:59:59')*100) as carr_percentage from pub_carriers where pub_id=#{session[:pub_id]} and delivery_date>='#{@startdate} 00:00:00' and delivery_date<='#{@enddate} 23:59:59' #{filter_column} #{adclient_type} group by operator order by sum_carrier desc"                
                        @carriers_pages, @carriers = paginate_by_sql AdvCarrier,sql,20      
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
        #Last Modified:30-Oct-2008 by Md Shujauddeen
        #Notes: None.
       #-------------------------------------------------------------------------------------------- 
        def publisher_visitor
          begin
                @aes = AESSecurity.new() #creating an object for AES Security
                if (session[:user_id]==nil)
                    flash[:notice]="Your session has expired. Please login again."
                    redirect_to :controller=>'login', :action=>'login'
                else
                    if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                        #initialize start and end daste
                        @startdate=Time.parse(session[:report_start_on]).strftime('%Y-%m-%d')
                        @enddate=Time.parse(session[:report_end_on]).strftime('%Y-%m-%d')
                        verifyDBconnection
                        @xml_unique_visitors=@@pub_obj.generate_query("#{session[:pub_id]}-#{session[:filled]}",'adclients_summaries','Visitors','delivery_date','requests_unique_visitors',session[:report_adclient],session[:report_start_on], session[:report_end_on],session[:duration],'admin_analytic','')
                        adclient_type=(session[:report_adclient]!='SMS' and session[:report_adclient]!='WAP')? " and client_id=#{session[:report_adclient]}" : " and (ad_client_type='#{session[:report_adclient].upcase}' or ad_client_type='#{session[:report_adclient].downcase}')"
                        #frame query to retrive unique visitor recordset from database
                        filter_column=session[:filled]=='filled' ? "and impressions>0" : session[:filled]=='unfilled' ? "and fill_rate>0" : "and (impressions>0 or fill_rate>0)"
                        sub_query="select  #{session[:filled]=='filled' ? "sum(requests_unique_visitors)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(requests_unique_visitors)+sum(fill_rate))"} from adclients_summaries where pub_id =#{session[:pub_id]} and delivery_date>='#{(Time.parse(@startdate)).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(@enddate)).strftime("%Y-%m-%d")} 23:59:59' #{filter_column}" 
                        sub_query+=" #{adclient_type}"
                        query= "select date_format(delivery_date,'%Y/%m/%d') as delivered_date, #{session[:filled]=='filled' ? "sum(requests_unique_visitors)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(requests_unique_visitors)+sum(fill_rate))"} as sum_visitor,(#{session[:filled]=='filled' ? "sum(requests_unique_visitors)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(requests_unique_visitors)+sum(fill_rate))"}/(#{sub_query})*100) as visitor_percentage from adclients_summaries where pub_id =#{session[:pub_id]} and delivery_date>='#{@startdate} 00:00:00' and Delivery_Date<='#{@enddate} 23:59:59' #{filter_column}" 
                        query+= " #{adclient_type}"
                        query+= " group by delivery_date"
                        #following code is used to retrive visitor recordset from databse
                        @visitordata_pages, @visitordata = paginate_by_sql AdclientsSummary,query,20
                    else
                        flash[:notice]="Your are not an authorized user. Please login with different username."
                        redirect_to :controller=>'login', :action=>'login'
                    end
                end
          rescue Exception=>e
              puts "DEBUG :: ERROR :: in Admin analytic controller :: publisher_visitor method :: #{e.to_s}"
            end
          
        end
      #--------------------------------------------------------------------------------------------
      #Method Name: publisher_url
      #Purpose: this method is used to construct publisher url chart
      #Version: 1.0
      #Author:Md Shujauddeen A
      #Last Modified: 30-Oct-2008 by Md Shujauddeen
      #Notes: None.
     #-------------------------------------------------------------------------------------------- 
    def publisher_url
         begin
            @aes = AESSecurity.new() #creating an object for AES Security
            if (session[:user_id]==nil)
                flash[:notice]="Your session has expired. Please login again."
                redirect_to :controller=>'login', :action=>'login'
            else
                if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                    #initialize start and end date.
                    @startdate=Time.parse(session[:report_start_on]).strftime('%Y-%m-%d')
                    @enddate=Time.parse(session[:report_end_on]).strftime('%Y-%m-%d')
                    verifyDBconnection
                    #frame query to retrive publisher url recordset from the database.
                    filter_column=session[:filled]=='filled' ? "and requests>0" : session[:filled]=='unfilled' ? "and fill_rate>0" : "and (requests>0 or fill_rate>0)"
                    adclient_type=(session[:report_adclient]!='SMS' and session[:report_adclient]!='WAP')? " and client_id=#{session[:report_adclient]}" : ""
                    sub_query="select #{session[:filled]=='filled' ? "sum(requests)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(requests)+sum(fill_rate))"} from pub_urls where pub_id =#{session[:pub_id]} and delivery_date>='#{(Time.parse(@startdate)).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(@enddate)).strftime("%Y-%m-%d")} 23:59:59' #{filter_column}" 
                    sub_query+=" #{adclient_type}"
                    query= "select url, #{session[:filled]=='filled' ? "sum(requests)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(requests)+sum(fill_rate))"} as sum_url,(#{session[:filled]=='filled' ? "sum(requests)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(requests)+sum(fill_rate))"}/(#{sub_query})*100) as url_percentage from pub_urls where pub_id =#{session[:pub_id]} and delivery_date>='#{@startdate} 00:00:00' and delivery_date<='#{@enddate} 23:59:59' #{filter_column}" 
                    query+= " #{adclient_type}"
                    query+= " group by url order by sum_url desc"
                    #following code is used to retrive url data from the database.
                   @urldata_pages, @urldata = paginate_by_sql PubUrl,query,20
                else
                    flash[:notice]="Your are not an authorized user. Please login with different username."
                    redirect_to :controller=>'login', :action=>'login'
                end
            end
        rescue Exception=>e
              puts "DEBUG :: ERROR :: in Admin analytic controller :: publisher_url method :: #{e.to_s}"
        end
      end
    #--------------------------------------------------------------------------------------------
      #Method Name: publisher_hourly_traffic
      #Purpose: this method is used to construct publisher hourly traffic chart
      #Version: 1.0
      #Author:Md Shujauddeen A
      #Last Modified: 30-Oct-2008 by Md Shujauddeen
      #Notes: None.
     #-------------------------------------------------------------------------------------------- 
    def publisher_hourly_traffic
        begin
              @aes = AESSecurity.new() #creating an object for AES Security
              if (session[:user_id]==nil)
                  flash[:notice]="Your session has expired. Please login again."
                  redirect_to :controller=>'login', :action=>'login'
              else
                  if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                      #initialize start and end date.
                      @startdate=Time.parse(session[:report_start_on]).strftime('%Y-%m-%d')
                      @enddate=Time.parse(session[:report_end_on]).strftime('%Y-%m-%d')
                      verifyDBconnection
                      @xml_hourly_report=@@pub_obj.generate_query("#{session[:pub_id]}-#{session[:filled]}",'adclients_summaries','hourly_report','delivery_hour','impressions',session[:report_adclient],session[:report_start_on],session[:report_end_on],'','admin_analytic','')
                      adclient_type=(session[:report_adclient]!='SMS' and session[:report_adclient]!='WAP')? " and client_id=#{session[:report_adclient]}" : " and (ad_client_type='#{session[:report_adclient].upcase}' or ad_client_type='#{session[:report_adclient].downcase}')"
                      #frame sql query to retrive hourly traffic data from database.
                      filter_column=session[:filled]=='filled' ? "and impressions>0" : session[:filled]=='unfilled' ? "and fill_rate>0" : "and (impressions>0 or fill_rate>0)"
                      sub_query="select #{session[:filled]=='filled' ? "sum(impressions)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(impressions)+sum(fill_rate))"} from adclients_summaries where pub_id =#{session[:pub_id]} and delivery_date>='#{(Time.parse(@startdate)).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(@enddate)).strftime("%Y-%m-%d")} 23:59:59' #{filter_column}" 
                      sub_query+=" #{adclient_type}"
                      query= "select delivery_hour, #{session[:filled]=='filled' ? "sum(impressions)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(impressions)+sum(fill_rate))"} as sum_impressions,(#{session[:filled]=='filled' ? "sum(impressions)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(impressions)+sum(fill_rate))"}/(#{sub_query})*100) as hourly_percentage from adclients_summaries where pub_id =#{session[:pub_id]} and delivery_date>='#{@startdate} 00:00:00' and delivery_date<='#{@enddate} 23:59:59' #{filter_column}" 
                      query+= "#{adclient_type}"
                      query+= " group by delivery_hour"
                      #following code is use to get the hourly traffic recordset from the database
                      @hourlydata_pages, @hourlydata = paginate_by_sql AdclientsSummary,query,24
                  else
                      flash[:notice]="Your are not an authorized user. Please login with different username."
                      redirect_to :controller=>'login', :action=>'login'
                  end
              end
        rescue Exception=>e
              puts "DEBUG :: ERROR :: in Admin analytic controller :: publisher_hourly_traffic method :: #{e.to_s}"
        end
         
       end
     #--------------------------------------------------------------------------------------------
      #Method Name: publisher_traffic
      #Purpose: this method is used to construct publisher traffic (continent wise) map
      #Version: 1.0
      #Author:Md Shujauddeen A
      #Last Modified: 30-Oct-2008 by Md Shujauddeen
      #Notes: None.
     #-------------------------------------------------------------------------------------------- 
   def publisher_traffic
       begin
            @aes = AESSecurity.new() #creating an object for AES Security
            if (session[:user_id]==nil)
                flash[:notice]="Your session has expired. Please login again."
                redirect_to :controller=>'login', :action=>'login'
            else
                if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                    #define and initialize an hash to get Contient name based on contient code.
                    @continent={"SA"=>"South America","NA"=>"North America","AS"=>"Asia","EU"=>"Europe","AF"=>"Africa","OC"=>"Oceania","CA"=>"Central America","ME"=>"Middle East"}
                    #initialize start and end date
                    @startdate=Time.parse(session[:report_start_on]).strftime('%Y-%m-%d')
                    @enddate=Time.parse(session[:report_end_on]).strftime('%Y-%m-%d')
                    verifyDBconnection
                    @xml_traffic=@@pub_obj.generate_query("#{session[:pub_id]}-#{session[:filled]}",'pub_geolocations','Traffic','continent_code','impressions',session[:report_adclient],session[:report_start_on], session[:report_end_on],'','admin_analytic','')
                    adclient_type=(session[:report_adclient]!='SMS' and session[:report_adclient]!='WAP')? " and client_id=#{session[:report_adclient]}" : " and (ad_client_type='#{session[:report_adclient].upcase}' or ad_client_type='#{session[:report_adclient].downcase}')"
                    #frame query to get hourly traffic recordset from database.
                    #sub_query="select  sum(impressions) from adclients_summaries where pub_id =#{session[:pub_id]} and delivery_date>='#{(Time.parse(@startdate)).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(@enddate)).strftime("%Y-%m-%d")} 23:59:59'" 
                    #sub_query+="#{adclient_type}"
                    query= "select if(continent_code='CB','NA',continent_code) as continent,(sum(fill_rate)+sum(impressions)) as traffic_acquired,sum(impressions) as sum_region,sum(fill_rate) as unfilled,sum(clicks) as sum_clicks,((sum(clicks)/sum(impressions))*100) as sum_ctr,sum(revenue) as sum_revenue,((sum(revenue)/sum(impressions))*1000) as sum_ecpm,(sum(impressions)/(sum(fill_rate)+sum(impressions)))*100 as fr_percentage from pub_geolocations where pub_id =#{session[:pub_id]} and delivery_date>='#{@startdate} 00:00:00' and delivery_date<='#{@enddate} 23:59:59' and (impressions>0 or fill_rate>0 or clicks>0)" 
                    query+="#{adclient_type}"
                    query+= " group by continent order by #{session[:filled]=='filled' ? "sum_region" : session[:filled]=='unfilled' ? "unfilled" : "traffic_acquired"} desc"
                    #following code is used to retrive recordset from database
                    @trafficdata_pages, @trafficdata = paginate_by_sql AdclientsSummary,query,20
                else
                    flash[:notice]="Your are not an authorized user. Please login with different username."
                    redirect_to :controller=>'login', :action=>'login'
                end
            end
       rescue Exception=>e
         puts "DEBUG :: ERROR :: in Admin analytic controller :: publisher_traffic method :: #{e.to_s}"
   end
     
   end
     #--------------------------------------------------------------------------------------------
      #Method Name: traffic_country
      #Purpose: this method is used to construct traffic source country wise continent map
      #Version: 1.0
      #Author:Md Shujauddeen A
      #Last Modified: 30-Oct-2008 by Md Shujauddeen
      #Notes: None.
     #-------------------------------------------------------------------------------------------- 
    def traffic_country
       begin
            @aes = AESSecurity.new() #creating an object for AES Security
            if (session[:user_id]==nil)
                flash[:notice]="Your session has expired. Please login again."
                redirect_to :controller=>'login', :action=>'login'
            else
                if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                    key='aditztd04azd4ezt'
                    iv='t0sez4e0sntgtt0s'
                    session[:continent_info]=params[:id] if params[:id]!=nil && params[:id]!=''
                    @continent_code=session[:continent_info].split('/')[0]   #initialize continent code from params
                    flag=session[:continent_info].split('/')[3]
                    if flag==nil 
                        pub_id=@aes.decrypt(key,iv,"#{session[:continent_info].split('/')[1]}")   # initialize publisher id
                    elsif flag.to_s=='1'
                        pub_id=@aes.decrypt(session[:key],session[:iv],"#{session[:continent_info].split('/')[1]}")  # initialize publisher id 
                    end
                     adclientid=session[:continent_info].split('/')[2] # initialize adclient id 
                     @countryHash=returnCountryhash(@continent_code)
                     #intialize start and end daste
                     @startdate=Time.parse(session[:report_start_on]).strftime('%Y-%m-%d')
                     @enddate=Time.parse(session[:report_end_on]).strftime('%Y-%m-%d')
                     continent_code=@continent_code=='NA' ? "'NA' or continent_code='CB'" : "'#{@continent_code}'"
                     verifyDBconnection
                     adclient_type=(session[:report_adclient]!='SMS' and session[:report_adclient]!='WAP')? " and client_id=#{session[:report_adclient]}" : " and (ad_client_type='#{session[:report_adclient].upcase}' or ad_client_type='#{session[:report_adclient].downcase}')"
                     #call generate query method to construct traffic source- country wise query and to generate traffic source map.
                     @XML_traffic_continent=@@pub_obj.generate_query("#{pub_id}-#{session[:filled]}",'pub_geolocations','Traffic_Continent','country_code','impressions',adclientid,@startdate, @enddate,@continent_code,'admin_analytic','')
                     #frame query to retrive traffic source recordset from the database.
                      #sub_query="select  sum(impressions) from adclients_summaries where pub_id =#{session[:pub_id]} and delivery_date>='#{(Time.parse(@startdate)).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(@enddate)).strftime("%Y-%m-%d")} 23:59:59' and (continent_code=#{continent_code}) and (impressions!=0 or clicks!=0)" 
                      #sub_query+=" #{adclient_type}" 
                      query= "select country_code,(sum(fill_rate)+sum(impressions)) as traffic_acquired, sum(impressions) as sum_region,sum(fill_rate) as unfilled,sum(clicks) as sum_clicks,((sum(clicks)/sum(impressions))*100) as sum_ctr,sum(revenue) as sum_revenue,((sum(revenue)/sum(impressions))*1000) as sum_ecpm,(sum(impressions)/(sum(fill_rate)+sum(impressions)))*100 as fr_percentage from pub_geolocations where pub_id =#{session[:pub_id]} and delivery_date>='#{@startdate} 00:00:00' and delivery_date<='#{@enddate} 23:59:59' and (continent_code=#{continent_code}) and (impressions>0 or fill_rate>0 or clicks>0)" 
                      query+= "#{adclient_type}"
                      query+= " group by country_code order by #{session[:filled]=='filled' ? "sum_region" : session[:filled]=='unfilled' ? "unfilled" : "traffic_acquired"} desc"
                     @countrydata_pages, @countrydata = paginate_by_sql AdclientsSummary,query,20
                  else
                    flash[:notice]="Your are not an authorized user. Please login with different username."
                    redirect_to :controller=>'login', :action=>'login'
                end
            end
         rescue Exception=>e
             puts "DEBUG :: ERROR :: in Admin analytic controller :: traffic_country method :: #{e.to_s}"
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
                  if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                       # @handset_report = session[:xml_string]
                        @smartLable='1' #1 represent smartLable as Enabled
                        session[:handset]=params[:handset] if params[:handset]!=nil && params[:handset]!=''
                        @handset=session[:handset] #initialize handset code from params
                        @handset=@handset.gsub(/[~]/,'&')
                        @XML_handset_report=@@pub_obj.generate_query("#{session[:pub_id]}-#{session[:filled]}",'pub_handsets','Pie_chart','handset_model','impressions',session[:report_adclient],session[:report_start_on],session[:report_end_on],@smartLable,'admin_analytic',@handset)
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
              puts "DEBUG :: ERROR :: in Admin analytic controller :: publisher_handset method :: #{e.to_s}"
          end
        end 
        
     #--------------------------------------------------------------------------------------------
      #Method Name: generate_report
      #Purpose: this method  gets input as a parameter from the publisher and generate xml string and array. 
      #Version: 1.0
      #Author:Md Shujauddeen A
      #Last Modified: 30-Oct-2008 by Md Shujauddeen
      #Notes: None.
     #-------------------------------------------------------------------------------------------- 
   def generate_report
       begin
          @aes = AESSecurity.new() 
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                    xml_string_hash=Hash.new
                    xml_array_hash=Hash.new
                    verifyDBconnection
                    @smartLable='0' #0 represent smartLable as disabled
                    session[:report_adclient]=@aes.decrypt(session[:key],session[:iv],params[:adclient_dropdown])   #initialize adclient session 
                    session[:adminstart_on]=session[:report_start_on]=params[:pub_start_on]#initialize start date session
                    session[:adminend_on]=session[:report_end_on]=params[:pub_end_on] #initialize end date session
                    session[:duration]=params[:duration] #initialize range (duration) session
                    session[:filled]=params[:filled]
                    #structure of parameter
                    #generate_query(publisher_id,table_name,report_type,first_columnm,second_column,adClient_Id,start_date,end_date)
                    #calls generate query method to construct TRAFFIC query and xml
                    xml_summary_report=@@pub_obj.generate_query("#{session[:pub_id]}-#{session[:filled]}",'adclients_summaries','Traffic_summary','delivery_date','impressions',session[:report_adclient],params[:pub_start_on],params[:pub_end_on],params[:duration],'admin_analytic','')
                    if xml_summary_report==nil 
                          xml_summary_report={:xml_string=>nil,:xml_array=>nil} 
                    end
                    #calls generate query method to construct HOURLY traffic query and xml
                    #~ xml_hourly_report=@@pub_obj.generate_query("#{session[:pub_id]}-#{session[:filled]}",'adclients_summaries','hourly_report','delivery_hour','impressions',session[:report_adclient],params[:pub_start_on],params[:pub_end_on],'','admin_analytic','')
                    #~ if xml_hourly_report==nil 
                          #~ xml_hourly_report={:xml_string=>nil,:xml_array=>nil} 
                    #~ end
                        
                   #calls generate query method to construct DEMOGRAPHIC keyword and xml
                    xml_channel_report=@@pub_obj.generate_query("#{session[:pub_id]}-#{session[:filled]}",'pub_channels','Pie_chart','channel','requests',session[:report_adclient],params[:pub_start_on], params[:pub_end_on],@smartLable,'admin_analytic','')
                    if xml_channel_report==nil 
                          xml_channel_report={:xml_string=>nil,:xml_array=>nil} 
                    end
                    
                    #~ #calls generate query method to construct DEVICE keyword and xml
                    adclient_type=session[:report_adclient]
                     if session[:report_adclient].to_s!='SMS'and  session[:report_adclient].to_s!='WAP'
                          @adc=Adclient.find(session[:report_adclient]) 
                          adclient_type=(@adc.client_type).upcase
                    end
                    xml_handset_report=@@pub_obj.generate_query("#{session[:pub_id]}-#{session[:filled]}",'pub_handsets','Pie_chart','handset','impressions',session[:report_adclient],params[:pub_start_on], params[:pub_end_on],@smartLable,'admin_analytic','')  if adclient_type!='SMS'
                    xml_handset_report={:xml_string=>nil,:xml_array=>nil} if adclient_type=='SMS'
                    if xml_handset_report==nil and adclient_type=='WAP'
                          xml_handset_report={:xml_string=>nil,:xml_array=>nil} 
                    end
                        
                      #calls generate query method to construct URL query and xml
                     xml_url_report=@@pub_obj.generate_query("#{session[:pub_id]}-#{session[:filled]}",'pub_urls','Pie_chart','url','requests',session[:report_adclient],params[:pub_start_on], params[:pub_end_on],@smartLable,'admin_analytic','')   if adclient_type!='SMS'
                     xml_url_report={:xml_string=>nil,:xml_array=>nil} if adclient_type=='SMS'
                     if xml_url_report==nil and adclient_type=='WAP'
                          xml_url_report={:xml_string=>nil,:xml_array=>nil} 
                    end
                          
                      #~ #calls generate query method to construct CARRIER query and xml
                      xml_carrier_report=@@pub_obj.generate_query("#{session[:pub_id]}-#{session[:filled]}",'pub_carriers','Pie_chart','operator','requests',session[:report_adclient],params[:pub_start_on], params[:pub_end_on],@smartLable,'admin_analytic','')
                       if xml_carrier_report==nil 
                              xml_carrier_report={:xml_string=>nil,:xml_array=>nil} 
                       end 
                     #calls generate query method to construct UNIQUE VISITOR query and xml
                     xml_traffic_visitor=@@pub_obj.generate_query("#{session[:pub_id]}-#{session[:filled]}",'adclients_summaries','Visitors','delivery_date','requests_unique_visitors',session[:report_adclient],params[:pub_start_on], params[:pub_end_on],params[:duration],'admin_analytic','')
                      if xml_traffic_visitor==nil 
                            xml_traffic_visitor={:xml_string=>nil,:xml_array=>nil} 
                     end 
                     #call generate query method to construct query and generate traffic source xml
                      xml_traffic=@@pub_obj.generate_query("#{session[:pub_id]}-#{session[:filled]}",'pub_geolocations','Traffic','continent_code','impressions',session[:report_adclient],params[:pub_start_on], params[:pub_end_on],'','admin_analytic','')
                       if xml_traffic==nil 
                            xml_traffic={:xml_string=>nil,:xml_array=>nil} 
                      end  
                    
                      #assaign xml string to an hash and put it in a session variable
                      xml_string_hash={:summary=>xml_summary_report[:xml_string],:channel=>xml_channel_report[:xml_string],:handset=>xml_handset_report[:xml_string],:visitor=>xml_traffic_visitor[:xml_string],:traffic=>xml_traffic[:xml_string],:carrier=>xml_carrier_report[:xml_string]}
                       session[:xml_string]=xml_string_hash
                      
                      #assaign xml array to an hash and put it in a session variable
                      xml_array_hash={:channel_arr=>xml_channel_report[:xml_array],:handset_arr=>xml_handset_report[:xml_array],:url_arr=>xml_url_report[:xml_array],:carrier_arr=>xml_carrier_report[:xml_array]}
                       session[:xml_array]=xml_array_hash 
                     #retrieve the adclient list from the database
                        #~ @adclient_list=Adclient.find_by_sql("select id, app_name from adclients where publisher_id=#{session[:pub_id]}")
                        #~ @summry_report = session[:xml_string] #retrieves the hash from the session
                      redirect_to :controller=>"admin_analytic", :action=>"publisher_home"
                else
                    flash[:notice]="Your are not an authorized user. Please login with different username."
                    redirect_to :controller=>'login', :action=>'login'
                end
            end
        rescue Exception=>e
          puts "DEBUG :: ERROR :: in Admin analytic controller :: generate_report method :: #{e.to_s}"
        end
      end
      #--------------------------------------------------------------------------------------------
      #Method Name: daysinmonth
      #Purpose: this method is used to get the number of days in a given month.
      #Version: 1.0
      #Author:Md Shujauddeen A
      #Last Modified: 30-Aug-2008 by Md Shujauddeen
      #Notes: None.
     #-------------------------------------------------------------------------------------------- 
      def daysinmonth(year, month)
          begin
              @aes = AESSecurity.new() #creating an object for AES Security
              if (session[:user_id]==nil)
                  flash[:notice]="Your session has expired. Please login again."
                  redirect_to :controller=>'login', :action=>'login'
              else
                  if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                      return (Date.new(year, 12, 31) << (12-month)).day
                  else
                    flash[:notice]="Your are not an authorized user. Please login with different username."
                    redirect_to :controller=>'login', :action=>'login'
                end
            end
         rescue Exception=>e
             puts "DEBUG :: ERROR :: in Admin analytic controller :: daysinmonth method :: #{e.to_s}"
          end
      end      
     #--------------------------------------------------------------------------------------------
      #Method Name: updateChart
      #Purpose: this method is used to update the charts using Ajax Updater method.
      #Version: 1.0
      #Author:Md Shujauddeen A
      #Last Modified: 30-Oct-2008 by Md Shujauddeen
      #Notes: None.
     #-------------------------------------------------------------------------------------------- 
    def updateChart
          begin
              @aes = AESSecurity.new() #creating an object for AES Security
              if (session[:user_id]==nil)
                    flash[:notice]="Your session has expired. Please login again."
                    redirect_to :controller=>'login', :action=>'login'
              else
                  if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                       @XML_summary_report=@@pub_obj.generate_query("#{session[:pub_id]}-#{session[:filled]}",'adclients_summaries','Traffic_summary','delivery_date',params[:report_type],session[:report_adclient],session[:report_start_on],session[:report_end_on],session[:duration]) 
                       session[:chartType]=params[:report_type]
                       @chart=@XML_summary_report[:xml_string]
                       render :action=>'updateChart',:layout=>false
                  else
                      flash[:notice]="Your are not an authorized user. Please login with different username."
                      redirect_to :controller=>'login', :action=>'login'
                  end
              end
          rescue Exception=>e
              puts "DEBUG :: ERROR :: in admin analytic controller :: updateChart method :: #{e.to_s}"
         end
       end
    #--------------------------------------------------------------------------------------------
      #Method Name: showTextReport
      #Purpose:This method is used to render summary table on Publisher home page
      #Version: 1.0
      #Author:Md Shujauddeen A
      #Last Modified: 30-Oct-2008 by Md Shujauddeen
      #Notes: None.
     #-------------------------------------------------------------------------------------------- 
    def showTextReport
       begin
            @aes = AESSecurity.new() #creating an object for AES Security
            if (session[:user_id]==nil)
                flash[:notice]="Your session has expired. Please login again."
                redirect_to :controller=>'login', :action=>'login'
            else
                  if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                      verifyDBconnection
                      @start_rec=params[:start_rec]
                      @record_count=params[:record_count]
                      @adclient_type=(session[:report_adclient]!='SMS' and session[:report_adclient]!='WAP')? " and client_id=#{session[:report_adclient]}" : " and (ad_client_type='#{session[:report_adclient].upcase}' or ad_client_type='#{session[:report_adclient].downcase}')"
                      query="select #{session[:filled]=='filled' ? "sum(impressions)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(impressions)+sum(fill_rate))"} as sum_impressions,sum(clicks) as sum_clicks,((sum(clicks)/#{session[:filled]=='filled' ? "sum(impressions)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(impressions)+sum(fill_rate))"})*100)  as sum_ctr,sum(revenue) as sum_revenue,((sum(revenue)/#{session[:filled]=='filled' ? "sum(impressions)" : session[:filled]=='unfilled' ? "sum(fill_rate)" : "(sum(impressions)+sum(fill_rate))"})*1000) as sum_ecpm, date_format(delivery_date,'%Y/%m/%d') as delivered_date from adclients_summaries" 
                      query+=" where pub_id =#{session[:pub_id]}" 
                      query+=" and delivery_date>='#{(Time.parse(session[:report_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:report_end_on])).strftime("%Y-%m-%d")} 23:59:59'"
                      query+=" #{@adclient_type}" 
                      query+=" group by Year(delivery_date),MONTH(delivery_date),Day(delivery_date)"
                      @summarydata_pages, @summrydata = paginate_by_sql AdclientsSummary,query,20
                      #~ @total_rec=AdclientsSummary.find_by_sql("select  count(distinct(delivery_date)) as rec_length from adclients_summaries where pub_id =#{session[:pub_id]} and delivery_date>='#{(Time.parse(session[:report_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:report_end_on])).strftime("%Y-%m-%d")} 23:59:59' and client_id =16 ")
                      render :action=>'showTextReport',:layout=>false
                  else
                      flash[:notice]="Your are not an authorized user. Please login with different username."
                      redirect_to :controller=>'login', :action=>'login'
                  end
              end
      rescue Exception=>e
          puts "DEBUG :: ERROR :: in Admin analytic controller :: showTextReport method :: #{e.to_s}"
      end
    end
    
        #--------------------------------------------------------------------------------------------
        #Method Name: generate_Csv
        #Purpose: This method will be used to export summary table value to csv
        #Version: 1.0
        #Author:Md Shujauddeen
        #Last Modified: 30-Oct-2008 by Md Shujauddeen
        #Notes: None.
      #-------------------------------------------------------------------------------------------- .
       def generate_Csv
        begin
              @aes = AESSecurity.new() #creating an object for AES Security
              if (session[:user_id]==nil)
                  flash[:notice]="Your session has expired. Please login again."
                  redirect_to :controller=>'login', :action=>'login'
              else
                  if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                       filename = "zestadz_#{params[:heading]}" + ".csv"
                       send_data(session[:csv_string],:type => 'text/csv; charset=utf-8; header=present',:filename => filename)
                  else
                      flash[:notice]="Your are not an authorized user. Please login with different username."
                      redirect_to :controller=>'login', :action=>'login'
                  end
              end
          rescue Exception=>e
              puts "DEBUG :: ERROR :: in Admin analytic controller :: generate_Csv method :: #{e.to_s}"
         end
       end #generate csv method ends here
    #--------------------------------------------------------------------------------------------
        #Method Name: returnCountryhash
        #Purpose: This method will be used to return country code hash
        #Version: 1.0
        #Author:Md Shujauddeen
        #Last Modified: 31-Oct-2008 by Md Shujauddeen
        #Notes: None.
      #-------------------------------------------------------------------------------------------- .
    def returnCountryhash(countrycode)
        begin
            europe={"AL"=>"Albania","AD"=>"Andorra","AT"=>"Austria","BY"=>"Belarus","BE"=>"Belgium","BA"=>"Bosnia and Herzegovina","BG"=>"Bulgaria","HR"=>"Croatia","CZ"=>"Czech Republic","DK"=>"Denmark","EE"=>"Estonia","FI"=>"Finland","FR"=>"France","DE"=>"Germany","GR"=>"Greece","HU"=>"Hungary","IS"=>"Iceland","IE"=>"Ireland","IT"=>"Italy","LV"=>"Liechtenstein","LI"=>"Liechtenstein","LT"=>"Lithuania","LU"=>"Luxembourg","MK"=>"Macedonia","MT"=>"Malta","MD"=>"Moldova","MC"=>"Monaco","ME"=>"Montenegro","NL"=>"Netherlands","NO"=>"Norway","PL"=>"Poland","PT"=>"Portugal","RO"=>"Romania","SM"=>"San Marino","CS"=>"Serbia","SK"=>"Slovakia","SI"=>"Slovenia","ES"=>"Spain","SE"=>"Sweden","CH"=>"Switzerland","UA"=>"Ukraine","GB"=>"United Kingdom","VA"=>"Vatican City ","CY"=>"Cyprus","TR"=>"Turkey","RU"=>"Russia","AX"=>"Aland Islands","FO"=>"Faroe Islands","GI"=>"Gibraltar"}
            northAmerica={"AG"=>"Antigua and Barbuda","BS"=>"Bahamas","BB"=>"Barbados","BZ"=>"Belize","CA"=>"Canada","CR"=>"Costa Rica","CU"=>"Cuba","DM"=>"Dominica","DO"=>"Dominican Rep.","SV"=>"El Salvador","GD"=>"Grenada","GT"=>"Guatemala","HT"=>"Haiti","HN"=>"Honduras","JM"=>"Jamaica","MX"=>"Mexico","NI"=>"Nicaragua","PA"=>"Panama","KN"=>"St. Kitts & Nevis","LC"=>"St. Lucia","VC"=>"St. Vincent & the Grenadines","TT"=>"Trinidad & Tobago","US"=>"United States","GL"=>"Greenland","PR"=>"Puerto Rico","KY"=>"Cayman Islands","AI"=>"Anguilla","AW"=>"Aruba","BM"=>"Bermuda","GP"=>"Guadeloupe","MQ"=>"Martinique","MS"=>"Montserrat","AN"=>"Netherlands Antilles","TC"=>"Turks And Caicos Islands","VG"=>"Virgin Islands - British","VI"=>"VIRGIN ISLANDS - U.S"}
            southAmerica={"AR"=>"Argentina","BO"=>"Bolivia","BR"=>"Brazil","CL"=>"Chile","CO"=>"Colombia","EC"=>"Ecuador","FK"=>"Falkland Islands","GF"=>"French Guiana","GY"=>"Guyana","PY"=>"Paraguay","PE"=>"Peru","SR"=>"Suriname","UY"=>"Uruguay","VE"=>"Venezuela"}
            asia={"AF"=>"Afghanistan","AM"=>"Armenia","AZ"=>"Azerbaijan","BD"=>"Bangladesh","BT"=>"Bhutan","BN"=>"Brunei","MM"=>"Burma (Myanmar)","KH"=>"Cambodia","CN"=>"China","TP"=>"East Timor","GE"=>"Georgia","IN"=>"India","ID"=>"Indonesia","IR"=>"Iran","JP"=>"Japan","KZ"=>"Kazakhstan","KP"=>"Korea (north)","KR"=>"Korea (south)","KG"=>"Kyrgyzstan","LA"=>"Laos","MY"=>"Malaysia","MN"=>"Mongolia","NP"=>"Nepal","PK"=>"Pakistan","PH"=>"Philippines","RU"=>"Russian Federation","SG"=>"Singapore","LK"=>"Sri Lanka","TJ"=>"Tajikistan","TH"=>"Thailand","TM"=>"Turkmenistan","UZ"=>"Uzbekistan","VN"=>"Vietnam","TW"=>"Taiwan","HK"=>"Hong Kong","MO"=>"Macau","IO"=>"BRITISH INDIAN OCEAN TERRITORY","MV"=>"Maldives","PS"=>"PALESTINIAN TERRITORY, OCCUPIED",}
            africa={"DZ"=>"Algeria","AO"=>"Angola","BJ"=>"Benin","BW"=>"Botswana","BF"=>"Burkina Faso","BI"=>"Burundi","CM"=>"Cameroon","CV"=>"Cape Verde","CF"=>"Central African Republic","TD"=>"Chad","KM"=>"Comoros","CI"=>"Cote d Ivoire","CD"=>"Democratic Republic of the Congo","DJ"=>"Djibouti","EG"=>"Egypt","GQ"=>"Equatorial Guinea","ER"=>"Eritrea","ET"=>"Ethiopia","GA"=>"Gabon","GH"=>"Ghana","GN"=>"Guinea","GW"=>"Guinea-Bissau","KE"=>"Kenya","LS"=>"Lesotho","LR"=>"Liberia","LY"=>"Libya","MG"=>"Madagascar","MW"=>"Malawi","ML"=>"Mali","MR"=>"Mauritania","MA"=>"Morocco","MZ"=>"Mozambique","NA"=>"Namibia","NE"=>"Niger","NG"=>"Nigeria","RW"=>"Rwanda","ST"=>"Sao Tome and Principe","SN"=>"Senegal","SY"=>"Seycelles","SL"=>"Sierra Leone","SO"=>"Somalia","ZA"=>"South Africa","SD"=>"Sudan","SZ"=>"Swaziland","TZ"=>"Tanzania","TG"=>"Togo","TN"=>"Tunisia","UG"=>"Uganda","WS"=>"Western Sahara","ZM"=>"Zambia","ZW"=>"Zimbabwe","GM"=>"Gambia","CG"=>"Congo","MU"=>"Mauritius","YT"=>"Mayotte","RE"=>"Reunion","SC"=>"SEYCHELLES"}
            oceania={"AU"=>"Australia","FJ"=>"Fiji","KI"=>"Kiribati","MH"=>"Marshall Islands","FM"=>"Micronesia","NR"=>"Nauru","NZ"=>"New Zealand","PW"=>"Palau","PG"=>"Papua New Guinea","WS"=>"Samoa","SB"=>"Solomon Islands","TO"=>"Tonga","TV"=>"Tuvalu","VU"=>"Vanuatu","NC"=>"New Caledonia","AS"=>"American Samoa","CK"=>"Cook Islands","GU"=>"Guam","MP"=>"Northern Mariana Islands","NF"=>"Norfolk Islands","NU"=>"Niue","PF"=>"French Polynesia","TK"=>"Tokelau","UM"=>"United States Minor Outlying Islands"}
            middleEast={"AF"=>"Afghanistan","BH"=>"Bahrain","IR"=>"Iran","IQ"=>"Iraq","IL"=>"Israel","JO"=>"Jordan","KW"=>"Kuwait","KG"=>"Kyrgyzstan ","LB"=>"Lebanon","OM"=>"Oman","PK"=>"Pakistan","QA"=>"Qatar","SA"=>"SaudiArabia","SY"=>"Syria","TI"=>"Tajikistan","TU"=>"Turkey","TX"=>"Turkmenistan","AE"=>"UnitedArabEmirates","UZ"=>"Uzbekistan","YE"=>"Yemen"}
            centralAmerica={"BZ"=>"Belize","CR"=>"Costa Rica","SV"=>"El Salvador","GT"=>"Guatemala","HN"=>"Honduras","NI"=>"Nicaragua","PA"=>"Panama"}
            countrycode=(countrycode=='CB' or countrycode=='' or countrycode==nil) ? 'NA' : (countrycode=='NA' or countrycode=='SA' or countrycode=='AS' or countrycode=='OC' or countrycode=='AF' or countrycode=='EU' or countrycode=='ME' or countrycode=='CA') ? countrycode : 'NA'
            countryHash = case countrycode
                 when "NA" : northAmerica
                 when "SA" : southAmerica
                 when "AS" : asia
                 when "OC" : oceania
                 when "AF" : africa
                 when "EU" : europe
                 when "ME" : middleEast
                 when "CA" : centralAmerica
               end
            return countryHash
        rescue Exception=>e
              puts "DEBUG :: ERROR :: in Admin analytic controller :: returnCountryhash method :: #{e.to_s}"
        end
      end
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
                    if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                    else
                          flash[:notice]="Your are not an authorized user. Please login with different username."
                          redirect_to :controller=>'login'
                    end
                end
          rescue Exception=>e
              puts "DEBUG :: ERROR :: in advertiser_analytic_controller - adv_generate_csv method Exception :: #{e.to_s}"
              render :action=>'dashboard_move'
          end
        end
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#Method Name: home_analytics
	#Purpose: to generate publisher fillrate chart
	#Version: 1.0
	#Author: Md Shujauddeen A
	#Last Modified: 06-Aug-2008 by Md Shujauddeen A
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    def admin_pub_fillrate
        begin
                @aes = AESSecurity.new() #creating an object for AES Security
                if (session[:user_id]==nil)
                    flash[:notice]="Your session has expired. Please login again."
                    redirect_to :controller=>'login', :action=>'login'
                else
                    if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                          @enddate=(Time.now-86400).strftime("%d-%b-%Y")
                          @startdate= (Time.now-86400).strftime("%d-%b-%Y")
                          verifyDBconnection
                          session[:user_fillrate]=nil
                          session[:adminstart_on] = (params[:adminstart_on]!=nil && params[:adminstart_on]!="") ? params[:adminstart_on] : (session[:adminstart_on]!=nil && session[:adminstart_on]!='') ? session[:adminstart_on] : @startdate
                          session[:adminend_on] = (params[:adminend_on]!=nil && params[:adminend_on]!="") ? params[:adminend_on] : (session[:adminend_on]!=nil && session[:adminend_on]!='') ? session[:adminend_on] : @enddate 
                          # Display the Data in Chart.
                          session[:duration]=(params[:duration]!=nil && params[:duration]!="") ? params[:duration] : (session[:duration]!=nil && session[:duration]!='') ? session[:duration] : 1 
                          session[:order]=(params[:order]!=nil && params[:order]!="") ? params[:order] : (session[:order]!=nil && session[:order]!='') ? session[:order] : 'desc' 
                          session[:limit]=limit=(params[:limit]!=nil && params[:limit]!="") ? params[:limit] : (session[:limit]!=nil && session[:limit]!='') ? session[:limit] : 10  
                          session[:region]=nil
                           @XML_fillrate_summary = @@objXml.publisher_fillrate(session[:adminstart_on],session[:adminend_on],session[:limit],session[:order])
                           #assign xml string to an hash and put it in a session variable for the Chart.
                           @xml_string_hash={:fillrate_xml=>@XML_fillrate_summary[:xml_string]}
                           session[:xml_string]=@xml_string_hash
                           sql="select pub_id,p.publisher_name as pub_name,(sum(fill_rate)+sum(impressions)) as traffic_acquired,sum(impressions) as traffic_delivered,sum(fill_rate) as fillrate, (sum(impressions)/(sum(fill_rate)+sum(impressions)))*100 as fr_percentage from adclients_summaries ad,publishers p where delivery_date>='#{(Time.parse(session[:adminstart_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse( session[:adminend_on] )).strftime("%Y-%m-%d")} 23:59:59' and p.id=ad.pub_id and (impressions>0 or fill_rate>0) group by pub_id order by traffic_acquired #{session[:order]}"
                          @fillrate_pages, @fillrate = paginate_by_sql AdclientsSummary,sql,session[:limit].to_i
                    else
                          flash[:notice]="Your are not an authorized user. Please login with different username."
                          redirect_to :controller=>'login'
                    end
                end
          rescue Exception=>e
              puts "DEBUG :: ERROR :: in admin_analytic_controller - admin_pub_fillrate method Exception :: #{e.to_s}"
              render :action=>'admin_pub_fillrate'
          end
    end
        
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#Method Name: admin_fillrate_country
	#Purpose: to generate publisher fillrate chart
	#Version: 1.0
	#Author: Md Shujauddeen A
	#Last Modified: 06-Aug-2008 by Md Shujauddeen A
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    def admin_fillrate_country
        begin
                @aes = AESSecurity.new() #creating an object for AES Security
                if (session[:user_id]==nil)
                    flash[:notice]="Your session has expired. Please login again."
                    redirect_to :controller=>'login', :action=>'login'
                else
                    if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                          @enddate=(Time.now-86400).strftime("%d-%b-%Y")
                          @startdate= (Time.now-86400).strftime("%d-%b-%Y")
                          @countrynameHash={"NA.AG"=>"Antigua and Barbuda","NA.BS"=>"Bahamas","NA.BB"=>"Barbados","CA.BZ"=>"Belize","NA.CA"=>"Canada","CA.CR"=>"Costa Rica","NA.CU"=>"Cuba","NA.DM"=>"Dominica","NA.DO"=>"Dominican Rep.","CA.SV"=>"El Salvador","NA.GD"=>"Grenada","CA.GT"=>"Guatemala","NA.HT"=>"Haiti","CA.HN"=>"Honduras","NA.JM"=>"Jamaica","NA.MX"=>"Mexico","CA.NI"=>"Nicaragua","CA.PA"=>"Panama","NA.KN"=>"St. Kitts & Nevis","NA.LC"=>"St. Lucia","NA.VC"=>"St. Vincent & the Grenadines","NA.TT"=>"Trinidad & Tobago","NA.US"=>"United States","NA.GL"=>"Greenland","SA.AR"=>"Argentina","SA.BO"=>"Bolivia","SA.BR"=>"Brazil","SA.CL"=>"Chile","SA.CO"=>"Colombia","SA.EC"=>"Ecuador","SA.FK"=>"Falkland Islands","SA.GF"=>"French Guiana","SA.GY"=>"Guyana","SA.PY"=>"Paraguay","SA.PE"=>"Peru","SA.SR"=>"Suriname","SA.UY"=>"Uruguay","SA.VE"=>"Venezuela","AF.DZ"=>"Algeria","AF.AO"=>"Angola","AF.BJ"=>"Benin","AF.BW"=>"Botswana","AF.BF"=>"Burkina Faso","AF.BI"=>"Burundi","AF.CM"=>"Cameroon","AF.CV"=>"Cape Verde","AF.CF"=>"Central African Republic","AF.TD"=>"Chad","AF.KM"=>"Comoros","AF.CI"=>"Cote d Ivoire","AF.CD"=>"Democratic Republic of the Congo","AF.DJ"=>"Djibouti","AF.EG"=>"Egypt","AF.GQ"=>"Equatorial Guinea","AF.ER"=>"Eritrea","AF.ET"=>"Ethiopia","AF.GA"=>"Gabon","AF.GH"=>"Ghana","AF.GN"=>"Guinea","AF.GW"=>"Guinea-Bissau","AF.KE"=>"Kenya","AF.LS"=>"Lesotho","AF.LR"=>"Liberia","AF.LY"=>"Libya","AF.MG"=>"Madagascar","AF.MW"=>"Malawi","AF.ML"=>"Mali","AF.MR"=>"Mauritania","AF.MA"=>"Morocco","AF.MZ"=>"Mozambique","AF.NA"=>"Namibia","AF.NE"=>"Niger","AF.NG"=>"Nigeria","AF.RW"=>"Rwanda","AF.ST"=>"Sao Tome and Principe","AF.SN"=>"Senegal","AF.SL"=>"Sierra Leone","AF.SO"=>"Somalia","AF.ZA"=>"South Africa","AF.SD"=>"Sudan","AF.SZ"=>"Swaziland","AF.TZ"=>"Tanzania","AF.TG"=>"Togo","AF.TN"=>"Tunisia","AF.UG"=>"Uganda","AF.ZM"=>"Zambia","AF.ZW"=>"Zimbabwe","AF.GM"=>"Gambia","AF.CG"=>"Congo","AF.MU"=>"Mauritius","AS.AF"=>"Afghanistan","AS.AM"=>"Armenia","AS.AZ"=>"Azerbaijan","AS.BD"=>"Bangladesh","AS.BT"=>"Bhutan","AS.BN"=>"Brunei","AS.MM"=>"Burma (Myanmar)","AS.KH"=>"Cambodia","AS.CN"=>"China","AS.TP"=>"East Timor","AS.GE"=>"Georgia","AS.IN"=>"India","AS.ID"=>"Indonesia","ME.IR"=>"Iran","AS.JP"=>"Japan","AS.KZ"=>"Kazakhstan","AS.KR"=>"Korea - South","AS.KG"=>"Kyrgyzstan","AS.LA"=>"Laos","AS.MY"=>"Malaysia","AS.MN"=>"Mongolia","AS.NP"=>"Nepal","AS.PK"=>"Pakistan","AS.PH"=>"Philippines","AS.RU"=>"Russian Federation","AS.SG"=>"Singapore","AS.LK"=>"Sri Lanka","AS.TJ"=>"Tajikistan","AS.TH"=>"Thailand","AS.TM"=>"Turkmenistan","AS.UZ"=>"Uzbekistan","AS.VN"=>"Vietnam","AS.TW"=>"Taiwan","AS.HK"=>"Hong Kong","AS.MO"=>"Macau","EU.AL"=>"Albania","EU.AD"=>"Andorra","EU.AT"=>"Austria","EU.BY"=>"Belarus","EU.BE"=>"Belgium","EU.BA"=>"Bosnia and Herzegovina","EU.BG"=>"Bulgaria","EU.HR"=>"Croatia","EU.CZ"=>"Czech Republic","EU.DK"=>"Denmark","EU.EE"=>"Estonia","EU.FI"=>"Finland","EU.FR"=>"France","EU.DE"=>"Germany","EU.GR"=>"Greece","EU.HU"=>"Hungary","EU.IS"=>"Iceland","EU.IE"=>"Ireland","EU.IT"=>"Italy","EU.LV"=>"Latvia","EU.LI"=>"Liechtenstein","EU.LT"=>"Lithuania","EU.LU"=>"Luxembourg","EU.MK"=>"Macedonia","EU.MT"=>"Malta","EU.MD"=>"Moldova","EU.MC"=>"Monaco","EU.MO"=>"Montenegro","EU.NL"=>"Netherlands","EU.NO"=>"Norway","EU.PL"=>"Poland","EU.PT"=>"Portugal","EU.RO"=>"Romania","EU.SM"=>"San Marino","EU.CS"=>"Serbia","EU.SK"=>"Slovakia","EU.SI"=>"Slovenia","EU.ES"=>"Spain","EU.SE"=>"Sweden","EU.CH"=>"Switzerland","EU.UA"=>"Ukraine","EU.UK"=>"United Kingdom","EU.VA"=>"Vatican City","EU.CY"=>"Cyprus","EU.TR"=>"Turkey","EU.RU"=>"Russia","OC.AU"=>"Australia","OC.FJ"=>"Fiji","OC.KI"=>"Kiribati","OC.MH"=>"Marshall Islands","OC.FM"=>"Micronesia","OC.NR"=>"Nauru","OC.NZ"=>"New Zealand","OC.PW"=>"Palau","OC.PG"=>"Papua New Guinea","OC.WS"=>"Samoa","OC.SB"=>"Solomon Islands","OC.TO"=>"Tonga","OC.TV"=>"Tuvalu","OC.VU"=>"Vanuatu","OC.NC"=>"New Caledonia","ME.BH"=>"Bahrain","ME.IQ"=>"Iraq","ME.IL"=>"Israel","ME.JO"=>"Jordan","ME.KW"=>"Kuwait","ME.LB"=>"Lebanon","ME.OM"=>"Oman","ME.QA"=>"Qatar","ME.SA"=>"Saudi Arabia","ME.SY"=>"Syria","ME.AE"=>"UnitedArabEmirates","ME.YE"=>"Yemen","NA.PR"=>"Puerto Rico","NA.KY"=>"Cayman Islands","AF.YT"=>"Mayotte","AF.RE"=>"Reunion","AQ.AQ"=>"Antarctica","AS.MV"=>"Maldives","EU.AX"=>"Aland Islands","EU.GI"=>"Gibraltar","EU.FO"=>"Faroe Islands","NA.BM"=>"Bermuda","NA.TC"=>"Turks and Caicos Islands","NA.AI"=>"Anguilla","NA.MS"=>"Montserrat","NA.VI"=>"Virgin Islands - British","NA.GP"=>"Guadeloupe","NA.AW"=>"Aruba","NA.AN"=>"Netherlands Antilles","NA.MQ"=>"Martinique","OC.MP"=>"Northern Mariana Islands","OC.CK"=>"Cook Islands","OC.GU"=>"Guam","OC.PF"=>"French Polynesia","OC.NU"=>"Niue","OC.NF"=>"Norfolk Island","OC.UM"=>"United States Minor Outlying Islands","OC.TK"=>"Tokelau","OC.AS"=>"American Samoa","EU.GB"=>"United Kingdom","EU.JE"=>"Jersey","AF.SC"=>"Seycelles","AS.KP"=>"Korea - North","AS.PS"=>"Palestinian Territory","AS.IO"=>"British Indian Ocean Territory","CA.PM"=>"Saint Pierre and Miquelon","NA.VG"=>"Virgin Islands"}
                          verifyDBconnection
                          session[:adminstart_on] = (params[:adminstart_on]!=nil && params[:adminstart_on]!="") ? params[:adminstart_on] : (session[:adminstart_on]!=nil && session[:adminstart_on]!='') ? session[:adminstart_on] : @startdate
                          session[:adminend_on] = (params[:adminend_on]!=nil && params[:adminend_on]!="") ? params[:adminend_on] : (session[:adminend_on]!=nil && session[:adminend_on]!='') ? session[:adminend_on] : @enddate 
                          session[:duration]=(params[:duration]!=nil && params[:duration]!="") ? params[:duration] : (session[:duration]!=nil && session[:duration]!='') ? session[:duration] : 1 
                          @continent_code=session[:region]
                          session[:getPub_id]=@aes.decrypt(session[:key],session[:iv],params[:pub_id]) if params[:pub_id]!=nil && params[:pub_id]!=''
                          @pub_id=session[:getPub_id]
                          disp_user_id=Publisher.find_by_id(session[:getPub_id].to_i).user_id
                          session[:user_fillrate]=User.find_by_id(disp_user_id).username
                          @XML_fillrate_country = @@objXml.publisher_fillrate_country(session[:adminstart_on],session[:adminend_on],@pub_id)
                          #assign xml string to an hash and put it in a session variable for the Chart.
                          @xml_string_hash={:fillrate_xml=>@XML_fillrate_country}
                          session[:xml_string]=@xml_string_hash
                          sql="select continent_code,country_code,(sum(fill_rate)+sum(impressions)) as traffic_acquired,sum(impressions) as traffic_delivered,sum(fill_rate) as fillrate, (sum(impressions)/(sum(fill_rate)+sum(impressions)))*100 as fr_percentage from pub_geolocations where delivery_date>='#{(Time.parse(session[:adminstart_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse( session[:adminend_on] )).strftime("%Y-%m-%d")} 23:59:59' and pub_id=#{@pub_id} and (impressions>=1 or fill_rate>=1) group by continent_code,country_code order by traffic_acquired desc"
                          @fillrate_pages, @fillrate = paginate_by_sql AdclientsSummary,sql,20
                    else
                          flash[:notice]="Your are not an authorized user. Please login with different username."
                          redirect_to :controller=>'login'
                    end
                end
          rescue Exception=>e
              puts "DEBUG :: ERROR :: in admin_analytic_controller - admin_fillrate_country method Exception :: #{e.to_s}"
              render :action=>'admin_fillrate_country'
          end
        end
    
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#Method Name: home_analytics
	#Purpose: to generate publisher fillrate chart
	#Version: 1.0
	#Author: Md Shujauddeen A
	#Last Modified: 28-Oct-2010 by Md Shujauddeen A
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    def admin_geo_fillrate
        begin
              @aes = AESSecurity.new() #creating an object for AES Security
              if (session[:user_id]==nil)
                  flash[:notice]="Your session has expired. Please login again."
                  redirect_to :controller=>'login', :action=>'login'
              else
                  if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                        @enddate=(Time.now-86400).strftime("%d-%b-%Y")
                        @startdate= (Time.now-86400).strftime("%d-%b-%Y")
                        @countrynameHash={"NA.AG"=>"Antigua and Barbuda","NA.BS"=>"Bahamas","NA.BB"=>"Barbados","CA.BZ"=>"Belize","NA.CA"=>"Canada","CA.CR"=>"Costa Rica","NA.CU"=>"Cuba","NA.DM"=>"Dominica","NA.DO"=>"Dominican Rep.","CA.SV"=>"El Salvador","NA.GD"=>"Grenada","CA.GT"=>"Guatemala","NA.HT"=>"Haiti","CA.HN"=>"Honduras","NA.JM"=>"Jamaica","NA.MX"=>"Mexico","CA.NI"=>"Nicaragua","CA.PA"=>"Panama","NA.KN"=>"St. Kitts & Nevis","NA.LC"=>"St. Lucia","NA.VC"=>"St. Vincent & the Grenadines","NA.TT"=>"Trinidad & Tobago","NA.US"=>"United States","NA.GL"=>"Greenland","SA.AR"=>"Argentina","SA.BO"=>"Bolivia","SA.BR"=>"Brazil","SA.CL"=>"Chile","SA.CO"=>"Colombia","SA.EC"=>"Ecuador","SA.FK"=>"Falkland Islands","SA.GF"=>"French Guiana","SA.GY"=>"Guyana","SA.PY"=>"Paraguay","SA.PE"=>"Peru","SA.SR"=>"Suriname","SA.UY"=>"Uruguay","SA.VE"=>"Venezuela","AF.DZ"=>"Algeria","AF.AO"=>"Angola","AF.BJ"=>"Benin","AF.BW"=>"Botswana","AF.BF"=>"Burkina Faso","AF.BI"=>"Burundi","AF.CM"=>"Cameroon","AF.CV"=>"Cape Verde","AF.CF"=>"Central African Republic","AF.TD"=>"Chad","AF.KM"=>"Comoros","AF.CI"=>"Cote d Ivoire","AF.CD"=>"Democratic Republic of the Congo","AF.DJ"=>"Djibouti","AF.EG"=>"Egypt","AF.GQ"=>"Equatorial Guinea","AF.ER"=>"Eritrea","AF.ET"=>"Ethiopia","AF.GA"=>"Gabon","AF.GH"=>"Ghana","AF.GN"=>"Guinea","AF.GW"=>"Guinea-Bissau","AF.KE"=>"Kenya","AF.LS"=>"Lesotho","AF.LR"=>"Liberia","AF.LY"=>"Libya","AF.MG"=>"Madagascar","AF.MW"=>"Malawi","AF.ML"=>"Mali","AF.MR"=>"Mauritania","AF.MA"=>"Morocco","AF.MZ"=>"Mozambique","AF.NA"=>"Namibia","AF.NE"=>"Niger","AF.NG"=>"Nigeria","AF.RW"=>"Rwanda","AF.ST"=>"Sao Tome and Principe","AF.SN"=>"Senegal","AF.SL"=>"Sierra Leone","AF.SO"=>"Somalia","AF.ZA"=>"South Africa","AF.SD"=>"Sudan","AF.SZ"=>"Swaziland","AF.TZ"=>"Tanzania","AF.TG"=>"Togo","AF.TN"=>"Tunisia","AF.UG"=>"Uganda","AF.ZM"=>"Zambia","AF.ZW"=>"Zimbabwe","AF.GM"=>"Gambia","AF.CG"=>"Congo","AF.MU"=>"Mauritius","AS.AF"=>"Afghanistan","AS.AM"=>"Armenia","AS.AZ"=>"Azerbaijan","AS.BD"=>"Bangladesh","AS.BT"=>"Bhutan","AS.BN"=>"Brunei","AS.MM"=>"Burma (Myanmar)","AS.KH"=>"Cambodia","AS.CN"=>"China","AS.TP"=>"East Timor","AS.GE"=>"Georgia","AS.IN"=>"India","AS.ID"=>"Indonesia","ME.IR"=>"Iran","AS.JP"=>"Japan","AS.KZ"=>"Kazakhstan","AS.KR"=>"Korea - South","AS.KG"=>"Kyrgyzstan","AS.LA"=>"Laos","AS.MY"=>"Malaysia","AS.MN"=>"Mongolia","AS.NP"=>"Nepal","AS.PK"=>"Pakistan","AS.PH"=>"Philippines","AS.RU"=>"Russian Federation","AS.SG"=>"Singapore","AS.LK"=>"Sri Lanka","AS.TJ"=>"Tajikistan","AS.TH"=>"Thailand","AS.TM"=>"Turkmenistan","AS.UZ"=>"Uzbekistan","AS.VN"=>"Vietnam","AS.TW"=>"Taiwan","AS.HK"=>"Hong Kong","AS.MO"=>"Macau","EU.AL"=>"Albania","EU.AD"=>"Andorra","EU.AT"=>"Austria","EU.BY"=>"Belarus","EU.BE"=>"Belgium","EU.BA"=>"Bosnia and Herzegovina","EU.BG"=>"Bulgaria","EU.HR"=>"Croatia","EU.CZ"=>"Czech Republic","EU.DK"=>"Denmark","EU.EE"=>"Estonia","EU.FI"=>"Finland","EU.FR"=>"France","EU.DE"=>"Germany","EU.GR"=>"Greece","EU.HU"=>"Hungary","EU.IS"=>"Iceland","EU.IE"=>"Ireland","EU.IT"=>"Italy","EU.LV"=>"Latvia","EU.LI"=>"Liechtenstein","EU.LT"=>"Lithuania","EU.LU"=>"Luxembourg","EU.MK"=>"Macedonia","EU.MT"=>"Malta","EU.MD"=>"Moldova","EU.MC"=>"Monaco","EU.MO"=>"Montenegro","EU.NL"=>"Netherlands","EU.NO"=>"Norway","EU.PL"=>"Poland","EU.PT"=>"Portugal","EU.RO"=>"Romania","EU.SM"=>"San Marino","EU.CS"=>"Serbia","EU.SK"=>"Slovakia","EU.SI"=>"Slovenia","EU.ES"=>"Spain","EU.SE"=>"Sweden","EU.CH"=>"Switzerland","EU.UA"=>"Ukraine","EU.UK"=>"United Kingdom","EU.VA"=>"Vatican City","EU.CY"=>"Cyprus","EU.TR"=>"Turkey","EU.RU"=>"Russia","OC.AU"=>"Australia","OC.FJ"=>"Fiji","OC.KI"=>"Kiribati","OC.MH"=>"Marshall Islands","OC.FM"=>"Micronesia","OC.NR"=>"Nauru","OC.NZ"=>"New Zealand","OC.PW"=>"Palau","OC.PG"=>"Papua New Guinea","OC.WS"=>"Samoa","OC.SB"=>"Solomon Islands","OC.TO"=>"Tonga","OC.TV"=>"Tuvalu","OC.VU"=>"Vanuatu","OC.NC"=>"New Caledonia","ME.BH"=>"Bahrain","ME.IQ"=>"Iraq","ME.IL"=>"Israel","ME.JO"=>"Jordan","ME.KW"=>"Kuwait","ME.LB"=>"Lebanon","ME.OM"=>"Oman","ME.QA"=>"Qatar","ME.SA"=>"Saudi Arabia","ME.SY"=>"Syria","ME.AE"=>"UnitedArabEmirates","ME.YE"=>"Yemen","NA.PR"=>"Puerto Rico","NA.KY"=>"Cayman Islands","AF.YT"=>"Mayotte","AF.RE"=>"Reunion","AQ.AQ"=>"Antarctica","AS.MV"=>"Maldives","EU.AX"=>"Aland Islands","EU.GI"=>"Gibraltar","EU.FO"=>"Faroe Islands","NA.BM"=>"Bermuda","NA.TC"=>"Turks and Caicos Islands","NA.AI"=>"Anguilla","NA.MS"=>"Montserrat","NA.VI"=>"Virgin Islands - British","NA.GP"=>"Guadeloupe","NA.AW"=>"Aruba","NA.AN"=>"Netherlands Antilles","NA.MQ"=>"Martinique","OC.MP"=>"Northern Mariana Islands","OC.CK"=>"Cook Islands","OC.GU"=>"Guam","OC.PF"=>"French Polynesia","OC.NU"=>"Niue","OC.NF"=>"Norfolk Island","OC.UM"=>"United States Minor Outlying Islands","OC.TK"=>"Tokelau","OC.AS"=>"American Samoa","EU.GB"=>"United Kingdom","EU.JE"=>"Jersey","AF.SC"=>"Seycelles","AS.KP"=>"Korea - North","AS.PS"=>"Palestinian Territory","AS.IO"=>"British Indian Ocean Territory","CA.PM"=>"Saint Pierre and Miquelon","NA.VG"=>"Virgin Islands"}
                        session[:adminstart_on] = (params[:adminstart_on]!=nil && params[:adminstart_on]!="") ? params[:adminstart_on] : (session[:adminstart_on]!=nil && session[:adminstart_on]!='') ? session[:adminstart_on] : @startdate 
                        session[:adminend_on] = (params[:adminend_on]!=nil && params[:adminend_on]!="") ? params[:adminend_on] : (session[:adminend_on]!=nil && session[:adminend_on]!='') ? session[:adminend_on] : @enddate 
                        session[:duration]=(params[:duration]!=nil && params[:duration]!="") ? params[:duration] : (session[:duration]!=nil && session[:duration]!='') ? session[:duration] : 1 
                        session[:pub_name]=params[:publisher]['publisher_name'] if (params[:page]==nil and params[:publisher]!=nil)
                        verifyDBconnection
                        if session[:pub_name]!=nil and session[:pub_name]!=""
                            if session[:pub_name].downcase=='all'
                                getPubId='All'
                            else
                                @publishers=Publisher.find_by_sql("select id from publishers where publisher_name='#{session[:pub_name]}' and status!='Deleted'")
                                if @publishers!=nil
                                    if @publishers.size>0
                                      getPubId=@publishers[0].id
                                    else
                                      getPubId=0
                                    end
                                else
                                  getPubId=0
                                end
                            end
                        else
                            getPubId='All'
                        end
                        pub_id= (getPubId=='All' || getPubId==nil || getPubId=='') ? "" : " and pub_id='#{getPubId}'"
                        sql="select country_code,continent_code,(sum(fill_rate)+sum(impressions)) as traffic_acquired,sum(impressions) as traffic_delivered,sum(fill_rate) as fillrate, (sum(impressions)/(sum(fill_rate)+sum(impressions)))*100 as fr_percentage from pub_geolocations where delivery_date>='#{(Time.parse(session[:adminstart_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse( session[:adminend_on] )).strftime("%Y-%m-%d")} 23:59:59' and (impressions>0 or fill_rate>0) #{pub_id} group by continent_code,country_code order by traffic_acquired desc"
                        @fillrate_pages, @fillrate = paginate_by_sql AdclientsSummary,sql,100
                  else
                        flash[:notice]="Your are not an authorized user. Please login with different username."
                        redirect_to :controller=>'login'
                  end
              end
        rescue Exception=>e
            puts "DEBUG :: ERROR :: in advertiser_analytic_controller - admin_fillrate method Exception :: #{e.to_s}"
            render :action=>'admin_fillrate'
        end
    end
    
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#Method Name: home_analytics
	#Purpose: to generate publisher fillrate chart
	#Version: 1.0
	#Author: Md Shujauddeen A
	#Last Modified: 27-Oct-2010 by Md Shujauddeen A
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    def admin_fillrate
        begin
              @aes = AESSecurity.new() #creating an object for AES Security
              if (session[:user_id]==nil)
                  flash[:notice]="Your session has expired. Please login again."
                  redirect_to :controller=>'login', :action=>'login'
              else
                  if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                        @enddate=(Time.now-86400).strftime("%d-%b-%Y")
                        @startdate= (Time.now-86400).strftime("%d-%b-%Y")
                        @countrynameHash={"NA.AG"=>"Antigua and Barbuda","NA.BS"=>"Bahamas","NA.BB"=>"Barbados","CA.BZ"=>"Belize","NA.CA"=>"Canada","CA.CR"=>"Costa Rica","NA.CU"=>"Cuba","NA.DM"=>"Dominica","NA.DO"=>"Dominican Rep.","CA.SV"=>"El Salvador","NA.GD"=>"Grenada","CA.GT"=>"Guatemala","NA.HT"=>"Haiti","CA.HN"=>"Honduras","NA.JM"=>"Jamaica","NA.MX"=>"Mexico","CA.NI"=>"Nicaragua","CA.PA"=>"Panama","NA.KN"=>"St. Kitts & Nevis","NA.LC"=>"St. Lucia","NA.VC"=>"St. Vincent & the Grenadines","NA.TT"=>"Trinidad & Tobago","NA.US"=>"United States","NA.GL"=>"Greenland","SA.AR"=>"Argentina","SA.BO"=>"Bolivia","SA.BR"=>"Brazil","SA.CL"=>"Chile","SA.CO"=>"Colombia","SA.EC"=>"Ecuador","SA.FK"=>"Falkland Islands","SA.GF"=>"French Guiana","SA.GY"=>"Guyana","SA.PY"=>"Paraguay","SA.PE"=>"Peru","SA.SR"=>"Suriname","SA.UY"=>"Uruguay","SA.VE"=>"Venezuela","AF.DZ"=>"Algeria","AF.AO"=>"Angola","AF.BJ"=>"Benin","AF.BW"=>"Botswana","AF.BF"=>"Burkina Faso","AF.BI"=>"Burundi","AF.CM"=>"Cameroon","AF.CV"=>"Cape Verde","AF.CF"=>"Central African Republic","AF.TD"=>"Chad","AF.KM"=>"Comoros","AF.CI"=>"Cote d Ivoire","AF.CD"=>"Democratic Republic of the Congo","AF.DJ"=>"Djibouti","AF.EG"=>"Egypt","AF.GQ"=>"Equatorial Guinea","AF.ER"=>"Eritrea","AF.ET"=>"Ethiopia","AF.GA"=>"Gabon","AF.GH"=>"Ghana","AF.GN"=>"Guinea","AF.GW"=>"Guinea-Bissau","AF.KE"=>"Kenya","AF.LS"=>"Lesotho","AF.LR"=>"Liberia","AF.LY"=>"Libya","AF.MG"=>"Madagascar","AF.MW"=>"Malawi","AF.ML"=>"Mali","AF.MR"=>"Mauritania","AF.MA"=>"Morocco","AF.MZ"=>"Mozambique","AF.NA"=>"Namibia","AF.NE"=>"Niger","AF.NG"=>"Nigeria","AF.RW"=>"Rwanda","AF.ST"=>"Sao Tome and Principe","AF.SN"=>"Senegal","AF.SL"=>"Sierra Leone","AF.SO"=>"Somalia","AF.ZA"=>"South Africa","AF.SD"=>"Sudan","AF.SZ"=>"Swaziland","AF.TZ"=>"Tanzania","AF.TG"=>"Togo","AF.TN"=>"Tunisia","AF.UG"=>"Uganda","AF.ZM"=>"Zambia","AF.ZW"=>"Zimbabwe","AF.GM"=>"Gambia","AF.CG"=>"Congo","AF.MU"=>"Mauritius","AS.AF"=>"Afghanistan","AS.AM"=>"Armenia","AS.AZ"=>"Azerbaijan","AS.BD"=>"Bangladesh","AS.BT"=>"Bhutan","AS.BN"=>"Brunei","AS.MM"=>"Burma (Myanmar)","AS.KH"=>"Cambodia","AS.CN"=>"China","AS.TP"=>"East Timor","AS.GE"=>"Georgia","AS.IN"=>"India","AS.ID"=>"Indonesia","ME.IR"=>"Iran","AS.JP"=>"Japan","AS.KZ"=>"Kazakhstan","AS.KR"=>"Korea - South","AS.KG"=>"Kyrgyzstan","AS.LA"=>"Laos","AS.MY"=>"Malaysia","AS.MN"=>"Mongolia","AS.NP"=>"Nepal","AS.PK"=>"Pakistan","AS.PH"=>"Philippines","AS.RU"=>"Russian Federation","AS.SG"=>"Singapore","AS.LK"=>"Sri Lanka","AS.TJ"=>"Tajikistan","AS.TH"=>"Thailand","AS.TM"=>"Turkmenistan","AS.UZ"=>"Uzbekistan","AS.VN"=>"Vietnam","AS.TW"=>"Taiwan","AS.HK"=>"Hong Kong","AS.MO"=>"Macau","EU.AL"=>"Albania","EU.AD"=>"Andorra","EU.AT"=>"Austria","EU.BY"=>"Belarus","EU.BE"=>"Belgium","EU.BA"=>"Bosnia and Herzegovina","EU.BG"=>"Bulgaria","EU.HR"=>"Croatia","EU.CZ"=>"Czech Republic","EU.DK"=>"Denmark","EU.EE"=>"Estonia","EU.FI"=>"Finland","EU.FR"=>"France","EU.DE"=>"Germany","EU.GR"=>"Greece","EU.HU"=>"Hungary","EU.IS"=>"Iceland","EU.IE"=>"Ireland","EU.IT"=>"Italy","EU.LV"=>"Latvia","EU.LI"=>"Liechtenstein","EU.LT"=>"Lithuania","EU.LU"=>"Luxembourg","EU.MK"=>"Macedonia","EU.MT"=>"Malta","EU.MD"=>"Moldova","EU.MC"=>"Monaco","EU.MO"=>"Montenegro","EU.NL"=>"Netherlands","EU.NO"=>"Norway","EU.PL"=>"Poland","EU.PT"=>"Portugal","EU.RO"=>"Romania","EU.SM"=>"San Marino","EU.CS"=>"Serbia","EU.SK"=>"Slovakia","EU.SI"=>"Slovenia","EU.ES"=>"Spain","EU.SE"=>"Sweden","EU.CH"=>"Switzerland","EU.UA"=>"Ukraine","EU.UK"=>"United Kingdom","EU.VA"=>"Vatican City","EU.CY"=>"Cyprus","EU.TR"=>"Turkey","EU.RU"=>"Russia","OC.AU"=>"Australia","OC.FJ"=>"Fiji","OC.KI"=>"Kiribati","OC.MH"=>"Marshall Islands","OC.FM"=>"Micronesia","OC.NR"=>"Nauru","OC.NZ"=>"New Zealand","OC.PW"=>"Palau","OC.PG"=>"Papua New Guinea","OC.WS"=>"Samoa","OC.SB"=>"Solomon Islands","OC.TO"=>"Tonga","OC.TV"=>"Tuvalu","OC.VU"=>"Vanuatu","OC.NC"=>"New Caledonia","ME.BH"=>"Bahrain","ME.IQ"=>"Iraq","ME.IL"=>"Israel","ME.JO"=>"Jordan","ME.KW"=>"Kuwait","ME.LB"=>"Lebanon","ME.OM"=>"Oman","ME.QA"=>"Qatar","ME.SA"=>"Saudi Arabia","ME.SY"=>"Syria","ME.AE"=>"UnitedArabEmirates","ME.YE"=>"Yemen","NA.PR"=>"Puerto Rico","NA.KY"=>"Cayman Islands","AF.YT"=>"Mayotte","AF.RE"=>"Reunion","AQ.AQ"=>"Antarctica","AS.MV"=>"Maldives","EU.AX"=>"Aland Islands","EU.GI"=>"Gibraltar","EU.FO"=>"Faroe Islands","NA.BM"=>"Bermuda","NA.TC"=>"Turks and Caicos Islands","NA.AI"=>"Anguilla","NA.MS"=>"Montserrat","NA.VI"=>"Virgin Islands - British","NA.GP"=>"Guadeloupe","NA.AW"=>"Aruba","NA.AN"=>"Netherlands Antilles","NA.MQ"=>"Martinique","OC.MP"=>"Northern Mariana Islands","OC.CK"=>"Cook Islands","OC.GU"=>"Guam","OC.PF"=>"French Polynesia","OC.NU"=>"Niue","OC.NF"=>"Norfolk Island","OC.UM"=>"United States Minor Outlying Islands","OC.TK"=>"Tokelau","OC.AS"=>"American Samoa","EU.GB"=>"United Kingdom","EU.JE"=>"Jersey","AF.SC"=>"Seycelles","AS.KP"=>"Korea - North","AS.PS"=>"Palestinian Territory","AS.IO"=>"British Indian Ocean Territory","CA.PM"=>"Saint Pierre and Miquelon","NA.VG"=>"Virgin Islands"}
                        @countrycodeHash={"NAMIBIA"=>"NA-AF","ZIMBABWE"=>"ZW-AF","KENYA"=>"KE-AF","TOGO"=>"TG-AF","EQUATORIAL GUINEA"=>"GQ-AF","RWANDA"=>"RW-AF","BENIN"=>"BJ-AF","BOTSWANA"=>"BW-AF","COMOROS"=>"KM-AF","LIBYAN ARAB JAMAHIRIYA"=>"LY-AF","CENTRAL AFRICAN REPUBLIC"=>"CF-AF","MAYOTTE"=>"YT-AF","ERITREA"=>"ER-AF","ALGERIA"=>"DZ-AF","MADAGASCAR"=>"MG-AF","CONGO"=>"CG-AF","ANGOLA"=>"AO-AF","SUDAN"=>"SD-AF","GAMBIA"=>"GM-AF","CHAD"=>"TD-AF","DJIBOUTI"=>"DJ-AF","MAURITANIA"=>"MR-AF","MALAWI"=>"MW-AF","LIBERIA"=>"LR-AF","MALI"=>"ML-AF","SENEGAL"=>"SN-AF","TUNISIA"=>"TN-AF","BURUNDI"=>"BI-AF","SAO TOME AND PRINCIPE"=>"ST-AF","SOUTH AFRICA"=>"ZA-AF","MAURITIUS"=>"MU-AF","TANZANIA, UNITED REPUBLIC OF"=>"TZ-AF","UGANDA"=>"UG-AF","ZAMBIA"=>"ZM-AF","BURKINA FASO"=>"BF-AF","SOMALIA"=>"SO-AF","GUINEA-BISSAU"=>"GW-AF","MOROCCO"=>"MA-AF","COTE D IVOIRE"=>"CI-AF","MOZAMBIQUE"=>"MZ-AF","SEYCHELLES"=>"SC-AF","SWAZILAND"=>"SZ-AF","ETHIOPIA"=>"ET-AF","NIGERIA"=>"NG-AF","GHANA"=>"GH-AF","CAMEROON"=>"CM-AF","LESOTHO"=>"LS-AF","REUNION"=>"RE-AF","GABON"=>"GA-AF","CONGO, THE DEMOCRATIC REPUBLIC OF THE"=>"CD-AF","NIGER"=>"NE-AF","SIERRA LEONE"=>"SL-AF","CAPE VERDE"=>"CV-AF","GUINEA"=>"GN-AF","ANTARCTICA"=>"AQ-AQ","CHINA"=>"CN-AS","PHILIPPINES"=>"PH-AS","BANGLADESH"=>"BD-AS","ARMENIA"=>"AM-AS","MYANMAR"=>"MM-AS","PALESTINIAN TERRITORY, OCCUPIED"=>"PS-AS","BRITISH INDIAN OCEAN TERRITORY"=>"IO-AS","SINGAPORE"=>"SG-AS","INDONESIA"=>"ID-AS","BHUTAN"=>"BT-AS","INDIA"=>"IN-AS","MALAYSIA"=>"MY-AS","JAPAN"=>"JP-AS","TAIWAN, PROVINCE OF CHINA"=>"TW-AS","AFGHANISTAN"=>"AF-AS","CYPRUS"=>"CY-EU","NEPAL"=>"NP-AS","KOREA"=>"KR-AS","VIET NAM"=>"VN-AS","CAMBODIA"=>"KH-AS","SRI LANKA"=>"LK-AS","TAJIKISTAN"=>"TJ-AS","AZERBAIJAN"=>"AZ-AS","KYRGYZSTAN"=>"KG-AS","TURKMENISTAN"=>"TM-AS","THAILAND"=>"TH-AS","UZBEKISTAN"=>"UZ-AS","KAZAKHSTAN"=>"KZ-AS","MONGOLIA"=>"MN-AS","LAO PEOPLES DEMOCRATIC REPUBLIC"=>"LA-AS","MALDIVES"=>"MV-AS","HONG KONG"=>"HK-AS","PAKISTAN"=>"PK-AS","BRUNEI DARUSSALAM"=>"BN-AS","MACAO"=>"MO-AS","GUATEMALA"=>"GT-CA","BELIZE"=>"BZ-CA","HONDURAS"=>"HN-CA","EL SALVADOR"=>"SV-CA","PANAMA"=>"PA-CA","COSTA RICA"=>"CR-CA","NICARAGUA"=>"NI-CA","PUERTO RICO"=>"PR-NA","BAHAMAS"=>"BS-NA","TURKS AND CAICOS ISLANDS"=>"TC-NA","GRENADA"=>"GD-NA","ANGUILLA"=>"AI-NA","CUBA"=>"CU-NA","DOMINICA"=>"DM-NA","CAYMAN ISLANDS"=>"KY-NA","TRINIDAD AND TOBAGO"=>"TT-NA","MONTSERRAT"=>"MS-NA","DOMINICAN REPUBLIC"=>"DO-NA","BARBADOS"=>"BB-NA","SAINT KITTS AND NEVIS"=>"KN-NA","HAITI"=>"HT-NA","JAMAICA"=>"JM-NA","VIRGIN ISLANDS"=>"VI-NA","SAINT VINCENT AND THE GRENADINES"=>"VC-NA","ANTIGUA AND BARBUDA"=>"AG-NA","BERMUDA"=>"BM-NA","GUADELOUPE"=>"GP-NA","ARUBA"=>"AW-NA","VIRGIN ISLANDS, U.S."=>"VG-NA","NETHERLANDS ANTILLES"=>"AN-NA","MARTINIQUE"=>"MQ-NA","SAINT LUCIA"=>"LC-NA","SPAIN"=>"ES-EU","NORWAY"=>"NO-EU","HOLY SEE (VATICAN CITY STATE)"=>"VA-EU","MONTENEGRO"=>"MO-EU","SLOVAKIA"=>"SK-EU","SWEDEN"=>"SE-EU","FRANCE"=>"FR-EU","AUSTRIA"=>"AT-EU","ALAND ISLANDS"=>"AX-EU","ALBANIA"=>"AL-EU","MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF"=>"MK-EU","UNITED KINGDOM"=>"GB-EU","ITALY"=>"IT-EU","MALTA"=>"MT-EU","CROATIA"=>"HR-EU","MOLDOVA, REPUBLIC OF"=>"MD-EU","LITHUANIA"=>"LT-EU","SWITZERLAND"=>"CH-EU","BOSNIA AND HERZEGOVINA"=>"BA-EU","UKRAINE"=>"UA-EU","BULGARIA"=>"BG-EU","ROMANIA"=>"RO-EU","GIBRALTAR"=>"GI-EU","FAROE ISLANDS"=>"FO-EU","FINLAND"=>"FI-EU","CZECH REPUBLIC"=>"CZ-EU","SLOVENIA"=>"SI-EU","ICELAND"=>"IS-EU","IRELAND"=>"IE-EU","DENMARK"=>"DK-EU","POLAND"=>"PL-EU","TURKEY"=>"TR-EU","GREECE"=>"GR-EU","GEORGIA"=>"GE-AS","LATVIA"=>"LV-EU","NETHERLANDS"=>"NL-EU","BELGIUM"=>"BE-EU","PORTUGAL"=>"PT-EU","MONACO"=>"MC-EU","HUNGARY"=>"HU-EU","BELARUS"=>"BY-EU","LIECHTENSTEIN"=>"LI-EU","GERMANY"=>"DE-EU","RUSSIAN FEDERATION"=>"RU-EU","LUXEMBOURG"=>"LU-EU","SAN MARINO"=>"SM-EU","ESTONIA"=>"EE-EU","ANDORRA"=>"AD-EU","UNITED ARAB EMIRATES"=>"AE-ME","LEBANON"=>"LB-ME","JORDAN"=>"JO-ME","IRAN, ISLAMIC REPUBLIC OF"=>"IR-ME","EGYPT"=>"EG-AF","BAHRAIN"=>"BH-ME","YEMEN"=>"YE-ME","ISRAEL"=>"IL-ME","OMAN"=>"OM-ME","SAUDI ARABIA"=>"SA-ME","QATAR"=>"QA-ME","SYRIAN ARAB REPUBLIC"=>"SY-ME","KUWAIT"=>"KW-ME","IRAQ"=>"IQ-ME","UNITED STATES"=>"US-NA","GREENLAND"=>"GL-NA","CANADA"=>"CA-NA","MEXICO"=>"MX-NA","NORTHERN MARIANA ISLANDS"=>"MP-OC","NEW ZEALAND"=>"NZ-OC","PALAU"=>"PW-OC","NIUE"=>"NU-OC","SAMOA"=>"WS-OC","TOKELAU"=>"TK-OC","AUSTRALIA"=>"AU-OC","COOK ISLANDS"=>"CK-OC","NORFOLK ISLAND"=>"NF-OC","AMERICAN SAMOA"=>"AS-OC","PAPUA NEW GUINEA"=>"PG-OC","SOLOMON ISLANDS"=>"SB-OC","NAURU"=>"NR-OC","FIJI"=>"FJ-OC","VANUATU"=>"VU-OC","TUVALU"=>"TV-OC","UNITED STATES MINOR OUTLYING ISLANDS"=>"UM-OC","GUAM"=>"GU-OC","NEW CALEDONIA"=>"NC-OC","MICRONESIA, FEDERATED STATES OF"=>"FM-OC","MARSHALL ISLANDS"=>"MH-OC","KIRIBATI"=>"KI-OC","FRENCH POLYNESIA"=>"PF-OC","TONGA"=>"TO-OC","VENEZUELA"=>"VE-SA","FRENCH GUIANA"=>"GF-SA","GUYANA"=>"GY-SA","PARAGUAY"=>"PY-SA","FALKLAND ISLANDS (MALVINAS)"=>"FK-SA","SURINAME"=>"SR-SA","PERU"=>"PE-SA","BOLIVIA"=>"BO-SA","BRAZIL"=>"BR-SA","COLOMBIA"=>"CO-SA","ARGENTINA"=>"AR-SA","CHILE"=>"CL-SA","ECUADOR"=>"EC-SA","URUGUAY"=>"UY-SA","LAO PEOPLES DEMOCRATIC REPUBLIC
"=>"LA-AS","East Timor"=>"TP-AS","SERBIA"=>"CS-EU","KOREA - NORTH"=>"KP-AS","SAINT PIERRE AND MIQUELON"=>"PM-CA","JERSEY"=>"JE-EU"}
                        session[:adminstart_on] = (params[:adminstart_on]!=nil && params[:adminstart_on]!="") ? params[:adminstart_on] : (session[:adminstart_on]!=nil && session[:adminstart_on]!='') ? session[:adminstart_on] : @startdate 
                        session[:adminend_on] = (params[:adminend_on]!=nil && params[:adminend_on]!="") ? params[:adminend_on] : (session[:adminend_on]!=nil && session[:adminend_on]!='') ? session[:adminend_on] : @enddate 
                        session[:duration]=(params[:duration]!=nil && params[:duration]!="") ? params[:duration] : (session[:duration]!=nil && session[:duration]!='') ? session[:duration] : 1 
                        session[:pub_name]=params[:publisher]['publisher_name'] if (params[:page]==nil and params[:publisher]!=nil)
                        session[:country_name]=params[:analytics_country_list]['country_name'] if (params[:page]==nil and params[:analytics_country_list]!=nil)
                        verifyDBconnection
                        if session[:pub_name]!=nil and session[:pub_name]!=""
                            if session[:pub_name].downcase=='all'
                                getPubId='All'
                            else
                                @publishers=Publisher.find_by_sql("select id from publishers where publisher_name='#{session[:pub_name]}' and status!='Deleted'")
                                if @publishers!=nil
                                    if @publishers.size>0
                                      getPubId=@publishers[0].id
                                    else
                                      getPubId=0
                                    end
                                else
                                  getPubId=0
                                end
                            end
                        else
                            getPubId='All'
                        end
                        @pub_details=AnalyticsData.publisher_data_get()
                        if @pub_details==nil or @pub_details==""
                            @pub_details= get_publisher_detail()
                            AnalyticsData.publisher_data_set(@pub_details)
                        end 
                        pub_id= (getPubId=='All' || getPubId==nil || getPubId=='') ? "" : " and pub_id='#{getPubId}'"
                        country=(session[:country_name]==nil or session[:country_name]=='') ? "" : "#{(@countrycodeHash[session[:country_name].to_s]==nil or @countrycodeHash[session[:country_name].to_s]=='') ? '' : "and country_code='#{@countrycodeHash[session[:country_name].to_s].split('-')[0]}' and continent_code='#{@countrycodeHash[session[:country_name].to_s].split('-')[1]}'"}"
                        sql="select pub_id,client_id,country_code,continent_code,(sum(fill_rate)+sum(impressions)) as traffic_acquired,sum(impressions) as traffic_delivered,sum(fill_rate) as fillrate, (sum(impressions)/(sum(fill_rate)+sum(impressions)))*100 as fr_percentage from pub_geolocations where delivery_date>='#{(Time.parse(session[:adminstart_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse( session[:adminend_on] )).strftime("%Y-%m-%d")} 23:59:59' and (impressions>0 or fill_rate>0) #{pub_id} #{country} group by client_id,continent_code,country_code order by traffic_acquired desc"
                        @fillrate_pages, @fillrate = paginate_by_sql AdclientsSummary,sql,100
                  else
                        flash[:notice]="Your are not an authorized user. Please login with different username."
                        redirect_to :controller=>'login'
                  end
              end
        rescue Exception=>e
            puts "DEBUG :: ERROR :: in advertiser_analytic_controller - admin_fillrate method Exception :: #{e.to_s}"
            render :action=>'admin_fillrate'
        end
    end
    
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#Method Name: verifyDBconnection
	#Purpose: to check whether activeRecord connection is active or not. if not active then reconnect to db.
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
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#Method Name: autosuggest
	#Purpose: to search publishers
	#Version: 1.0
	#Author: Md Shujauddeen A
	#Last Modified: 31-Aug-2009 by Md Shujauddeen A
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 def autosuggest
      begin
          resource=params[:resource]
          pub_id=params[:pub_id]
          verifyDBconnection
          #~ if resource=='admin_fillrate'
              #~ @entities=Publisher.find_by_sql("select u.username as pub_name from publishers p, users u where u.status='Active' and u.id=p.user_id")
              #~ render :action=>'admin_fillrate.rxml',:layout=>false
          if resource=='advertiser_traffic_growth'
              @entities=Advertiser.find_by_sql("select u.username as adv_name from advertisers a, users u where u.status='Active' and u.id=a.user_id")
              render :action=>'advertiser_traffic_growth.rxml',:layout=>false
          elsif resource=='publisher_traffic_growth'
              @entities=Publisher.find_by_sql("select u.username as pub_name from publishers p, users u where u.status='Active' and u.id=p.user_id")
              render :action=>'publisher_traffic_growth.rxml',:layout=>false
          elsif resource=='devices_summary'
              @entities=User.find_by_sql("select * from analytics_country_list")
              render :action=>'country_list.rxml',:layout=>false
          end    
      rescue Exception=>e
          puts "ERROR :: Exception in admin_analytics controller :: autosuggest :: #{e.to_s}"
      end
  end
  
  #-------------------------------NEW REQUIREMENTS----------------------------------
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Method Name: owner_popup
  #Purpose: this method is used to fetch wifi unfilled details.
  #Version: 2.3 
  #Author: Subaida/Mangai
  #Last Modified: 30-Sep-2010 by Shujauddeen
  #Notes: None
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  def wifi_traffic
      begin
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                  @mongo_datepicker=true
                  @delivery_time= (params[:search_date]==nil || params[:search_date]=="") ? Time.now.strftime("%d-%b-%Y") : params[:search_date]
                  @camp_name=params['campaign_name']
                  @pub_name=params['publisher_name']
                  publisher=Publisher.find_by_publisher_name(@pub_name) if @pub_name!='' and @pub_name!=nil
                  @limit=(params[:limit]==nil ||  params[:limit]=='') ? 0 : params[:limit].to_i
                  @offset=(params[:offset]==nil ||  params[:offset]=='') ? (params[:show]==nil ||  params[:show]=='') ? 100 : params[:show].to_i  : params[:offset].to_i
                  #form conditional statement for mongodb
                  search=Hash.new
                  search.store("delivery_time","#{Time.parse(@delivery_time).strftime("%Y-%m-%d")}") if @delivery_time!=nil and @delivery_time!=''
                  search.store("pub_id","#{publisher.id}") if publisher !=nil and publisher !=''
                  search.store("campaign_name","#{@camp_name}") if @camp_name!=nil and@camp_name!=''
                  #open mongodb connection
                  db  = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
                  coll = db.collection('wifi_summaries')
                  @wifi=coll.find(search).sort([:unfilled ,Mongo::DESCENDING]).skip(@limit).limit(@offset)
                  @max_limit=@wifi.count
                  #for manual pagination
                  @paginate_url = "/admin_analytic/wifi_traffic?campaign_name=#{@camp_name}&publisher_name=#{@pub_name}&search_date=#{@delivery_time}"
              else
                    flash[:notice]="Your are not an authorized user. Please login with different username."
                    redirect_to :controller=>'login'
              end
          end
      rescue Exception=>e
          puts "ERROR :: Exception in admin_analytics controller :: wifi_traffic :: #{e.to_s}"
      end
    end
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Method Name: wifi_traffic_search
  #Purpose: this method is used to fetch wifi unfilled details with search parameter.
  #Version: 2.3 
  #Author: Shujauddeen/Mangai/Subaida
  #Last Modified: 30-Sep-2010 by Shujauddeen
  #Notes: None
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  def wifi_traffic_search
      begin
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                  @mongo_datepicker=true
                  @delivery_time= (params[:search_date]==nil || params[:search_date]=="") ? Time.now.strftime("%d-%b-%Y") : params[:search_date]
                  @camp_name=params[:campaign]['campaign_name']
                  @pub_name=params[:publisher]['publisher_name']
                  @limit=(params[:limit]==nil ||  params[:limit]=='') ? 0 : params[:limit].to_i
                  @offset=(params[:offset]==nil ||  params[:offset]=='') ? (params[:show]==nil ||  params[:show]=='') ? 100 : params[:show].to_i  : params[:offset].to_i
                  publisher=Publisher.find_by_publisher_name(@pub_name) if @pub_name!='' and @pub_name!=nil
                  #form conditional statement for mongodb
                  search=Hash.new
                  search.store("delivery_time","#{Time.parse(@delivery_time).strftime("%Y-%m-%d")}") if @delivery_time!=nil and @delivery_time!=''
                  search.store("pub_id","#{publisher.id}") if publisher!=nil and publisher!=''
                  search.store("campaign_name","#{@camp_name}") if @camp_name !=nil and @camp_name !=''
                  #open mongodb connection
                  db  = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
                  coll = db.collection('wifi_summaries')
                  @wifi=coll.find(search).sort([:unfilled ,Mongo::DESCENDING]).skip(@limit).limit(@offset)
                  @max_limit=@wifi.count
                  #for manual pagination
                  @paginate_url = "/admin_analytic/wifi_traffic?campaign_name=#{@camp_name}&publisher_name=#{@pub_name}&search_date=#{@delivery_time}"
                  render :action=>"wifi_traffic"
              else
                  flash[:notice]="Your are not an authorized user. Please login with different username."
                  redirect_to :controller=>'login'
              end
          end
      rescue Exception=>e
          puts "ERROR :: Exception in admin_analytics controller :: wifi_traffic_search :: #{e.to_s}"
      end
  end
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Method Name: fraud_click
  #Purpose: this method is used to fetch fraud_click details.
  #Version: 2.3 
  #Author: Shujauddeen/Mangai
  #Last Modified: 30-Sep-2010 by Shujauddeen
  #Notes: None
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  
  def fraud_click
      begin
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                  @mongo_datepicker=true
                  @delivery_time= (params[:search_date]==nil || params[:search_date]=="") ? Time.now.strftime("%d-%b-%Y") : params[:search_date]
                  @camp_name=params['campaign_name']
                  @pub_name=params['publisher_name']
                  campaign=Campaign.find_by_campaign_name(@camp_name) if @camp_name!='' and @camp_name!=nil
                  publisher=Publisher.find_by_publisher_name(@pub_name) if @pub_name!='' and @pub_name!=nil
                  @limit=(params[:limit]==nil ||  params[:limit]=='') ? 0 : params[:limit].to_i
                  #~ @offset=(params[:offset]==nil ||  params[:offset]=='') ? 10 : params[:offset].to_i
                  @offset=(params[:offset]==nil ||  params[:offset]=='') ? (params[:show]==nil ||  params[:show]=='') ? 100 : params[:show].to_i  : params[:offset].to_i
                  search=Hash.new
                  #form conditional statement for mongodb
                  search.store("delivery_time","#{Time.parse(@delivery_time).strftime("%Y-%m-%d")}") if @delivery_time!=nil and @delivery_time!=''
                  search.store("pub_id","#{publisher.id}") if publisher!=nil and publisher!=''
                  search.store("campaign_id","#{campaign.id}") if campaign!=nil and campaign!=''
                  #open mongodb connection
                  db   = Mongo::Connection.new("192.168.0.15", 27017).db("zestadz_analytics_db")
                  puts "mongodb is started "
                  coll = db.collection('fraud_clicks')
                  @fraud_clicks=coll.find(search).sort([:fraud_click ,Mongo::DESCENDING]).skip(@limit).limit(@offset)
                  @max_limit=@fraud_clicks.count()
                  @sum_fc||=coll.group(['delivery_time'], search, {'fraud_click' => 0,'bid'=>0},  "function(obj, prev) {prev.bid += parseFloat(obj.bid)*obj.fraud_click; prev.fraud_click += obj.fraud_click}")
                  #for manual pagination
                  @paginate_url = "/admin_analytic/fraud_click?campaign_name=#{@camp_name}&publisher_name=#{@pub_name}&search_date=#{@delivery_time}"
              else
                  flash[:notice]="Your are not an authorized user. Please login with different username."
                  redirect_to :controller=>'login'
              end
          end
      rescue Exception=>e
          puts "Error : /admin_analytic_controller/fraud_click : #{e.to_s}"
      end
  end
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Method Name: fraud_click_search
  #Purpose: this method is used to fetch fraud_click details with search parameter.
  #Version: 2.3 
  #Author: Shujauddeen/Mangai
  #Last Modified: 30-Sep-2010 by Shujauddeen
  #Notes: None
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------    
  def fraud_click_search
      begin
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                  @mongo_datepicker=true
                  @delivery_time= (params[:search_date]==nil || params[:search_date]=="") ? Time.now.strftime("%d-%b-%Y") : params[:search_date]
                  @camp_name=params[:campaign]['campaign_name']
                  @pub_name=params[:publisher]['publisher_name']
                  @limit=(params[:limit]==nil ||  params[:limit]=='') ? 0 : params[:limit].to_i
                  @offset=(params[:offset]==nil ||  params[:offset]=='') ? (params[:show]==nil ||  params[:show]=='') ? 100 : params[:show].to_i  : params[:offset].to_i
                  campaign=Campaign.find_by_campaign_name(@camp_name) if @camp_name!='' and @camp_name!=nil
                  publisher=Publisher.find_by_publisher_name(@pub_name) if @pub_name!='' and @pub_name!=nil
                  search=Hash.new
                  #form conditional statement for mongodb
                  search.store("delivery_time","#{Time.parse(@delivery_time).strftime("%Y-%m-%d")}") if @delivery_time!=nil and @delivery_time!=''
                  search.store("pub_id","#{publisher.id}") if publisher!=nil and publisher!=''
                  search.store("campaign_id","#{campaign.id}") if campaign!=nil and campaign!=''
                  #open mongodb connection
                  db   = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
                  coll = db.collection('fraud_clicks')
                  @fraud_clicks=coll.find(search).sort([:fraud_click ,Mongo::DESCENDING]).skip(@limit).limit(@offset)
                  @max_limit=@fraud_clicks.count()
                  #~ @sum_fc||=coll.group(['delivery_time'], {"delivery_time" => "#{Time.parse(@delivery_time).strftime("%Y-%m-%d")}" }, {'fraud_click' => 0,'bid'=>0},  "function(obj, prev) { prev.fraud_click += obj.fraud_click;prev.bid += obj.bid}")
                  @sum_fc=coll.group(['delivery_time'], search, {'bid'=>0,'fraud_click' => 0},  "function(obj, prev) {prev.bid += parseFloat(obj.bid)*obj.fraud_click; prev.fraud_click += obj.fraud_click}")
                  #for manual pagination
                  @paginate_url = "/admin_analytic/fraud_click?campaign_name=#{@camp_name}&publisher_name=#{@pub_name}&search_date=#{@delivery_time}"
                  render :action=>"fraud_click"
              else
                  flash[:notice]="Your are not an authorized user. Please login with different username."
                  redirect_to :controller=>'login'
              end
          end
      rescue Exception=>e
          puts "Error : /admin_analytic_controller/fraud_click_search : #{e.to_s}"
      end
  end
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Method Name: owner_report
  #Purpose: its to update the carrier
  #Version: 2.3 
  #Author: Prabhu C
  #Last Modified: 29-Sep-2010 by Prabhu
  #Notes: None
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  def owner_report
      begin
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                  @mongo_datepicker=true
                  @delivery_time= (params[:search_date]==nil || params[:search_date]=="") ? Time.now.strftime("%d-%b-%Y") : params[:search_date]
                  @country_name=params['country_name']
                  @owner_name=params['carrier']
                  @check_owner=(params[:check_owner]==nil ||params[:check_owner]=='') ? 'all': params[:check_owner]
                  search=Hash.new
                  search.store("delivery_time","#{Time.parse(@delivery_time).strftime("%Y-%m-%d")}") if @delivery_time!=nil and @delivery_time!=''
                  search.store("country_name","#{@country_name}") if @country_name!=nil and @country_name!=''
                  search.store("owner_name","#{@owner_name}") if @owner_name!=nil and @owner_name!=''
                  search.store("carrier_name","Unknown") if @check_owner=='unrecognized_owner'
                  @limit=(params[:limit]==nil ||  params[:limit]=='') ? 0 : params[:limit].to_i
                  @offset=(params[:offset]==nil ||  params[:offset]=='') ? (params[:show]==nil ||  params[:show]=='') ? 100 : params[:show].to_i  : params[:offset].to_i
                  db  = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
                  coll = db.collection('owner_summaries')
                  @owners=coll.find(search).sort([:impressions ,Mongo::DESCENDING]).skip(@limit).limit(@offset)
                  @max_limit=@owners.count()
                  @paginate_url = "/admin_analytic/owner_report?country_name=#{@country_name}&carrier=#{@owner_name}&search_date=#{@delivery_time}&check_owner=#{@check_owner}"
              else
                    flash[:notice]="Your are not an authorized user. Please login with different username."
                    redirect_to :controller=>'login'
              end
          end
        rescue Exception=>e
          puts "Error : /admin_analytic_controller/owner_report : #{e.to_s}"
      end
    end
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Method Name: owner_report_search
  #Purpose: its to update the carrier
  #Version: 2.3 
  #Author: Prabhu C
  #Last Modified: 29-Sep-2010 by Prabhu
  #Notes: None
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  def owner_report_search
    begin
        @aes = AESSecurity.new() #creating an object for AES Security
        if (session[:user_id]==nil)
            flash[:notice]="Your session has expired. Please login again."
            redirect_to :controller=>'login', :action=>'login'
        else
            if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                @mongo_datepicker=true
                @delivery_time= (params[:search_date]==nil || params[:search_date]=="") ? Time.now.strftime("%d-%b-%Y") : params[:search_date]
                @country_name=params[:analytics_country_list]['country_name']
                @owner_name=params[:owner]['carrier']
                @limit=(params[:limit]==nil ||  params[:limit]=='') ? 0 : params[:limit].to_i
                @offset=(params[:offset]==nil ||  params[:offset]=='') ? (params[:show]==nil ||  params[:show]=='') ? 100 : params[:show].to_i  : params[:offset].to_i
                @check_owner=params[:unrecognized_owner]
                search=Hash.new
                search.store("delivery_time","#{Time.parse(@delivery_time).strftime("%Y-%m-%d")}") if @delivery_time!=nil and @delivery_time!=''
                search.store("country_name","#{@country_name}") if @country_name!=nil and @country_name!=''
                search.store("owner_name","#{@owner_name}") if @owner_name!=nil and @owner_name!=''
                search.store("carrier_name","Unknown") if @check_owner=='unrecognized_owner'
                db   = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
                coll = db.collection('owner_summaries')
                @owners=coll.find(search).sort([:impressions ,Mongo::DESCENDING]).skip(@limit).limit(@offset)
                @max_limit=@owners.count()
                @paginate_url = "/admin_analytic/owner_report?country_name=#{@country_name}&carrier=#{@owner_name}&search_date=#{@delivery_time}&check_owner=#{@check_owner}"
                render :action=>"owner_report"
            else
                flash[:notice]="Your are not an authorized user. Please login with different username."
                redirect_to :controller=>'login'
            end
        end
      rescue Exception=>e
          puts "Error : /admin_analytic_controller/owner_report_search : #{e.to_s}"
      end
  end
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Method Name: owner_popup
  #Purpose: its to update the carrier
  #Version: 2.3 
  #Author: Prabhu C
  #Last Modified: 29-Sep-2010 by Shujauddeen
  #Notes: None
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    def owner_popup
        begin   
            @aes = AESSecurity.new() #creating an object for AES Security
            if (session[:user_id]==nil)
                flash[:notice]="Your session has expired. Please login again."
                redirect_to :controller=>'login', :action=>'login'
            else
                if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                    #stores the parms of owner and carrier_name     
                    @mongo_datepicker=true
                    carrier_name=params[:carrier_name]
                    @paginate_url=params[:paginate_url]
                    @owner_name=owner_name=params[:owner]
                    @country_name=params[:country_name]
                    @impressions=params[:impressions]
                    @limit=params[:limit]
                    @offset=params[:offset]
                    #connecting to the mongo db server
                    db   = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
                    coll = db.collection('owner_summaries')
                    #this condition become true when the owner_name and carrier name is not blank
                    if params[:Submit]=='Submit'
                        if not owner_name.blank? and not carrier_name.blank? 
                            coll.update({"owner_name"=>owner_name},{"$set"=>{"carrier_name"=>carrier_name}},:multi=> true)                            
                            render :update do |page|    
                                page.redirect_to "owner_report?#{ @paginate_url.split('?')[1] }&limit=#{params[:limit]}&offset=#{params[:offset]}"#:controller=>'admin_analytic',:action=>'owner_report'
                            end
                        else
                            #come to this loop when the owner_name and carrier name is blank
                            flash[:notice]="Please enter a carrier name."
                            @page_str=render_component_as_string(:controller=>'admin_analytic',:action=>'owner_popup',:params=>{:owner=>@owner_name,:country_name=>@country_name,:impressions=>@impressions,:paginate_url=>@paginate_url,:limit=>params[:limit],:offset=>params[:offset]})
                            render :update do |page|
                                page.replace_html 'release_payment', @page_str
                            end                    
                        end
                    else
                        #come to this loop by default 
                        render :layout=>false
                    end
                else
                    flash[:notice]="Your are not an authorized user. Please login with different username."
                    redirect_to :controller=>'login'
                end
            end
        rescue Exception=>e
            puts "Error : /admin_analytic_controller/owner_popup : #{e.to_s}"
            flash[:notice]="An error occured while trying to Show popup."
        end     
    end
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Method Name: unfilled_ips
  #Purpose: this method is used to fetch unfilled_ips details.
  #Version: 2.3 
  #Author: Shujauddeen/Mangai
  #Last Modified: 30-Sep-2010 by Shujauddeen
  #Notes: None
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------        
  def unfilled_ips
      begin
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                  @mongo_datepicker=true
                  @delivery_time= (params[:search_date]==nil || params[:search_date]=="") ? Time.now.strftime("%d-%b-%Y") : params[:search_date]
                  @country_name=params[:country_name]
                  @pub_name=params[:publisher_name]
                  @limit=(params[:limit]==nil ||  params[:limit]=='') ? 0 : params[:limit].to_i
                  @offset=(params[:offset]==nil ||  params[:offset]=='') ? 10 : params[:offset].to_i
                  publisher=Publisher.find_by_publisher_name(@pub_name) if @pub_name!='' and @pub_name!=nil
                  search=Hash.new
                  #form conditional statement for mongodb
                  search.store("country_name","#{@country_name}") if @country_name!=nil and @country_name!=''
                  search.store("pub_id","#{publisher.id}") if publisher!=nil and publisher!=''
                  search.store("delivery_time","#{Time.parse(@delivery_time).strftime("%Y-%m-%d")}") if @delivery_time!=nil and @delivery_time!=''
                  #open mongodb connection
                  db  = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
                  coll = db.collection('unfilled_ips')
                  @unfilled_ips=coll.find(search).sort([:impressions ,Mongo::DESCENDING]).skip(@limit).limit(@offset)
                  @max_limit=@unfilled_ips.count()
                  #for manual pagination
                  @paginate_url = "/admin_analytic/unfilled_ips?country_name=#{@country_name}&publisher_name=#{@pub_name}&search_date=#{@delivery_time}"
              else
                  flash[:notice]="Your are not an authorized user. Please login with different username."
                  redirect_to :controller=>'login'
              end
          end
        rescue Exception=>e
          puts "Error occured in unfilled_ips method :: #{e}"
        end
  end
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Method Name: unfilled_ips_search
  #Purpose: this method is used to fetch unfilled_ips details with search parameter.
  #Version: 2.3 
  #Author: Shujauddeen/Mangai
  #Last Modified: 30-Sep-2010 by Shujauddeen
  #Notes: None
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------        
    def unfilled_ips_search
      begin
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                  @mongo_datepicker=true
                  @delivery_time= (params[:search_date]==nil || params[:search_date]=="") ? Time.now.strftime("%d-%b-%Y") : params[:search_date]
                  @country_name=params[:analytics_country_list]['country_name']
                  @pub_name=params[:publisher]['publisher_name']          
                  @limit=(params[:limit]==nil ||  params[:limit]=='') ? 0 : params[:limit].to_i
                  @offset=(params[:offset]==nil ||  params[:offset]=='') ? 10 : params[:offset].to_i
                  publisher=Publisher.find_by_publisher_name(@pub_name) if @pub_name!='' and @pub_name!=nil
                  search=Hash.new
                  #form conditional statement for mongodb
                  search.store("country_name","#{@country_name}") if @country_name!=nil and @country_name!=""
                  search.store("pub_id","#{publisher.id}") if publisher!=nil and publisher!=''
                  search.store("delivery_time","#{Time.parse(@delivery_time).strftime("%Y-%m-%d")}") if @delivery_time!=nil and @delivery_time!=''
                  #open mongodb connection
                  db   = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
                  coll = db.collection('unfilled_ips')
                  @unfilled_ips=coll.find(search).sort([:impressions ,Mongo::DESCENDING]).skip(@limit).limit(@offset)
                  @max_limit=@unfilled_ips.count()
                  #for manual pagination
                  @paginate_url = "/admin_analytic/unfilled_ips?country_name=#{@country_name}&publisher_name=#{@pub_name}&search_date=#{@delivery_time}"
                  render :action=>"unfilled_ips"
              else
                  flash[:notice]="Your are not an authorized user. Please login with different username."
                  redirect_to :controller=>'login'
              end
          end
      rescue Exception=>e
          puts "Error occured in unfilled_ips_search method :: #{e}"
      end
  end
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Method Name: no_ads_served
  #Purpose: this method is used to fetch no_ads_served details.
  #Version: 2.3 
  #Author: Shujauddeen/Mangai
  #Last Modified: 30-Sep-2010 by Shujauddeen
  #Notes: None
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------        
  def no_ads_served
      begin
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
          if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
              @mongo_datepicker=true
              @delivery_time= (params[:search_date]==nil || params[:search_date]=="") ? Time.now.strftime("%d-%b-%Y") : params[:search_date]
              @country_name=params['country_name']
              @pub_name=params['publisher_name']
              @no_ads_chart=no_ads_chart(@delivery_time,@country_name,@pub_name)
              @limit=(params[:limit]==nil ||  params[:limit]=='') ? 0 : params[:limit].to_i
              @offset=(params[:offset]==nil ||  params[:offset]=='') ? (params[:show]==nil ||  params[:show]=='') ? 100 : params[:show].to_i  : params[:offset].to_i
              publisher=Publisher.find_by_publisher_name(@pub_name) if @pub_name!='' and @pub_name!=nil
              search=Hash.new
              #form conditional statement for mongodb
              search.store("delivery_time","#{Time.parse(@delivery_time).strftime("%Y-%m-%d")}") if @delivery_time!=nil and @delivery_time!=''
              search.store("pub_id","#{publisher.id}") if publisher!=nil and publisher!=''
              search.store("country_name","#{@country_name}") if @country_name!=nil and @country_name!=""
              #open mongodb connection
              db  = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
              coll = db.collection('why_no_ads')
              @why_no_ads=coll.find(search).sort([:impressions ,Mongo::DESCENDING]).skip(@limit).limit(@offset)
              @max_limit=@why_no_ads.count()
              #for manual pagination
              @paginate_url = "/admin_analytic/no_ads_served?country_name=#{@country_name}&publisher_name=#{@pub_name}&search_date=#{@delivery_time}"
          else
              flash[:notice]="Your are not an authorized user. Please login with different username."
              redirect_to :controller=>'login'
          end
      end
      rescue Exception=>e
          puts "Error occured in no_ads_served method :: #{e}"
      end
  end
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Method Name: no_ads_served
  #Purpose: this method is used to fetch no_ads_served_search details with search parameter.
  #Version: 2.3 
  #Author: Shujauddeen/Mangai
  #Last Modified: 30-Sep-2010 by Shujauddeen
  #Notes: None
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------        
      def no_ads_served_search
          begin
              @aes = AESSecurity.new() #creating an object for AES Security
              if (session[:user_id]==nil)
                  flash[:notice]="Your session has expired. Please login again."
                  redirect_to :controller=>'login', :action=>'login'
              else
                  if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                      @mongo_datepicker=true
                      @delivery_time= (params[:search_date]==nil || params[:search_date]=="") ? Time.now.strftime("%d-%b-%Y") : params[:search_date]
                      @country_name=params[:analytics_country_list]['country_name']
                      @pub_name=params[:publisher]['publisher_name'] 
                      @no_ads_chart=no_ads_chart(@delivery_time,@country_name,@pub_name)
                      @limit=(params[:limit]==nil ||  params[:limit]=='') ? 0 : params[:limit].to_i
                      @offset=(params[:offset]==nil ||  params[:offset]=='') ? (params[:show]==nil ||  params[:show]=='') ? 100 : params[:show].to_i  : params[:offset].to_i
                      publisher=Publisher.find_by_publisher_name(@pub_name) if @pub_name!='' and @pub_name!=nil
                      search=Hash.new
                      #form conditional statement for mongodb
                      search.store("delivery_time","#{Time.parse(@delivery_time).strftime("%Y-%m-%d")}") if @delivery_time!=nil and @delivery_time!=''
                      search.store("pub_id","#{publisher.id}") if publisher!=nil and publisher!=''
                      search.store("country_name","#{@country_name}") if @country_name!=nil and @country_name!=""
                      #open mongodb connection
                      db   = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
                      coll = db.collection('why_no_ads')
                      @why_no_ads=coll.find(search).sort([:impressions ,Mongo::DESCENDING]).skip(@limit).limit(@offset)
                      @max_limit=@why_no_ads.count()
                      #for manual pagination
                      @paginate_url = "/admin_analytic/no_ads_served?country_name=#{@country_name}&publisher_name=#{@pub_name}&search_date=#{@delivery_time}"
                      render :action=>"no_ads_served"
                  else
                      flash[:notice]="Your are not an authorized user. Please login with different username."
                      redirect_to :controller=>'login'
                  end
              end
          rescue Exception=>e
              puts "Error occured in no_ads_served_search method :: #{e}"
          end
      end
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Method Name: no_ads_chart
  #Purpose: this method is used to draw pie-chart for no-ads 
  #Version: 2.3 
  #Author: Shujauddeen
  #Last Modified: 30-Sep-2010 by Shujauddeen
  #Notes: None
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------        
    def no_ads_chart(*args)
        begin
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                  delivery_time=Time.parse(args[0]).strftime("%Y-%m-%d")
                  country_name=args[1]
                  pub_name=args[2]
                  #initialize colors for piechart
                  color_hash={"0"=>"0C95BF","1"=>"12C400","2"=>"ECB800","3"=>"EB2300","4"=>"70808F","5"=>"000000","6"=>"800080","7"=>"FFFF00","8"=>"0377CA"}
                  publisher=Publisher.find_by_publisher_name(pub_name) if pub_name!='' and pub_name!=nil
                  search=Hash.new
                  #form search parameter
                  search.store("delivery_time","#{delivery_time}") if delivery_time!=nil and delivery_time!=''
                  search.store("pub_id","#{publisher.id}") if publisher!=nil and publisher!=''
                  search.store("country_name","#{country_name}") if country_name!=nil and country_name!=""
                  #open mongodb connection
                  db   = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
                  coll = db.collection('why_no_ads')
                  why_no_ads=coll.group(['yad'], search, {'impressions' => 0},  "function(doc, prev) { prev.impressions += doc.impressions}")
                  chart_data="<chart yAxisName='Impressions'  decimals='2' defaultAnimation='0' use3DLighting='0' showPlotBorder='0' plotGradientColor='' divLineColor ='FFFFFF'  baseFontSize ='12' numDivLines='2' alternateVGridColor='FFFFFF'  showBorder='0' showLabels='1' chartTopMargin='5' chartRightMargin ='30'  showValues='0' bgColor='FFFFFF' canvasBorderColor='FFFFFF' canvasBorderThickness='0' formatNumberScale='0'>"
                  count=0
                  for no_ads in why_no_ads
                      chart_color=color_hash["#{count}"]
                      chart_data+="<set label='#{no_ads['yad']}' value='#{no_ads['impressions']}' color='#{chart_color}'/>" if no_ads['yad']!=nil and no_ads['yad']!=''
                      count+=1
                  end
                  chart_data+="</chart>"
                  return chart_data
              else
                  flash[:notice]="Your are not an authorized user. Please login with different username."
                  redirect_to :controller=>'login'
              end
          end
        rescue Exception=>e
            puts "Error occured in no_ads_chart method :: #{e}"
        end
    end
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  
  #Method Name: generate_csv_report
  #Purpose: this method is used to generate csv report 
  #Version: 2.3 
  #Author: Mangai
  #Last Modified: 30-Sep-2010 by Shujauddeen
  #Notes: None
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------        
  def generate_csv_report
    begin
        @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
            report_type=params[:type] 
            db   = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
            filename=""
            csv_string=FasterCSV.generate do |csv|
                if (report_type == 'OR')
                    # OR => Owners Report
                    search=Hash.new
                    #form conditional statement for mongodb
                    (params[:report_date]==nil or params[:report_date]=='') ? search.store("delivery_time","#{Time.parse(Time.now).strftime("%Y-%m-%d")}") : search.store("delivery_time","#{Time.parse(params[:report_date]).strftime("%Y-%m-%d")}")
                    search.store("country_name","#{params[:country_name]}") unless  (params[:country_name]==nil or params[:country_name]=='')
                    search.store("owner_name","#{params[:owner_name]}") unless  (params[:owner_name]==nil or params[:owner_name]=='')
                    search.store("carrier_name","Unknown") if params[:recognized_owner]=='unrecognized_owner'
                    coll = db.collection('owner_summaries')
                    report_data=coll.find(search)
                    #Appending data for csv file
                    csv << ["Owner","Impressions","Country","Carrier"]
                    for data in report_data
                        csv << ["#{data['owner_name']}","#{data['impressions']}","#{data['country_name']}","#{data['carrier_name']}"]
                    end
                    #creating a Owner Summaries CSV file.
                    filename = "owner_summaries" + ".csv"
                elsif(report_type == 'FC')
                    # FC => Fraud Clicks
                    search=Hash.new
                    #form conditional statement for mongodb
                    search.store("delivery_time","#{Time.parse(params[:delivery_time]).strftime("%Y-%m-%d")}")
                    publisher=Publisher.find_by_publisher_name(params[:publisher_name]) unless  (params[:publisher_name]==nil or params[:publisher_name]=='')
                    search.store("pub_id","#{publisher.id}") if publisher !=nil and publisher !=''
                    search.store("campaign_name","#{params[:campaign_name]}") unless  (params[:campaign_name]==nil or params[:campaign_name]=='')
                    coll = db.collection('fraud_clicks')
                    report_data=coll.find(search)
                    #Appending data for csv file
                    csv << ["Campaign", "Fraud Click","Amount not charged ($)","Client Id","Chargeback ($)"]
                    for data in report_data
                        csv <<["#{data['campaign_name']}","#{data['fraud_click']}","#{data['fraud_click'].to_i * data['bid'].to_f}","#{data['client_id']}","#{sprintf("%.2f",(((data['fraud_click'].to_i * data['bid'].to_f)*60)/100).to_s)}"]
                      end
                    #creating a fraud click summary CSV file.
                    filename = "fraud_click_summary" + ".csv"
                elsif(report_type == 'FD')
                    # FD => FraudClick Details
                    search=Hash.new
                    #form conditional statement for mongodb
                    search.store("pub_id","#{params[:pub_id]}") if params[:pub_id] !=nil and params[:pub_id] !=''
                    search.store("client_id","#{params[:client_id]}") if params[:client_id] !=nil and params[:client_id] !=''
                    search.store("campaign_id","#{params[:campaign_id]}") unless  (params[:campaign_id]==nil or params[:campaign_id]=='')
                    #~ delivery_date={"$gte" => "#{Time.parse(params[:delivery_time]).strftime("%Y-%m-%d")} 00:00:00", "$lte" => "#{Time.parse(params[:delivery_time]).strftime("%Y-%m-%d")} 23:59:59"}
                    #~ search.store("delivery_time",delivery_date)
                    search.store("status","FC") 
                    coll = db.collection("ip_details_#{Time.parse(params[:delivery_time]).strftime("%Y-%m-%d")}")
                    report_data=coll.find(search)
                    #Appending data for csv file
                    csv << ["IP Address", "UserAgent","TimeStamp"]
                    for data in report_data
                        csv <<["#{data['ip_address']}","#{data['user_agent']}","#{ data['delivery_time']}"]
                    end
                    #creating a fraud click detail summary CSV file.
                    filename = "fraud_click_detail_summary" + ".csv"
                elsif(report_type == 'WD')
                    # WD => WifiTraffic Details
                    search=Hash.new
                    #form conditional statement for mongodb
                    search.store("pub_id","#{params[:pub_id]}") if params[:pub_id] !=nil and params[:pub_id] !=''
                    search.store("client_id","#{params[:client_id]}") if params[:client_id] !=nil and params[:client_id] !=''
                    search.store("campaign_id","#{params[:campaign_id]}") unless  (params[:campaign_id]==nil or params[:campaign_id]=='')
                    #~ delivery_date={"$gte" => "#{Time.parse(params[:delivery_time]).strftime("%Y-%m-%d")} 00:00:00", "$lte" => "#{Time.parse(params[:delivery_time]).strftime("%Y-%m-%d")} 23:59:59"}
                    #~ search.store("delivery_time",delivery_date)
                    search.store("currency_symbol","Wifi") 
                    coll = db.collection("ip_details_#{Time.parse(params[:delivery_time]).strftime("%Y-%m-%d")}")
                    report_data=coll.find(search)
                    #Appending data for csv file
                    csv << ["IP Address", "UserAgent","Owner","TimeStamp"]
                    for data in report_data
                        csv <<["#{data['ip_address']}","#{data['user_agent']}","#{data['carrier_name']}","#{ data['delivery_time']}"]
                    end
                    #creating a wifi traffic details CSV file.
                    filename = "wifi_traffic_details" + ".csv"
                elsif(report_type == 'WT')
                    # WT => Wifi Traffic
                    search=Hash.new
                    #form conditional statement for mongodb
                    search.store("delivery_time","#{Time.parse(params[:delivery_time]).strftime("%Y-%m-%d")}")
                    publisher=Publisher.find_by_publisher_name(params[:pub_name]) unless  (params[:pub_name]==nil or params[:pub_name]=='')
                    search.store("pub_id","#{publisher.id}") if publisher !=nil and publisher !=''
                    search.store("campaign_name","#{params[:campaign_name]}") unless  (params[:campaign_name]==nil or params[:campaign_name]=='')
                    coll = db.collection('wifi_summaries')
                    report_data=coll.find(search)
                    #Appending data for csv file
                    csv << ["Campaign", "Wifi Traffic Acquired","Wifi Filled","Wifi UnFilled","Publisher Id","Client Id"]
                    for data in report_data
                        csv <<["#{data['campaign_name']}","#{data['filled']+data['unfilled']}","#{data['filled']}","#{data['unfilled']}","#{data['pub_id']}","#{data['client_id']}"]
                    end
                    #creating a wifi  summary  CSV file.
                    filename = "wifi_summaries" + ".csv"
                elsif(report_type == 'UI')
                    search=Hash.new
                    #form conditional statement for mongodb
                    search.store("country_name","#{params[:country_name]}") unless  (params[:country_name]==nil or params[:country_name]=='')
                    publisher=Publisher.find_by_publisher_name(params[:pub_name]) unless  (params[:pub_name]==nil or params[:pub_name]=='')
                    search.store("pub_id","#{publisher.id}") if publisher !=nil and publisher !=''
                    search.store("delivery_time","#{Time.parse(params[:delivery_time]).strftime("%Y-%m-%d")}")
                    coll = db.collection('unfilled_ips')
                    report_data=coll.find(search)
                    #Appending data for csv file
                    csv << ["Publisher Id", "Client Id","Impressions","Country Name"]
                    for data in report_data
                        csv <<["#{(data['pub_id']==nil or data['pub_id']=='') ? '0' : data['pub_id']}","#{data['client_id']}","#{data['impressions']}","#{data['country_name']}"]
                    end
                    #creating a unfilled ips CSV file.
                    filename = "unfilled_ips" + ".csv"
                elsif(report_type == 'UD')
                    search=Hash.new
                    #form conditional statement for mongodb
                    search.store("pub_id","#{params[:pub_id]}") if params[:pub_id]!=nil and params[:pub_id]!=""
                    search.store("client_id","#{params[:client_id]}") if params[:client_id]!=nil and params[:pub_id]!=""
                    search.store("country_name","#{params[:country_name]}") unless  (params[:country_name]==nil or params[:country_name]=='')
                    #~ delivery_date={"$gte" => "#{Time.parse(params[:delivery_time]).strftime("%Y-%m-%d")} 00:00:00", "$lte" => "#{Time.parse(params[:delivery_time]).strftime("%Y-%m-%d")} 23:59:59"}
                    #~ search.store("delivery_time",delivery_date)
                    #~ if params[:data_type]='unfilled_ips'
                        #~ search.store("status","IP NIL") 
                    #~ end
                    coll = db.collection("ip_details_#{Time.parse(params[:delivery_time]).strftime("%Y-%m-%d")}")
                    report_data=coll.find(search)
                    #Appending data for csv file
                    csv << ["IP Address", "UserAgent","Owner ","TimeStamp"]
                    for data in report_data
                        csv <<["#{data['ip_address']}","#{data['user_agent']}","#{data['carrier_name']}","#{ data['delivery_time']}"]
                    end
                    #creating a unfilled ips details  summary CSV file.  
                    filename = "unfilled_details_summary" + ".csv"
                elsif(report_type == 'CDB')
                    # CDB => Campaign Data Breakdown
                    search=Hash.new
                    #form conditional statement for mongodb
                    advertiser=Advertiser.find_by_name(params[:advertiser_name]) unless  (params[:advertiser_name]==nil or params[:advertiser_name]=='')
                    publisher=Publisher.find_by_publisher_name(params[:publisher_name]) unless  (params[:publisher_name]==nil or params[:publisher_name]=='')
                    search.store("dt","#{Time.parse(params[:delivery_time]).strftime("%Y-%m-%d")}")
                    search.store("aid","#{advertiser.id}") if advertiser !=nil and advertiser !=''
                    search.store("pid","#{publisher.id}") if publisher !=nil and publisher !=''
                    coll = db.collection('campaigns_breakdown')
                    report_data=coll.find(search)
                    #Appending data for csv file
                    csv << ["Advertiser", "Campaign","Publisher","Adclient","Impressions","Clicks","Amount Spent ($)","Publisher Revenue ($)"]
                    pub_details=AnalyticsData.publisher_data_get()
                    if pub_details==nil or pub_details==""
                          pub_details= get_publisher_detail()
                          AnalyticsData.publisher_data_set(pub_details)
                    end
                    adv_details=AnalyticsData.advertiser_data_get()
                    if adv_details==nil or adv_details==""
                        adv_details =get_advertiser_detail()
                        AnalyticsData.advertiser_data_set(adv_details)
                    end
                    for data in report_data
                        csv <<["#{(adv_details[data['caid'].to_sym]==nil or adv_details[data['caid'].to_sym]=='') ? 'Unknown' : adv_details[data['caid'].to_sym][1]}","#{(adv_details[data['caid'].to_sym]==nil or adv_details[data['caid'].to_sym]=='') ? 'Unknown' : adv_details[data['caid'].to_sym][0]}","#{(pub_details[data['cid'].to_sym]==nil or pub_details[data['cid'].to_sym]=='') ? 'Unknown' : pub_details[data['cid'].to_sym][1]}","#{(pub_details[data['cid'].to_sym]==nil or pub_details[data['cid'].to_sym]=='') ? 'Unknown' : pub_details[data['cid'].to_sym][0]}","#{data['imp']}","#{data['ck']}","#{data['spt']}","#{data['rev']}"]
                    end
                    #creating a campaign_breakdown_summary summary CSV file.
                    filename = "campaign_breakdown_summary" + ".csv"
                elsif(report_type == 'CL')
                    # CL => Click Logs
                    search=Hash.new
                    #form conditional statement for mongodb
                    client=Adclient.find(:all, :conditions => ['app_name = ? AND status <> ?',   params[:client_name], 'Deleted']) unless  (params[:client_name]==nil or params[:client_name]=='')
                    #~ client=Adclient.find_by_app_name(params[:client_name]) unless  (params[:client_name]==nil or params[:client_name]=='')
                    advertiser=Advertiser.find_by_name(params[:advertiser_name]) unless  (params[:advertiser_name]==nil or params[:advertiser_name]=='')
                    search.store("dt","#{Time.parse(params[:delivery_time]).strftime("%Y-%m-%d")}")
                    search.store("aid","#{advertiser.id}") if advertiser !=nil and advertiser !=''
                    search.store("cid","#{client[0].id}") if client !=nil and client !=''
                    coll = db.collection('click_logs')
                    report_data=coll.find(search)
                    #Appending data for csv file
                    csv << ["IP Address","Advertiser", "Adclient","Clicks", "Cost ($)","UserAgent","Carrier"]
                    advname=AnalyticsData.advertiser_get()
                    if advname==nil or advname==""
                        advname =get_advertiser_name()
                        AnalyticsData.advertiser_set(advname)
                    end
                    client_details=AnalyticsData.client_get()
                    if client_details==nil or client_details==""
                        client_details= get_adclient_name()
                        AnalyticsData.client_set(client_details)
                    end
                    for data in report_data
                        csv <<["#{data['ip']}","#{(advname["#{data['aid']}"]==nil or advname["#{data['aid']}"]=='') ? 'Unknown' : advname["#{data['aid']}"]}","#{(client_details["#{data['cid']}"]==nil or client_details["#{data['cid']}"]=='') ? 'Unknown' : client_details["#{data['cid']}"]}","#{data['ck']}","#{data['cost']}","#{data['ua']}","#{data['carr']}"]
                    end
                    #creating a click log summary CSV file.
                    filename = "click_log_summary" + ".csv"
                elsif(report_type == 'NAD')
                    # NAD => No Ads Details
                    search=Hash.new
                    #form conditional statement for mongodb
                    search.store("pub_id","#{params[:pub_id]}") unless  (params[:pub_id]==nil or params[:pub_id]=='')
                    search.store("country_name","#{params[:country_name]}") unless  (params[:country_name]==nil or params[:country_name]=='')
                    #~ delivery_date={"$gte" => "#{Time.parse(params[:delivery_time]).strftime("%Y-%m-%d")} 00:00:00", "$lte" => "#{Time.parse(params[:delivery_time]).strftime("%Y-%m-%d")} 23:59:59"}
                    #~ search.store("delivery_time",delivery_date)
                    search.store("status","#{params[:reason]}")
                    coll = db.collection("ip_details_#{Time.parse(params[:delivery_time]).strftime("%Y-%m-%d")}")
                    report_data=coll.find(search)
                    csv << ["IP Address", "UserAgent","Owner","TimeStamp"]
                    #Appending data for csv file
                    for data in report_data
                        csv <<["#{data['ip_address']}","#{data['user_agent']}","#{data['carrier_name']}","#{ data['delivery_time']}"]
                    end
                    #creating a no ads details summary CSV file.
                    filename = "no_ads_details_summary" + ".csv"
                elsif(report_type == 'NA')
                    # NA => No Ads 
                    search=Hash.new
                    #form conditional statement for mongodb
                    search.store("delivery_time","#{Time.parse(params[:delivery_time]).strftime("%Y-%m-%d")}")
                    publisher=Publisher.find_by_publisher_name(params[:pub_name]) unless  (params[:pub_name]==nil or params[:pub_name]=='')
                    search.store("pub_id","#{publisher.id}") if publisher !=nil and publisher !=''
                    search.store("country_name","#{params[:country_name]}") unless  (params[:country_name]==nil or params[:country_name]=='')
                    coll = db.collection('why_no_ads')
                    report_data=coll.find(search)
                    #Appending data for csv file
                    csv << ["Publisher Id","Impressions","Reason","Why no ads","Country"]
                    for data in report_data
                        csv <<["#{(data['pub_id']==nil or data['pub_id']=='') ? '0' : data['pub_id']}","#{data['impressions']}","#{data['reason']}","#{data['yad']}","#{(data['country_name']==nil or data['country_name']=='') ? 'Unknown' : data['country_name']}"]
                    end
                    #creating a why no ads CSV file.
                    filename = "why_no_ads" + ".csv"
                elsif(report_type == 'US_STATE')
                    statesname={"CT"=>"CONNECTICUT","LA"=>"LOUISIANA","VA"=>"VIRGINIA","TX"=>"TEXAS","OH"=>"OHIO","CA"=>"CALIFORNIA","NY"=>"NEW YORK","PA"=>"PENNSYLVANIA","NH"=>"NEW HAMPSHIRE","MO"=>"MISSOURI","MA"=>"MASSACHUSETTS","RI"=>"RHODE ISLAND","UT"=>"UTAH","GA"=>"GEORGIA","TN"=>"TENNESSEE","OR"=>"OREGON","FL"=>"FLORIDA","HI"=>"HAWAII","MI"=>"MICHIGAN","SC"=>"SOUTH CAROLINA","MD"=>"MARYLAND","VT"=>"VERMONT","IL"=>"ILLINOIS","IN"=>"INDIANA","WI"=>"WISCONSIN","NM"=>"NEW MEXICO","NC"=>"NORTH CAROLINA","NJ"=>"NEW JERSEY","ID"=>"IDAHO","WA"=>"WASHINGTON","MN"=>"MINNESOTA","DC"=>"DISTRICT OF COLUMBIA","CO"=>"COLORADO","DE"=>"DELAWARE","AL"=>"ALABAMA","AZ"=>"ARIZONA","IA"=>"IOWA","KY"=>"KENTUCKY","NV"=>"NEVADA","AR"=>"ARKANSAS","MS"=>"MISSISSIPPI","KS"=>"KANSAS","OK"=>"OKLAHOMA","AK"=>"ALASKA","ME"=>"MAINE","NE"=>"NEBRASKA","MT"=>"MONTANA","WV"=>"WEST VIRGINIA","SD"=>"SOUTH DAKOTA","WY"=>"WYOMING","ND"=>"NORTH DAKOTA"}
                    search=Hash.new
                    advertiser=Advertiser.find_by_name(params[:adv]) unless  (params[:adv]==nil or params[:adv]=='')
                    state=params[:state]
                    delivery_date={"$gte" => "#{Time.parse(params[:start_date]).strftime("%Y-%m-%d")}", "$lte" => "#{Time.parse(params[:end_date]).strftime("%Y-%m-%d")}"}
                    search.store("dt",delivery_date)
                    search.store("aid","#{advertiser.id}") if advertiser !=nil and advertiser !=''
                    search.store("st","#{state}") if state !=nil and state !=''
                    coll = db.collection('us_geostats')
                    report_data=coll.find(search)
                    csv << ["Advertiser","Campaign","State", "Impressions","Clicks","CTR (%)"]
                    adv_details=AnalyticsData.advertiser_data_get()
                    if adv_details==nil or adv_details==""
                        adv_details =get_advertiser_detail()
                        AnalyticsData.advertiser_data_set(adv_details)
                    end
                    for data in report_data
                        csv <<["#{(data['caid']==nil or data['caid']=='') ? 'Unknow' : (adv_details[data['caid'].to_sym]==nil or  adv_details[data['caid'].to_sym]=='') ? 'Unknown' : adv_details[data['caid'].to_sym][1]}","#{(data['caid']==nil or data['caid']=='') ? 'Unknow' : (adv_details[data['caid'].to_sym]==nil or  adv_details[data['caid'].to_sym]=='') ? 'Unknown' : adv_details[data['caid'].to_sym][0]}","#{(data['st']==nil or data['st']=='') ? 'Unknown' : statesname["#{[data['st']]}"]}","#{data['fl']}","#{data['ck']}","#{"%.2f" %((data['ck'].to_f/data['fl'].to_f))}"]
                    end
                    filename = "US_states_summary" + ".csv"
                elsif(report_type == 'US_CITY')
                    search=Hash.new
                    campaign=Campaign.find_by_campaign_name(params[:camp]) unless  (params[:camp]==nil or params[:camp]=='')
                    advertiser=Advertiser.find_by_name(params[:adv]) unless  (params[:adv]==nil or params[:adv]=='')
                    city=params[:city]
                    state=params[:state]
                    delivery_date={"$gte" => "#{Time.parse(params[:start_date]).strftime("%Y-%m-%d")}", "$lte" => "#{Time.parse(params[:end_date]).strftime("%Y-%m-%d")}"}
                    search.store("dt",delivery_date)
                    search.store("aid","#{advertiser.id}") if advertiser !=nil and advertiser !=''
                    search.store("st","#{state}") if state !=nil and state !=''
                    search.store("st","") if state =='Unknown'
                    search.store("aid","0") if params[:adv].to_s =='0'
                    search.store("ct","#{city}") if city!=nil and city !=''
                    search.store("caid","#{campaign.id}") if campaign !=nil and campaign !=''
                    search.store("caid","0") if params[:camp].to_s =='0'
                    coll = db.collection('us_geostats')
                    report_data=coll.find(search)
                    csv << ["Advertiser","Campaign", "City","Impressions","Clicks","CTR (%)"]
                    adv_details=AnalyticsData.advertiser_data_get()
                    if adv_details==nil or adv_details==""
                        adv_details =get_advertiser_detail()
                        AnalyticsData.advertiser_data_set(adv_details)
                    end
                    for data in report_data
                        csv <<["#{(data['caid']==nil or data['caid']=='') ? 'Unknow' : (adv_details[data['caid'].to_sym]==nil or  adv_details[data['caid'].to_sym]=='') ? 'Unknown' : adv_details[data['caid'].to_sym][1]}","#{(data['caid']==nil or data['caid']=='') ? 'Unknow' : (adv_details[data['caid'].to_sym]==nil or  adv_details[data['caid'].to_sym]=='') ? 'Unknown' : adv_details[data['caid'].to_sym][0]}","#{(data['ct']==nil or data['ct']=='') ? 'Unknown' : data['ct']}","#{data['fl']}","#{data['ck']}","#{"%.2f" %((data['ck'].to_f/data['fl'].to_f))}"]
                    end
                    filename = "US_cities_summary" + ".csv"
                elsif(report_type == 'PUB_STATE')
                    statesname={"CT"=>"CONNECTICUT","LA"=>"LOUISIANA","VA"=>"VIRGINIA","TX"=>"TEXAS","OH"=>"OHIO","CA"=>"CALIFORNIA","NY"=>"NEW YORK","PA"=>"PENNSYLVANIA","NH"=>"NEW HAMPSHIRE","MO"=>"MISSOURI","MA"=>"MASSACHUSETTS","RI"=>"RHODE ISLAND","UT"=>"UTAH","GA"=>"GEORGIA","TN"=>"TENNESSEE","OR"=>"OREGON","FL"=>"FLORIDA","HI"=>"HAWAII","MI"=>"MICHIGAN","SC"=>"SOUTH CAROLINA","MD"=>"MARYLAND","VT"=>"VERMONT","IL"=>"ILLINOIS","IN"=>"INDIANA","WI"=>"WISCONSIN","NM"=>"NEW MEXICO","NC"=>"NORTH CAROLINA","NJ"=>"NEW JERSEY","ID"=>"IDAHO","WA"=>"WASHINGTON","MN"=>"MINNESOTA","DC"=>"DISTRICT OF COLUMBIA","CO"=>"COLORADO","DE"=>"DELAWARE","AL"=>"ALABAMA","AZ"=>"ARIZONA","IA"=>"IOWA","KY"=>"KENTUCKY","NV"=>"NEVADA","AR"=>"ARKANSAS","MS"=>"MISSISSIPPI","KS"=>"KANSAS","OK"=>"OKLAHOMA","AK"=>"ALASKA","ME"=>"MAINE","NE"=>"NEBRASKA","MT"=>"MONTANA","WV"=>"WEST VIRGINIA","SD"=>"SOUTH DAKOTA","WY"=>"WYOMING","ND"=>"NORTH DAKOTA"}
                    search=Hash.new
                    publisher=Publisher.find_by_publisher_name(params[:pub_name]) unless  (params[:pub_name]==nil or params[:pub_name]=='')
                    state=params[:state]
                    delivery_date={"$gte" => "#{Time.parse(params[:start_date]).strftime("%Y-%m-%d")}", "$lte" => "#{Time.parse(params[:end_date]).strftime("%Y-%m-%d")}"}
                    search.store("dt",delivery_date)
                    search.store("pid","#{publisher.id}") if publisher!=nil and publisher!=''
                    search.store("st","#{state}") if state !=nil and state !=''
                    coll = db.collection('pub_us_geostats')
                    report_data=coll.find(search)
                    csv << ["Publisher", "Adclient", "State", "Filled", "Unfilled","Aquired", "Clicks", "CTR (%)"]
                    pub_details=AnalyticsData.publisher_data_get()
                    if pub_details==nil or pub_details==""
                          pub_details= get_publisher_detail()
                          AnalyticsData.publisher_data_set(pub_details)
                    end
                    for data in report_data
                        csv <<["#{(data['cid']==nil or data['cid']=='') ? 'Unknown' : (pub_details[data['cid'].to_sym]==nil or  pub_details[data['cid'].to_sym]=='') ? 'Unknown' : pub_details[data['cid'].to_sym][1]}","#{(data['cid']==nil or data['cid']=='') ? 'Unknown' : (pub_details[data['cid'].to_sym]==nil or  pub_details[data['cid'].to_sym]=='') ? 'Unknown' : pub_details[data['cid'].to_sym][0]}","#{(data['st']==nil or data['st']=='') ? 'Unknown' : statesname["#{[data['st']]}"]}","#{data['fl']}","#{data['unfl']}","#{data['fl']+data['unfl']}","#{data['ck']}","#{(data['fl'].to_i==0) ? "%.2f" %(0.00) : "%.2f" %((data['ck'].to_f/data['fl'].to_f))}"]
                    end
                    filename = "Pub_states_summary" + ".csv"
                elsif(report_type == 'PUB_CITY')
                    search=Hash.new
                    adclient=Adclient.find(:all, :conditions => ['app_name = ? AND status <> ?',   params[:adclient], 'Deleted']) if params[:adclient]!='' and params[:adclient]!=nil
                    publisher=Publisher.find_by_publisher_name(params[:pub_name]) unless  (params[:pub_name]==nil or params[:pub_name]=='')
                    city=params[:city]
                    state=params[:state]
                    delivery_date={"$gte" => "#{Time.parse(params[:start_date]).strftime("%Y-%m-%d")}", "$lte" => "#{Time.parse(params[:end_date]).strftime("%Y-%m-%d")}"}
                    search.store("dt",delivery_date)
                    search.store("pid","#{publisher.id}") if publisher !=nil and publisher !=''
                    search.store("cid","#{adclient[0].id}") if adclient !=nil and adclient !=''
                    search.store("st","#{state}") if state !=nil and state !=''
                    search.store("st","") if state =='Unknown'
                    search.store("pid","0") if params[:pub_name].to_s =='0'
                    search.store("cid","0") if params[:adclient].to_s =='0'
                    search.store("ct","#{city}") if city!=nil and city !=''
                    coll = db.collection('pub_us_geostats')
                    report_data=coll.find(search)
                    csv << ["Publisher","Adclient", "City","Filled","Unfilled","Aquired","Clicks","CTR (%)"]
                    pub_details=AnalyticsData.publisher_data_get()
                    if pub_details==nil or pub_details==""
                          pub_details= get_publisher_detail()
                          AnalyticsData.publisher_data_set(pub_details)
                    end
                    for data in report_data
                        csv <<["#{(data['cid']==nil or data['cid']=='') ? 'Unknown' : (pub_details[data['cid'].to_sym]==nil or  pub_details[data['cid'].to_sym]=='') ? 'Unknown' : pub_details[data['cid'].to_sym][1]}","#{(data['cid']==nil or data['cid']=='') ? 'Unknown' : (pub_details[data['cid'].to_sym]==nil or  pub_details[data['cid'].to_sym]=='') ? 'Unknown' : pub_details[data['cid'].to_sym][0]}","#{(data['ct']==nil or data['ct']=='') ? 'Unknown' : data['ct']}","#{data['fl']}","#{data['unfl']}","#{data['unfl']+data['fl']}","#{data['ck']}","#{(data['fl'].to_i==0) ? "%.2f" %(0.00) : "%.2f" %((data['ck'].to_f/data['fl'].to_f))}"]
                    end
                    filename = "pub_cities_summary" + ".csv"
                end
            end
            send_data(csv_string ,:type => 'text/csv; charset=utf-8; header=present',:filename => filename)  
          else
              flash[:notice]="Your are not an authorized user. Please login with different username."
              redirect_to :controller=>'login'
          end
      end
    rescue Exception =>e
        puts "Error occured in generate_csv_report method :: #{e}"
    end
  end
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Method Name: unfilled_details
  #Purpose: this method is used to fetch and display unfilled traffic details
  #Version: 2.3 
  #Author: Mangai/Subaida
  #Last Modified: 30-Sep-2010 by Shujauddeen
  #Notes: None
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------        
    def unfilled_details
        begin
            @aes = AESSecurity.new() #creating an object for AES Security
            if (session[:user_id]==nil)
                flash[:notice]="Your session has expired. Please login again."
                redirect_to :controller=>'login', :action=>'login'
            else
                if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                    @mongo_datepicker=true
                    @pub_id=params[:pub_id]
                    @country_name=params[:country_name]
                    @delivery_time= params[:delivery_time]
                    @client_id= params[:client_id]
                    search=Hash.new
                    search.store("pub_id","#{@pub_id}") if @pub_id!=nil and @pub_id!=""
                    search.store("client_id","#{@client_id}") if @client_id!=nil and @client_id!=""
                    search.store("country_name","#{@country_name}") if @country_name !=nil and @country_name !=''
                    delivery_date={"$gte" => "#{Time.parse(@delivery_time).strftime("%Y-%m-%d")} 00:00:00", "$lte" => "#{Time.parse(@delivery_time).strftime("%Y-%m-%d")} 23:59:59"}
                    search.store("delivery_time",delivery_date) if params[:date]!=nil and params[:date]!=''
                    @limit=(params[:limit]==nil ||  params[:limit]=='') ? 0 : params[:limit].to_i
                    @offset=(params[:offset]==nil ||  params[:offset]=='') ? 10: params[:offset].to_i
                    db  = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
                    #~ if params[:report_type]=='unfilled_ips'
                    #~ search.store("status","IP NIL") 
                    #~ end
                    coll = db.collection("ip_details_#{Time.parse(@delivery_time).strftime("%Y-%m-%d")}")
                    @ip_details=coll.find(search).skip(@limit).limit(@offset)
                    @max_limit=@ip_details.count()
                    @paginate_url = "/admin_analytic/unfilled_details?country_name=#{@country_name}&pub_id=#{@pub_id}&delivery_time=#{@delivery_time}&client_id=#{@client_id}"
                else
                    flash[:notice]="Your are not an authorized user. Please login with different username."
                    redirect_to :controller=>'login'
                end
            end
        rescue Exception=>e
            puts "Error occured in unfilled_details method :: #{e}"
        end
     end
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Method Name: fc_details
  #Purpose: this method is used to fetch fraud clicks details 
  #Version: 2.3 
  #Author: Mangai/Shujauddeen
  #Last Modified: 30-Sep-2010 by Shujauddeen
  #Notes: None
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------        
    def fc_details
        begin
            @aes = AESSecurity.new() #creating an object for AES Security
            if (session[:user_id]==nil)
                flash[:notice]="Your session has expired. Please login again."
                redirect_to :controller=>'login', :action=>'login'
            else
                if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                    @mongo_datepicker=true
                    @pub_id=params[:pub_id]
                    @client_id=params[:client_id]
                    @campaign_id=params[:campaign_id]
                    @delivery_time= params[:delivery_time]
                    search=Hash.new
                    #form search parameter
                    search.store("pub_id","#{@pub_id}") if @pub_id!=nil and @pub_id!=""
                    search.store("client_id","#{@client_id}") if @client_id!=nil and @client_id!=""
                    search.store("campaign_id","#{@campaign_id}") if @campaign_id !=nil and @campaign_id !=''
                    #~ delivery_date={"$gte" => "#{Time.parse(@delivery_time).strftime("%Y-%m-%d")} 00:00:00", "$lte" => "#{Time.parse(@delivery_time).strftime("%Y-%m-%d")} 23:59:59"}
                    #~ search.store("delivery_time",delivery_date) if @delivery_time!=nil and @delivery_time!=''
                    @limit=(params[:limit]==nil ||  params[:limit]=='') ? 0 : params[:limit].to_i
                    @offset=(params[:offset]==nil ||  params[:offset]=='') ? 100: params[:offset].to_i
                    #open mongodb connection
                    db  = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
                    search.store("status","FC") 
                    coll = db.collection("ip_details_#{Time.parse(@delivery_time).strftime("%Y-%m-%d")}")
                    @fc_details=coll.find(search).skip(@limit).limit(@offset)
                    @max_limit=@fc_details.count()
                    @paginate_url = "/admin_analytic/fc_details?campaign_id=#{@campaign_id}&pub_id=#{@pub_id}&delivery_time=#{@delivery_time}&client_id=#{@client_id}"
                    #~ render :layout=>false
                else
                    flash[:notice]="Your are not an authorized user. Please login with different username."
                    redirect_to :controller=>'login'
                end
            end
        rescue Exception=>e
            puts "Error occured in fc_details method :: #{e}"
        end
    end
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Method Name: fc_details
  #Purpose: this method is used to fetch fraud clicks details 
  #Version: 2.3 
  #Author: Mangai
  #Last Modified: 30-Sep-2010 by Shujauddeen
  #Notes: None
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------        
    def wifi_details
        begin
            @aes = AESSecurity.new() #creating an object for AES Security
            if (session[:user_id]==nil)
                flash[:notice]="Your session has expired. Please login again."
                redirect_to :controller=>'login', :action=>'login'
            else
                if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                    @mongo_datepicker=true
                    @campaign_id=params[:campaign_id]
                    @pub_id=params[:pub_id]
                    @client_id=params[:client_id]
                    @delivery_time= params[:delivery_time]
                    search=Hash.new
                    #form search parameter
                    search.store("pub_id","#{@pub_id}") if @pub_id !=nil and @pub_id !=''
                    search.store("client_id","#{@client_id}") if @client_id !=nil and @client_id !=''
                    search.store("campaign_id","#{@campaign_id}") if @campaign_id !=nil and @campaign_id !=''
                    #~ delivery_date={"$gte" => "#{Time.parse(@delivery_time).strftime("%Y-%m-%d")} 00:00:00", "$lte" => "#{Time.parse(@delivery_time).strftime("%Y-%m-%d")} 23:59:59"}
                    #~ search.store("delivery_time",delivery_date) if @delivery_time!=nil and @delivery_time!=''
                    @limit=(params[:limit]==nil ||  params[:limit]=='') ? 0 : params[:limit].to_i
                    @offset=(params[:offset]==nil ||  params[:offset]=='') ? 100: params[:offset].to_i
                    #open mongodb connection
                    db  = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
                    search.store("currency_symbol","Wifi") 
                    coll = db.collection("ip_details_#{Time.parse(@delivery_time).strftime("%Y-%m-%d")}")
                    @wifi_details=coll.find(search).skip(@limit).limit(@offset)
                    @max_limit=@wifi_details.count()
                    @paginate_url = "/admin_analytic/wifi_details?campaign_id=#{@campaign_id}&pub_id=#{@pub_id}&delivery_time=#{@delivery_time}&client_id=#{@client_id}"
                    #~ @paginate_url = "/admin_analytic/unfilled_details?country=#{@country}&pub_id#{@pub_id}&date=#{@date}&type=#{@report_type}"
                    #~ render :layout=>false
                else
                    flash[:notice]="Your are not an authorized user. Please login with different username."
                    redirect_to :controller=>'login'
                end
            end
        rescue Exception=>e
            puts "Error occured in wifi_details method :: #{e}"
        end
      end
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Method Name: no_ads_details
  #Purpose: this method is used to fetch no ads details 
  #Version: 2.3 
  #Author: Shujauddeen
  #Last Modified: 30-Sep-2010 by Shujauddeen
  #Notes: None
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------        
    def no_ads_details
        begin
            @aes = AESSecurity.new() #creating an object for AES Security
            if (session[:user_id]==nil)
                flash[:notice]="Your session has expired. Please login again."
                redirect_to :controller=>'login', :action=>'login'
            else
                if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                    @mongo_datepicker=true
                    @pub_id=params[:pub_id]
                    @country_name=params[:country_name]
                    @delivery_time= params[:delivery_time]
                    @reason= params[:reason]
                    search=Hash.new 
                    #form search parameter
                    search.store("pub_id","#{@pub_id}") if @pub_id!=nil and @pub_id!=""
                    search.store("country_name","#{@country_name}") if @country_name !=nil and @country_name !=''
                    #~ delivery_date={"$gte" => "#{Time.parse(@delivery_time).strftime("%Y-%m-%d")} 00:00:00", "$lte" => "#{Time.parse(@delivery_time).strftime("%Y-%m-%d")} 23:59:59"}
                    #~ search.store("delivery_time",delivery_date) if @delivery_time!=nil and @delivery_time!=''
                    @limit=(params[:limit]==nil ||  params[:limit]=='') ? 0 : params[:limit].to_i
                    @offset=(params[:offset]==nil ||  params[:offset]=='') ? 100: params[:offset].to_i
                    #open mongodb connection
                    db  = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
                    search.store("status",@reason) 
                    coll = db.collection("ip_details_#{Time.parse(@delivery_time).strftime("%Y-%m-%d")}")
                    @no_ads_details=coll.find(search).skip(@limit).limit(@offset)
                    @max_limit=@no_ads_details.count()
                    #for manual pagination
                    @paginate_url = "/admin_analytic/no_ads_details?country_name=#{@country_name}&pub_id=#{@pub_id}&delivery_time=#{@delivery_time}&reason=#{@reason}"
                else
                    flash[:notice]="Your are not an authorized user. Please login with different username."
                    redirect_to :controller=>'login'
                end
            end
        rescue Exception=>e
            puts "Error occured in no_ads_details method :: #{e}"
        end
   end
  
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Method Name: campaign_breakdown
  #Purpose: this method is used to fetch campaign_breakdown details.
  #Version: 2.3 
  #Author: Shujauddeen/Mangai
  #Last Modified: 13-Oct-2010 by Shujauddeen
  #Notes: None
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------        
  
   def campaign_breakdown
      begin
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                  @mongo_datepicker=true
                  @delivery_time= (params[:search_date]==nil || params[:search_date]=="") ? Time.now.strftime("%d-%b-%Y") : params[:search_date]
                  @adv_name=params[:adv]
                  @pub_name=params[:pub]
                  @limit=(params[:limit]==nil ||  params[:limit]=='') ? 0 : params[:limit].to_i
                  @offset=(params[:offset]==nil ||  params[:offset]=='') ? ((params[:show]==nil ||  params[:show]=='') ? 100 : params[:show].to_i ) : params[:offset].to_i
                  advertiser=Advertiser.find_by_name(@adv_name) if @adv_name!='' and @adv_name!=nil
                  publisher=Publisher.find_by_publisher_name(@pub_name) if @pub_name!='' and @pub_name!=nil
                  # set the publisher detials in cache
                  @pub_details=AnalyticsData.publisher_data_get()
                  if @pub_details==nil or @pub_details==""
                        @pub_details= get_publisher_detail()
                        AnalyticsData.publisher_data_set(@pub_details)
                  end
                  # set the advertiser details in cache
                  @adv_details=AnalyticsData.advertiser_data_get()
                  if @adv_details==nil or @adv_details==""
                      @adv_details =get_advertiser_detail()
                      AnalyticsData.advertiser_data_set(@adv_details)
                  end
                  search=Hash.new
                  #~ #form conditional statement for mongodb
                  search.store("pid","#{publisher.id}") if publisher!=nil and publisher!=''
                  search.store("aid","#{advertiser.id}") if advertiser!=nil and advertiser!=''
                  search.store("dt","#{Time.parse(@delivery_time).strftime("%Y-%m-%d")}") if @delivery_time!=nil and @delivery_time!=''
                  #~ #open mongodb connection
                  db = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
                  coll = db.collection('campaigns_breakdown')
                  @campaigns_breakdown=coll.find(search).sort([:imp ,Mongo::DESCENDING]).skip(@limit).limit(@offset)
                  @max_limit=@campaigns_breakdown.count()
                  #~ #for manual pagination
                  @paginate_url = "/admin_analytic/campaign_breakdown?pub=#{@pub_name}&adv=#{@adv_name}&search_date=#{@delivery_time}"
                  render :action=>"campaign_breakdown"
              else
                  flash[:notice]="Your are not an authorized user. Please login with different username."
                  redirect_to :controller=>'login'
              end
          end
      rescue Exception=>e
          puts "Error : /admin_analytic_controller/campaign_breakdown : #{e.to_s}"
      end
  end
  
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Method Name: campaign_breakdown_search
  #Purpose: this method is used to fetch campaign_breakdown_search details with search parameters.
  #Version: 2.3 
  #Author: Shujauddeen/Mangai
  #Last Modified: 13-Oct-2010 by Shujauddeen
  #Notes: None
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------        
  
   def campaign_breakdown_search
      begin
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                  @mongo_datepicker=true
                  @delivery_time= (params[:search_date]==nil || params[:search_date]=="") ? Time.now.strftime("%d-%b-%Y") : params[:search_date]
                  @adv_name=params[:advertiser]['name'] unless params[:advertiser]==nil
                  @pub_name=params[:publisher]['publisher_name'] unless params[:publisher]==nil
                  @limit=(params[:limit]==nil ||  params[:limit]=='') ? 0 : params[:limit].to_i
                  @offset=(params[:offset]==nil ||  params[:offset]=='') ? (params[:show]==nil ||  params[:show]=='') ? 100 : params[:show].to_i  : params[:offset].to_i
                  advertiser=Advertiser.find_by_name(@adv_name) if @adv_name!='' and @adv_name!=nil
                  publisher=Publisher.find_by_publisher_name(@pub_name) if @pub_name!='' and @pub_name!=nil
                  # set the publisher detials in cache
                  @pub_details=AnalyticsData.publisher_data_get()
                  if @pub_details==nil or @pub_details==""
                        @pub_details= get_publisher_detail()
                        AnalyticsData.publisher_data_set(@pub_details)
                  end
                  # set the advertiser details in cache
                  @adv_details=AnalyticsData.advertiser_data_get()
                  if @adv_details==nil or @adv_details==""
                      @adv_details =get_advertiser_detail()
                      AnalyticsData.advertiser_data_set(@adv_details)
                  end
                  search=Hash.new
                  #form conditional statement for mongodb
                  search.store("pid","#{publisher.id}") if publisher!=nil and publisher!=''
                  search.store("aid","#{advertiser.id}") if advertiser!=nil and advertiser!=''
                  search.store("dt","#{Time.parse(@delivery_time).strftime("%Y-%m-%d")}") if @delivery_time!=nil and @delivery_time!=''
                  #open mongodb connection
                  db   = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
                  coll = db.collection('campaigns_breakdown')
                  @campaigns_breakdown=coll.find(search).sort([:imp ,Mongo::DESCENDING]).skip(@limit).limit(@offset)
                  @max_limit=@campaigns_breakdown.count()
                  #for manual pagination
                  @paginate_url = "/admin_analytic/campaign_breakdown?pub=#{@pub_name}&adv=#{@adv_name}&search_date=#{@delivery_time}"
                  render :action=>"campaign_breakdown"
              else
                  flash[:notice]="Your are not an authorized user. Please login with different username."
                  redirect_to :controller=>'login'
              end
          end
      rescue Exception=>e
          puts "Error : /admin_analytic_controller/campaign_breakdown_search : #{e.to_s}"
      end
    end
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Method Name: get_publisher_detail
  #Purpose: this method is used to fetch publisher detail for campaign_breakdown details.
  #Version: 2.3 
  #Author: Shujauddeen/Mangai
  #Last Modified: 13-Oct-2010 by Shujauddeen
  #Notes: None
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  
    def get_publisher_detail
        begin
            @aes = AESSecurity.new() #creating an object for AES Security
            if (session[:user_id]==nil)
               flash[:notice]="Your session has expired. Please login again."
               redirect_to :controller=>'login', :action=>'login'
            else
               if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                    @mongo_datepicker=true
                    pub_sql="select p.publisher_name as pub_name,p.id as pub_id,a.app_name as app_name,a.id as adclient_id,a.ads_approval_type as approval_type from publishers p,adclients a where p.id=a.publisher_id"
                    pub_details=Hash.new
                    publishers=Publisher.find_by_sql(pub_sql)
                    for pub in publishers
                        pub_details.store(pub.adclient_id.to_sym,[pub.app_name,pub.pub_name,pub.approval_type])
                      end
                else
                  flash[:notice]="Your are not an authorized user. Please login with different username."
                  redirect_to :controller=>'login'
            end
          end
        rescue Exception => e
              puts "An error occurred while fetchinng get_publisher_detail  :: #{e}"
        end
        return pub_details
    end
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Method Name: get_advertiser_detail
  #Purpose: this method is used to fetch advertiser detail for campaign_breakdown details.
  #Version: 2.3 
  #Author: Shujauddeen/Mangai
  #Last Modified: 13-Oct-2010 by Shujauddeen
  #Notes: None
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  
    def get_advertiser_detail
        begin
            @aes = AESSecurity.new() #creating an object for AES Security
            if (session[:user_id]==nil)
               flash[:notice]="Your session has expired. Please login again."
               redirect_to :controller=>'login', :action=>'login'
            else
               if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                    @mongo_datepicker=true
                      adv_sql="select a.name as adv_name,a.id as adv_id,c.campaign_name as camp_name,c.id as camp_id from advertisers a,campaigns c where a.id=c.advertiser_id"
                      adv_details=Hash.new
                      advertisers=Advertiser.find_by_sql(adv_sql)
                      for adv in advertisers
                          adv_details.store(adv.camp_id.to_sym,[adv.camp_name,adv.adv_name])
                      end
                else
                  flash[:notice]="Your are not an authorized user. Please login with different username."
                  redirect_to :controller=>'login'
               end
          end
        rescue Exception => e
              puts "An error occurred while fetchinng get_advertiser_detail  :: #{e}"
        end
        return adv_details
    end
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Method Name: get_adclient_name
  #Purpose: this method is used to fetch the adclient details for click log detais.
  #Version: 2.3 
  #Author: Shujauddeen/Mangai
  #Last Modified: 13-Oct-2010 by Shujauddeen
  #Notes: None
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------       
    def get_adclient_name
        begin
            @aes = AESSecurity.new() #creating an object for AES Security
            if (session[:user_id]==nil)
               flash[:notice]="Your session has expired. Please login again."
               redirect_to :controller=>'login', :action=>'login'
            else
               if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                    @mongo_datepicker=true
                    adclient_sql="select id,app_name from adclients"
                    adclient_name=Hash.new
                    adclients=Adclient.find_by_sql(adclient_sql)
                    for adc in adclients
                        adclient_name.store("#{adc.id}","#{adc.app_name}")
                    end
            else
               flash[:notice]="Your are not an authorized user. Please login with different username."
               redirect_to :controller=>'login'
            end
        end
        rescue Exception => e
              puts "An error occurred while fetchinng get_adclient_name  :: #{e}"
        end
        return adclient_name
    end
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Method Name: get_advertiser_name
  #Purpose: this method is used to fetch the advertiser details for click log detais.
  #Version: 2.3 
  #Author: Shujauddeen/Mangai
  #Last Modified: 13-Oct-2010 by Shujauddeen
  #Notes: None
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------     
    def get_advertiser_name
        begin
            @aes = AESSecurity.new() #creating an object for AES Security
            if (session[:user_id]==nil)
               flash[:notice]="Your session has expired. Please login again."
               redirect_to :controller=>'login', :action=>'login'
            else
               if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                    @mongo_datepicker=true
                    adv_sql="select id,name from advertisers"
                    adv_name=Hash.new
                    advertisers=Advertiser.find_by_sql(adv_sql)
                    for adv in advertisers
                        adv_name.store("#{adv.id}","#{adv.name}")
                    end
            else
               flash[:notice]="Your are not an authorized user. Please login with different username."
               redirect_to :controller=>'login'
            end
            end
        rescue Exception => e
            puts "An error occurred while fetchinng get_advertiser_name :: #{e}"
        end
        return adv_name
    end
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Method Name: click_log
  #Purpose: this method is used to fetch click_log details.
  #Version: 2.3 
  #Author: Shujauddeen/Mangai
  #Last Modified: 13-Oct-2010 by Shujauddeen
  #Notes: None
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  
  
   def click_log
      begin
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                  @mongo_datepicker=true
                  @delivery_time= (params[:search_date]==nil || params[:search_date]=="") ? Time.now.strftime("%d-%b-%Y") : params[:search_date]
                  @advertiser_name=params[:adv]
                  @adclient_name=params[:adclient]
                  @limit=(params[:limit]==nil ||  params[:limit]=='') ? 0 : params[:limit].to_i
                  @offset=(params[:offset]==nil ||  params[:offset]=='') ? ((params[:show]==nil ||  params[:show]=='') ? 100 : params[:show].to_i ) : params[:offset].to_i
                  advertiser=Advertiser.find_by_name(@advertiser_name) if @advertiser_name!='' and @advertiser_name!=nil
                  client=Adclient.find(:all, :conditions => ['app_name = ? AND status <> ?',   @adclient_name, 'Deleted']) if @adclient_name!='' and @adclient_name!=nil
                  # set the adclient details in cache
                  @client_details=AnalyticsData.client_get()
                  if @client_details==nil or @client_details==""
                      @client_details= get_adclient_name()
                      AnalyticsData.client_set(@client_details)
                  end
                  # set the advertiser details in cache
                  @advname=AnalyticsData.advertiser_get()
                  if @advname==nil or @advname==""
                      @advname =get_advertiser_name()
                      AnalyticsData.advertiser_set(@advname)
                  end
                  search=Hash.new
                   #form conditional statement for mongodb
                  search.store("aid","#{advertiser.id}") if advertiser!=nil and advertiser!=''
                  search.store("cid","#{client[0].id}") if client!=nil and client!=''
                  search.store("dt","#{Time.parse(@delivery_time).strftime("%Y-%m-%d")}") if @delivery_time!=nil and @delivery_time!=''
                  #open mongodb connection
                  db = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
                  coll = db.collection('click_logs')
                  @click_logs=coll.find(search).sort([:ck ,Mongo::DESCENDING]).skip(@limit).limit(@offset)
                  @max_limit=@click_logs.count()
                  #for manual pagination
                  @paginate_url = "/admin_analytic/click_log?adclient=#{@adclient_name}&adv=#{@advertiser_name}&search_date=#{@delivery_time}"
                  render :action=>"click_log"
              else
                  flash[:notice]="Your are not an authorized user. Please login with different username."
                  redirect_to :controller=>'login'
              end
          end
      rescue Exception=>e
          puts "Error : /admin_analytic_controller/click_log : #{e.to_s}"
      end
    end
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Method Name: click_log_search 
  #Purpose: this method is used to fetch click_log_search details with search parameters.
  #Version: 2.3 
  #Author: Shujauddeen/Mangai
  #Last Modified: 13-Oct-2010 by Shujauddeen
  #Notes: None
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  
    
    def click_log_search
      begin
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                  @mongo_datepicker=true
                  @delivery_time= (params[:search_date]==nil || params[:search_date]=="") ? Time.now.strftime("%d-%b-%Y") : params[:search_date]
                  @advertiser_name=params[:advertiser]['name'] unless params[:advertiser]==nil
                  @adclient_name=params[:adclient]['app_name'] unless params[:adclient]==nil
                  @limit=(params[:limit]==nil ||  params[:limit]=='') ? 0 : params[:limit].to_i
                  @offset=(params[:offset]==nil ||  params[:offset]=='') ? (params[:show]==nil ||  params[:show]=='') ? 100 : params[:show].to_i  : params[:offset].to_i
                  client=Adclient.find(:all, :conditions => ['app_name = ? AND status <> ?',   @adclient_name, 'Deleted']) if @adclient_name!='' and @adclient_name!=nil
                  advertiser=Advertiser.find_by_name(@advertiser_name) if @advertiser_name!='' and @advertiser_name!=nil
                  # set the adclient details in cache
                  @client_details=AnalyticsData.client_get()
                  if @client_details==nil or @client_details==""
                      @client_details= get_adclient_name()
                      AnalyticsData.client_set(@client_details)
                  end
                  # set the advertiser details in cache
                  @advname=AnalyticsData.advertiser_get()
                  if @advname==nil or @advname==""
                      @advname =get_advertiser_name()
                      AnalyticsData.advertiser_set(@advname)
                  end
                  search=Hash.new
                  #form conditional statement for mongodb
                  search.store("aid","#{advertiser.id}") if advertiser!=nil and advertiser!=''
                  search.store("cid","#{client[0].id}") if client!=nil and client!=''
                  search.store("dt","#{Time.parse(@delivery_time).strftime("%Y-%m-%d")}") if @delivery_time!=nil and @delivery_time!=''
                  #open mongodb connection
                  db   = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
                  coll = db.collection('click_logs')
                  @click_logs=coll.find(search).sort([:ck ,Mongo::DESCENDING]).skip(@limit).limit(@offset)
                  @max_limit=@click_logs.count()
                  #for manual pagination
                  @paginate_url = "/admin_analytic/click_log?adclient=#{@adclient_name}&adv=#{@advertiser_name}&search_date=#{@delivery_time}"
                  render :action=>"click_log"
              else
                  flash[:notice]="Your are not an authorized user. Please login with different username."
                  redirect_to :controller=>'login'
              end
          end
      rescue Exception=>e
          puts "Error : /admin_analytic_controller/click_log_search : #{e.to_s}"
      end
    end
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Method Name:us_geo_states
  #Purpose: this method is used to fetch dma details.
  #Version: 2.3 
  #Author: Shujauddeen/Mangai
  #Last Modified: 13-Oct-2010 by Shujauddeen
  #Notes: None
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------        
    
   def us_geo_states
      begin
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                  @mongo_datepicker=true
                  @start_date= (params[:start_date]==nil || params[:start_date]=="") ? Time.now.strftime("%d-%b-%Y") : params[:start_date]
                  @end_date= (params[:end_date]==nil || params[:end_date]=="") ? Time.now.strftime("%d-%b-%Y") : params[:end_date]
                  @duration=(params[:duration]==nil || params[:duration]=="") ? '0' : params[:duration]
                  @delivery_date={"$gte" => "#{Time.parse(@start_date).strftime("%Y-%m-%d")}", "$lte" => "#{Time.parse(@end_date).strftime("%Y-%m-%d")}"} 
                  @statesname={"CT"=>"CONNECTICUT","LA"=>"LOUISIANA","VA"=>"VIRGINIA","TX"=>"TEXAS","OH"=>"OHIO","CA"=>"CALIFORNIA","NY"=>"NEW YORK","PA"=>"PENNSYLVANIA","NH"=>"NEW HAMPSHIRE","MO"=>"MISSOURI","MA"=>"MASSACHUSETTS","RI"=>"RHODE ISLAND","UT"=>"UTAH","GA"=>"GEORGIA","TN"=>"TENNESSEE","OR"=>"OREGON","FL"=>"FLORIDA","HI"=>"HAWAII","MI"=>"MICHIGAN","SC"=>"SOUTH CAROLINA","MD"=>"MARYLAND","VT"=>"VERMONT","IL"=>"ILLINOIS","IN"=>"INDIANA","WI"=>"WISCONSIN","NM"=>"NEW MEXICO","NC"=>"NORTH CAROLINA","NJ"=>"NEW JERSEY","ID"=>"IDAHO","WA"=>"WASHINGTON","MN"=>"MINNESOTA","DC"=>"DISTRICT OF COLUMBIA","CO"=>"COLORADO","DE"=>"DELAWARE","AL"=>"ALABAMA","AZ"=>"ARIZONA","IA"=>"IOWA","KY"=>"KENTUCKY","NV"=>"NEVADA","AR"=>"ARKANSAS","MS"=>"MISSISSIPPI","KS"=>"KANSAS","OK"=>"OKLAHOMA","AK"=>"ALASKA","ME"=>"MAINE","NE"=>"NEBRASKA","MT"=>"MONTANA","WV"=>"WEST VIRGINIA","SD"=>"SOUTH DAKOTA","WY"=>"WYOMING","ND"=>"NORTH DAKOTA"}
                  @statescode={"LOUISIANA"=>"LA", "WEST VIRGINIA"=>"WV", "NEW HAMPSHIRE"=>"NH", "ILLINOIS"=>"IL", "ARIZONA"=>"AZ", "MINNESOTA"=>"MN", "ALASKA"=>"AK", "MONTANA"=>"MT", "MICHIGAN"=>"MI", "OKLAHOMA"=>"OK", "SOUTH CAROLINA"=>"SC", "MAINE"=>"ME", "DELAWARE"=>"DE", "NEVADA"=>"NV", "KANSAS"=>"KS", "MISSISSIPPI"=>"MS", "TENNESSEE"=>"TN", "DISTRICT OF COLUMBIA"=>"DC", "PENNSYLVANIA"=>"PA", "HAWAII"=>"HI", "VERMONT"=>"VT", "OREGON"=>"OR", "WASHINGTON"=>"WA", "WISCONSIN"=>"WI", "SOUTH DAKOTA"=>"SD", "IOWA"=>"IA", "VIRGINIA"=>"VA", "NORTH CAROLINA"=>"NC", "CALIFORNIA"=>"CA", "IDAHO"=>"ID", "KENTUCKY"=>"KY", "WYOMING"=>"WY", "MARYLAND"=>"MD", "CONNECTICUT"=>"CT", "FLORIDA"=>"FL", "TEXAS"=>"TX", "MISSOURI"=>"MO", "MASSACHUSETTS"=>"MA", "ARKANSAS"=>"AR", "GEORGIA"=>"GA", "NEBRASKA"=>"NE", "NEW YORK"=>"NY", "NEW JERSEY"=>"NJ", "OHIO"=>"OH", "RHODE ISLAND"=>"RI", "COLORADO"=>"CO", "ALABAMA"=>"AL", "NORTH DAKOTA"=>"ND", "UTAH"=>"UT", "NEW MEXICO"=>"NM", "INDIANA"=>"IN"}
                  @adv_name=params[:adv]
                  @state=params[:state]
                  @limit=(params[:limit]==nil ||  params[:limit]=='') ? 0 : params[:limit].to_i
                  @offset=(params[:offset]==nil ||  params[:offset]=='') ? ((params[:show]==nil ||  params[:show]=='') ? 100 : params[:show].to_i ) : params[:offset].to_i
                  advertiser=Advertiser.find_by_name(@adv_name) if @adv_name!='' and @adv_name!=nil
                  # set the advertiser details in cache
                  @geo_chart=us_geo_chart(@start_date,@end_date,@duration,@adv_name)
                  @adv_details=AnalyticsData.advertiser_data_get()
                  if @adv_details==nil or @adv_details==""
                      @adv_details =get_advertiser_detail()
                      AnalyticsData.advertiser_data_set(@adv_details)
                  end
                  search=Hash.new
                  #~ #form conditional statement for mongodb
                  search.store("dt",@delivery_date) if @delivery_date!=nil and @delivery_date!=''
                  search.store("aid","#{advertiser.id}") if advertiser!=nil and advertiser!=''
                  search.store("st","#{@statescode[@state]}") if @state!=nil and @state!=''
                  #~ #open mongodb connection
                  db = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
                  coll = db.collection('us_geostats')
                  @us_data=coll.find(search).sort([:fl ,Mongo::DESCENDING]).skip(@limit).limit(@offset)
                  @max_limit=@us_data.count()
                  #~ #for manual pagination
                  @paginate_url = "/admin_analytic/us_geo_states?adv=#{@adv_name}&state=#{@state}&start_date=#{@start_date}&end_date=#{@end_date}&duration=#{@duration}"
                  render :action=>"us_geo_states"
              else
                  flash[:notice]="Your are not an authorized user. Please login with different username."
                  redirect_to :controller=>'login'
              end
          end
      rescue Exception=>e
          puts "Error : /admin_analytic_controller/us_geo_states : #{e.to_s}"
      end
  end
    
    #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    #Method Name: us_geo_states_search
    #Purpose: this method is used to fetch dma search details.
    #Version: 2.3 
    #Author: Shujauddeen/Mangai
    #Last Modified: 21-Oct-2010 by Shujauddeen
    #Notes: None
    #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------        
   def us_geo_states_search
       begin
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                  @mongo_datepicker=true
                  @start_date= (params[:start_date]==nil || params[:start_date]=="") ? Time.now.strftime("%d-%m-%Y") : params[:start_date]
                  @end_date= (params[:end_date]==nil || params[:end_date]=="") ? Time.now.strftime("%d-%m-%Y") : params[:end_date]
                  @duration=(params[:duration]==nil || params[:duration]=="") ? '0' : params[:duration]
                  @delivery_date={"$gte" => "#{Time.parse(@start_date).strftime("%Y-%m-%d")}", "$lte" => "#{Time.parse(@end_date).strftime("%Y-%m-%d")}"} 
                  @statesname={"CT"=>"CONNECTICUT","LA"=>"LOUISIANA","VA"=>"VIRGINIA","TX"=>"TEXAS","OH"=>"OHIO","CA"=>"CALIFORNIA","NY"=>"NEW YORK","PA"=>"PENNSYLVANIA","NH"=>"NEW HAMPSHIRE","MO"=>"MISSOURI","MA"=>"MASSACHUSETTS","RI"=>"RHODE ISLAND","UT"=>"UTAH","GA"=>"GEORGIA","TN"=>"TENNESSEE","OR"=>"OREGON","FL"=>"FLORIDA","HI"=>"HAWAII","MI"=>"MICHIGAN","SC"=>"SOUTH CAROLINA","MD"=>"MARYLAND","VT"=>"VERMONT","IL"=>"ILLINOIS","IN"=>"INDIANA","WI"=>"WISCONSIN","NM"=>"NEW MEXICO","NC"=>"NORTH CAROLINA","NJ"=>"NEW JERSEY","ID"=>"IDAHO","WA"=>"WASHINGTON","MN"=>"MINNESOTA","DC"=>"DISTRICT OF COLUMBIA","CO"=>"COLORADO","DE"=>"DELAWARE","AL"=>"ALABAMA","AZ"=>"ARIZONA","IA"=>"IOWA","KY"=>"KENTUCKY","NV"=>"NEVADA","AR"=>"ARKANSAS","MS"=>"MISSISSIPPI","KS"=>"KANSAS","OK"=>"OKLAHOMA","AK"=>"ALASKA","ME"=>"MAINE","NE"=>"NEBRASKA","MT"=>"MONTANA","WV"=>"WEST VIRGINIA","SD"=>"SOUTH DAKOTA","WY"=>"WYOMING","ND"=>"NORTH DAKOTA"}
                  @statescode={"LOUISIANA"=>"LA", "WEST VIRGINIA"=>"WV", "NEW HAMPSHIRE"=>"NH", "ILLINOIS"=>"IL", "ARIZONA"=>"AZ", "MINNESOTA"=>"MN", "ALASKA"=>"AK", "MONTANA"=>"MT", "MICHIGAN"=>"MI", "OKLAHOMA"=>"OK", "SOUTH CAROLINA"=>"SC", "MAINE"=>"ME", "DELAWARE"=>"DE", "NEVADA"=>"NV", "KANSAS"=>"KS", "MISSISSIPPI"=>"MS", "TENNESSEE"=>"TN", "DISTRICT OF COLUMBIA"=>"DC", "PENNSYLVANIA"=>"PA", "HAWAII"=>"HI", "VERMONT"=>"VT", "OREGON"=>"OR", "WASHINGTON"=>"WA", "WISCONSIN"=>"WI", "SOUTH DAKOTA"=>"SD", "IOWA"=>"IA", "VIRGINIA"=>"VA", "NORTH CAROLINA"=>"NC", "CALIFORNIA"=>"CA", "IDAHO"=>"ID", "KENTUCKY"=>"KY", "WYOMING"=>"WY", "MARYLAND"=>"MD", "CONNECTICUT"=>"CT", "FLORIDA"=>"FL", "TEXAS"=>"TX", "MISSOURI"=>"MO", "MASSACHUSETTS"=>"MA", "ARKANSAS"=>"AR", "GEORGIA"=>"GA", "NEBRASKA"=>"NE", "NEW YORK"=>"NY", "NEW JERSEY"=>"NJ", "OHIO"=>"OH", "RHODE ISLAND"=>"RI", "COLORADO"=>"CO", "ALABAMA"=>"AL", "NORTH DAKOTA"=>"ND", "UTAH"=>"UT", "NEW MEXICO"=>"NM", "INDIANA"=>"IN"}
                  @adv_name=params[:advertiser]['name'] unless params[:advertiser]==nil
                  @state=params[:analytics_state]['state_name'].strip unless params[:analytics_state]==nil
                  @limit=(params[:limit]==nil ||  params[:limit]=='') ? 0 : params[:limit].to_i
                  @offset=(params[:offset]==nil ||  params[:offset]=='') ? (params[:show]==nil ||  params[:show]=='') ? 100 : params[:show].to_i  : params[:offset].to_i
                  advertiser=Advertiser.find_by_name(@adv_name) if @adv_name!='' and @adv_name!=nil
                  @geo_chart=us_geo_chart(@start_date,@end_date,@duration,@adv_name)
                  # set the advertiser details in cache
                  @adv_details=AnalyticsData.advertiser_data_get()
                  if @adv_details==nil or @adv_details==""
                      @adv_details =get_advertiser_detail()
                      AnalyticsData.advertiser_data_set(@adv_details)
                  end
                  search=Hash.new
                  #form conditional statement for mongodb
                  search.store("dt",@delivery_date) if @delivery_date!=nil and @delivery_date!=''
                  search.store("aid","#{advertiser.id}") if advertiser!=nil and advertiser!=''
                  search.store("st","#{@statescode[@state]}") if (@statescode[@state]!=nil and @statescode[@state]!='')
                  search.store("st","#{@state}") if ((@state!=nil and @state!='') and (@statescode[@state]==nil or @statescode[@state]==''))
                  search.store("aid","#{@adv_name}") if ((@adv_name!=nil and @adv_name!='') and (advertiser==nil or advertiser==''))
                  #~ #open mongodb connection
                  db   = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
                  coll = db.collection('us_geostats')
                  @us_data=coll.find(search).sort([:fl ,Mongo::DESCENDING]).skip(@limit).limit(@offset)
                  @max_limit=@us_data.count()
                  #for manual pagination
                  @paginate_url = "/admin_analytic/us_geo_states?adv=#{@adv_name}&state=#{@state}&start_date=#{@start_date}&end_date=#{@end_date}&duration=#{@duration}"
                  render :action=>"us_geo_states"
              else
                  flash[:notice]="Your are not an authorized user. Please login with different username."
                  redirect_to :controller=>'login'
              end
          end
      rescue Exception=>e
          puts "Error : /admin_analytic_controller/us_geo_states_search : #{e.to_s}"
      end
    end
    #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    #Method Name: us_geo_cities
    #Purpose: this method is used to fetch city wise data for US.
    #Version: 2.3 
    #Author: Shujauddeen/Mangai
    #Last Modified: 21-Oct-2010 by Shujauddeen
    #Notes: None
    #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------        
    def us_geo_cities
       begin
            @aes = AESSecurity.new() #creating an object for AES Security
            if (session[:user_id]==nil)
                flash[:notice]="Your session has expired. Please login again."
                redirect_to :controller=>'login', :action=>'login'
            else
                if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                    @mongo_datepicker=true
                    @statesname={"CT"=>"CONNECTICUT","LA"=>"LOUISIANA","VA"=>"VIRGINIA","TX"=>"TEXAS","OH"=>"OHIO","CA"=>"CALIFORNIA","NY"=>"NEW YORK","PA"=>"PENNSYLVANIA","NH"=>"NEW HAMPSHIRE","MO"=>"MISSOURI","MA"=>"MASSACHUSETTS","RI"=>"RHODE ISLAND","UT"=>"UTAH","GA"=>"GEORGIA","TN"=>"TENNESSEE","OR"=>"OREGON","FL"=>"FLORIDA","HI"=>"HAWAII","MI"=>"MICHIGAN","SC"=>"SOUTH CAROLINA","MD"=>"MARYLAND","VT"=>"VERMONT","IL"=>"ILLINOIS","IN"=>"INDIANA","WI"=>"WISCONSIN","NM"=>"NEW MEXICO","NC"=>"NORTH CAROLINA","NJ"=>"NEW JERSEY","ID"=>"IDAHO","WA"=>"WASHINGTON","MN"=>"MINNESOTA","DC"=>"DISTRICT OF COLUMBIA","CO"=>"COLORADO","DE"=>"DELAWARE","AL"=>"ALABAMA","AZ"=>"ARIZONA","IA"=>"IOWA","KY"=>"KENTUCKY","NV"=>"NEVADA","AR"=>"ARKANSAS","MS"=>"MISSISSIPPI","KS"=>"KANSAS","OK"=>"OKLAHOMA","AK"=>"ALASKA","ME"=>"MAINE","NE"=>"NEBRASKA","MT"=>"MONTANA","WV"=>"WEST VIRGINIA","SD"=>"SOUTH DAKOTA","WY"=>"WYOMING","ND"=>"NORTH DAKOTA"}
                    @start_date= (params[:start_date]==nil || params[:start_date]=="") ? Time.now.strftime("%d-%m-%Y") : params[:start_date]
                    @end_date= (params[:end_date]==nil || params[:end_date]=="") ? Time.now.strftime("%d-%m-%Y") : params[:end_date]
                    @duration=(params[:duration]==nil || params[:duration]=="") ? '0' : params[:duration]
                    @delivery_date={"$gte" => "#{Time.parse(@start_date).strftime("%Y-%m-%d")}", "$lte" => "#{Time.parse(@end_date).strftime("%Y-%m-%d")}"} 
                    @state=params[:state]
                    @city=params[:city]
                    @flag=params[:flag]
                    @advertiser=params[:adv]
                    if params[:frm]=='link'
                        @display_adv= (@advertiser==nil or @advertiser=='' or @advertiser=='0') ? 'Unknown' : @advertiser
                        @display_state= (@state==nil or @state=='' or @state=='Unknown') ? 'Unknown' : @statesname[@state]
                    elsif params[:frm]=='chart'
                        @display_adv= (@advertiser==nil or @advertiser=='' or @advertiser=='0') ? '' : @advertiser
                        @display_state= (@state==nil or @state=='' or @state=='Unknown') ? 'Unknown' : @statesname[@state]
                    elsif params[:frm]=='disp'
                      @display_adv= (@advertiser==nil or @advertiser=='' or @advertiser=='0') ? 'Unknown' : @advertiser
                    end
                    @campaign=params[:camp] if (params[:camp]!=nil && params[:camp]!='')
                    @geo_chart=us_geo_chart(@start_date,@end_date,@duration,@advertiser,@flag)
                    # set the advertiser details in cache
                    @adv_details=AnalyticsData.advertiser_data_get()
                    if @adv_details==nil or @adv_details==""
                        @adv_details =get_advertiser_detail()
                        AnalyticsData.advertiser_data_set(@adv_details)
                    end
                    #form search parameter  
                    search=Hash.new
                    advertiser=Advertiser.find_by_name(@advertiser) if @advertiser!=nil and @advertiser!=''
                    campaign=Campaign.find_by_campaign_name(@campaign) if @campaign!=nil and @campaign!=''
                    search.store("dt",@delivery_date) if @delivery_date!=nil and @delivery_date!=''
                    search.store("aid","#{advertiser.id}") if advertiser!=nil and advertiser!=''
                    search.store("aid","0") if @advertiser.to_s=='0'
                    search.store("st","#{@state}") if @state!=nil and @state!=''
                    search.store("st","") if @state=='Unknown'
                    search.store("ct","#{@city}") if @city!=nil and @city!=''
                    search.store("caid","#{campaign.id}") if campaign!=nil and campaign!=''
                    search.store("caid","0") if @campaign.to_s=='0'
                    @limit=(params[:limit]==nil ||  params[:limit]=='') ? 0 : params[:limit].to_i
                    @offset=(params[:offset]==nil ||  params[:offset]=='') ? 100 : params[:offset].to_i
                    #open mongodb connection
                    db  = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
                    coll = db.collection("us_geostats")
                    @us_details=coll.find(search).sort([:fl ,Mongo::DESCENDING]).skip(@limit).limit(@offset)
                    @max_limit=@us_details.count()
                    @paginate_url = "/admin_analytic/us_geo_cities?adv=#{@advertiser}&flag=#{@flag}&camp=#{@campaign}&state=#{@state}&city=#{@city}&start_date=#{@start_date}&end_date=#{@end_date}&duration=#{@duration}&frm=#{params[:frm]}"
                    #~ render :layout=>false
                    #~ @state='Unknown' if params[:frm]=='link'
                else
                    flash[:notice]="Your are not an authorized user. Please login with different username."
                    redirect_to :controller=>'login'
                end
            end
        rescue Exception=>e
            puts "Error occured in us_geo_cities method :: #{e}"
        end
      end
    
    #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    #Method Name: us_geo_cities_search
    #Purpose: this method is used to search city wise data for US.
    #Version: 2.3 
    #Author: Shujauddeen/Mangai
    #Last Modified: 21-Oct-2010 by Shujauddeen
    #Notes: None
    #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------        
    def us_geo_cities_search
         begin
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                  @mongo_datepicker=true
                  @statesname={"CT"=>"CONNECTICUT","LA"=>"LOUISIANA","VA"=>"VIRGINIA","TX"=>"TEXAS","OH"=>"OHIO","CA"=>"CALIFORNIA","NY"=>"NEW YORK","PA"=>"PENNSYLVANIA","NH"=>"NEW HAMPSHIRE","MO"=>"MISSOURI","MA"=>"MASSACHUSETTS","RI"=>"RHODE ISLAND","UT"=>"UTAH","GA"=>"GEORGIA","TN"=>"TENNESSEE","OR"=>"OREGON","FL"=>"FLORIDA","HI"=>"HAWAII","MI"=>"MICHIGAN","SC"=>"SOUTH CAROLINA","MD"=>"MARYLAND","VT"=>"VERMONT","IL"=>"ILLINOIS","IN"=>"INDIANA","WI"=>"WISCONSIN","NM"=>"NEW MEXICO","NC"=>"NORTH CAROLINA","NJ"=>"NEW JERSEY","ID"=>"IDAHO","WA"=>"WASHINGTON","MN"=>"MINNESOTA","DC"=>"DISTRICT OF COLUMBIA","CO"=>"COLORADO","DE"=>"DELAWARE","AL"=>"ALABAMA","AZ"=>"ARIZONA","IA"=>"IOWA","KY"=>"KENTUCKY","NV"=>"NEVADA","AR"=>"ARKANSAS","MS"=>"MISSISSIPPI","KS"=>"KANSAS","OK"=>"OKLAHOMA","AK"=>"ALASKA","ME"=>"MAINE","NE"=>"NEBRASKA","MT"=>"MONTANA","WV"=>"WEST VIRGINIA","SD"=>"SOUTH DAKOTA","WY"=>"WYOMING","ND"=>"NORTH DAKOTA"}
                  @start_date= (params[:start_date]==nil || params[:start_date]=="") ? Time.now.strftime("%d-%m-%Y") : params[:start_date]
                  @end_date= (params[:end_date]==nil || params[:end_date]=="") ? Time.now.strftime("%d-%m-%Y") : params[:end_date]
                  @duration=(params[:duration]==nil || params[:duration]=="") ? '0' : params[:duration]
                  @delivery_date={"$gte" => "#{Time.parse(@start_date).strftime("%Y-%m-%d")}", "$lte" => "#{Time.parse(@end_date).strftime("%Y-%m-%d")}"} 
                  @advertiser=params[:advertiser]['name'] unless params[:advertiser]==nil
                  @city=params[:analytics_city]['city_name'] unless params[:analytics_city]==nil
                  @limit=(params[:limit]==nil ||  params[:limit]=='') ? 0 : params[:limit].to_i
                  @offset=(params[:offset]==nil ||  params[:offset]=='') ? (params[:show]==nil ||  params[:show]=='') ? 100 : params[:show].to_i  : params[:offset].to_i
                  @flag='true'
                  @display_adv=@advertiser
                  # set the advertiser details in cache
                  @geo_chart=us_geo_chart(@start_date,@end_date,@duration,@advertiser,@flag)
                  @state=''
                  @adv_details=AnalyticsData.advertiser_data_get()
                  if @adv_details==nil or @adv_details==""
                      @adv_details =get_advertiser_detail()
                      AnalyticsData.advertiser_data_set(@adv_details)
                  end
                  advertiser=Advertiser.find_by_name(@advertiser) if @advertiser!='' and @advertiser!=nil
                  search=Hash.new
                  #form conditional statement for mongodb
                  search.store("dt",@delivery_date) if @delivery_date!=nil and @delivery_date!=''
                  search.store("aid","#{advertiser.id}") if advertiser!=nil and advertiser!=''
                  search.store("st","#{@state}") if @state!=nil and @state!=''
                  search.store("ct","#{@city}") if @city!=nil and @city!=''
                  #~ #open mongodb connection
                  db   = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
                  coll = db.collection('us_geostats')
                  @us_details=coll.find(search).sort([:fl ,Mongo::DESCENDING]).skip(@limit).limit(@offset)
                  @max_limit=@us_details.count()
                  #for manual pagination
                  @paginate_url = "/admin_analytic/us_geo_cities?adv=#{@advertiser}&flag=#{@flag}&city=#{@city}&start_date=#{@start_date}&end_date=#{@end_date}&duration=#{@duration}#{(@advertiser==nil or @advertiser=='') ? '' : '&frm=disp'}"
                  render :action=>"us_geo_cities"
              else
                  flash[:notice]="Your are not an authorized user. Please login with different username."
                  redirect_to :controller=>'login'
              end
          end
      rescue Exception=>e
          puts "Error : /admin_analytic_controller/us_geo_cities_search : #{e.to_s}"
      end
    end
    #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Method Name: us_geo_chart
  #Purpose: this method is used to draw pie-chart for no-ads 
  #Version: 2.3 
  #Author: Shujauddeen
  #Last Modified: 30-Sep-2010 by Shujauddeen
  #Notes: None
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------        
    def us_geo_chart(*args)
        begin
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                 start_date=args[0]
                  end_date=args[1]
                  duration=args[2]
                  delivery_time={"$gte" => "#{Time.parse(start_date).strftime("%Y-%m-%d")}", "$lte" => "#{Time.parse(end_date).strftime("%Y-%m-%d")}"} 
                  advertiser=args[3] if args[3]!=nil and args[3]!=''
                  #initialize colors for piechart
                  adv=Advertiser.find_by_name(advertiser) if advertiser!='' and advertiser!=nil
                  search=Hash.new
                  #form search parameter
                  search.store("dt",delivery_time) if delivery_time!=nil and delivery_time!=''
                  search.store("aid","#{adv.id}") if adv!=nil and adv!=""
                  puts search.inspect
                  db   = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
                  coll = db.collection('us_geostats')
                  geostats=coll.group(['st'], search, {'fl' => 0},  "function(doc, prev) { prev.fl += doc.fl}")
                  chart_data="<map hoverColor='01B401' formatNumberScale='0' useSNameInLabels='1' showCanvasBorder='0' includeValueInLables='0'  showPercentageValues='1' fillColor='FFFFFF' defaultAnimation='0' showShadow='0' showBevel='0' leftMargin='5' ><data>"
                  count=0
                  for geo in geostats
                      if count<geo['fl'].to_i 
                          count=geo['fl'].to_i if geo['st']!=nil and geo['st']!=''
                      end
                      chart_data+="<entity id='#{geo['st']}' value='#{geo['fl']}' link='/admin_analytic/us_geo_cities%3Fstart_date=#{start_date}%26end_date=#{end_date}%26duration=#{duration}%26adv=#{(adv==nil or adv=='') ? '' : adv.name}%26state=#{geo['st']}%26frm=chart#{args[2]=='true' ? '%26flag=true' : ''}'/>" if (geo['fl'].to_i>0 and geo['st']!=nil and geo['st']!='')
                  end
                  chart_data+="</data>"
                  chart_data+="<colorRange><color minValue='0' maxValue='#{(count/3)}' displayValue='Low' color='A7FF98' /><color minValue='#{((count/3))}' maxValue='#{(count-(count/3))}' displayValue='Moderate' color='2CCE00' /><color minValue='#{(count-(count/3))}' maxValue='#{(count)+1}' displayValue='High' color='007700' /></colorRange></map>"  
                  return chart_data
              else
                  flash[:notice]="Your are not an authorized user. Please login with different username."
                  redirect_to :controller=>'login'
              end
          end
        rescue Exception=>e
            puts "Error occured in us_geo_chart method :: #{e}"
        end
    end
    
    #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Method Name:pub_geo_states
  #Purpose: this method is used to fetch dma details for publishers
  #Version: 2.3 
  #Author: Shujauddeen/Mangai
  #Last Modified: 13-Oct-2010 by Shujauddeen
  #Notes: None
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------        
    
   def pub_geo_states
      begin
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                  @mongo_datepicker=true
                  @start_date= (params[:start_date]==nil || params[:start_date]=="") ? Time.now.strftime("%d-%b-%Y") : params[:start_date]
                  @end_date= (params[:end_date]==nil || params[:end_date]=="") ? Time.now.strftime("%d-%b-%Y") : params[:end_date]
                  @statesname={"CT"=>"CONNECTICUT","LA"=>"LOUISIANA","VA"=>"VIRGINIA","TX"=>"TEXAS","OH"=>"OHIO","CA"=>"CALIFORNIA","NY"=>"NEW YORK","PA"=>"PENNSYLVANIA","NH"=>"NEW HAMPSHIRE","MO"=>"MISSOURI","MA"=>"MASSACHUSETTS","RI"=>"RHODE ISLAND","UT"=>"UTAH","GA"=>"GEORGIA","TN"=>"TENNESSEE","OR"=>"OREGON","FL"=>"FLORIDA","HI"=>"HAWAII","MI"=>"MICHIGAN","SC"=>"SOUTH CAROLINA","MD"=>"MARYLAND","VT"=>"VERMONT","IL"=>"ILLINOIS","IN"=>"INDIANA","WI"=>"WISCONSIN","NM"=>"NEW MEXICO","NC"=>"NORTH CAROLINA","NJ"=>"NEW JERSEY","ID"=>"IDAHO","WA"=>"WASHINGTON","MN"=>"MINNESOTA","DC"=>"DISTRICT OF COLUMBIA","CO"=>"COLORADO","DE"=>"DELAWARE","AL"=>"ALABAMA","AZ"=>"ARIZONA","IA"=>"IOWA","KY"=>"KENTUCKY","NV"=>"NEVADA","AR"=>"ARKANSAS","MS"=>"MISSISSIPPI","KS"=>"KANSAS","OK"=>"OKLAHOMA","AK"=>"ALASKA","ME"=>"MAINE","NE"=>"NEBRASKA","MT"=>"MONTANA","WV"=>"WEST VIRGINIA","SD"=>"SOUTH DAKOTA","WY"=>"WYOMING","ND"=>"NORTH DAKOTA"}
                  @statescode={"LOUISIANA"=>"LA", "WEST VIRGINIA"=>"WV", "NEW HAMPSHIRE"=>"NH", "ILLINOIS"=>"IL", "ARIZONA"=>"AZ", "MINNESOTA"=>"MN", "ALASKA"=>"AK", "MONTANA"=>"MT", "MICHIGAN"=>"MI", "OKLAHOMA"=>"OK", "SOUTH CAROLINA"=>"SC", "MAINE"=>"ME", "DELAWARE"=>"DE", "NEVADA"=>"NV", "KANSAS"=>"KS", "MISSISSIPPI"=>"MS", "TENNESSEE"=>"TN", "DISTRICT OF COLUMBIA"=>"DC", "PENNSYLVANIA"=>"PA", "HAWAII"=>"HI", "VERMONT"=>"VT", "OREGON"=>"OR", "WASHINGTON"=>"WA", "WISCONSIN"=>"WI", "SOUTH DAKOTA"=>"SD", "IOWA"=>"IA", "VIRGINIA"=>"VA", "NORTH CAROLINA"=>"NC", "CALIFORNIA"=>"CA", "IDAHO"=>"ID", "KENTUCKY"=>"KY", "WYOMING"=>"WY", "MARYLAND"=>"MD", "CONNECTICUT"=>"CT", "FLORIDA"=>"FL", "TEXAS"=>"TX", "MISSOURI"=>"MO", "MASSACHUSETTS"=>"MA", "ARKANSAS"=>"AR", "GEORGIA"=>"GA", "NEBRASKA"=>"NE", "NEW YORK"=>"NY", "NEW JERSEY"=>"NJ", "OHIO"=>"OH", "RHODE ISLAND"=>"RI", "COLORADO"=>"CO", "ALABAMA"=>"AL", "NORTH DAKOTA"=>"ND", "UTAH"=>"UT", "NEW MEXICO"=>"NM", "INDIANA"=>"IN"}
                  @duration=(params[:duration]==nil || params[:duration]=="") ? '0' : params[:duration]
                  @delivery_date={"$gte" => "#{Time.parse(@start_date).strftime("%Y-%m-%d")}", "$lte" => "#{Time.parse(@end_date).strftime("%Y-%m-%d")}"}
                  @pub_name=params[:pub]
                  @state=params[:state]
                  @limit=(params[:limit]==nil ||  params[:limit]=='') ? 0 : params[:limit].to_i
                  @offset=(params[:offset]==nil ||  params[:offset]=='') ? ((params[:show]==nil ||  params[:show]=='') ? 100 : params[:show].to_i ) : params[:offset].to_i
                  # set the advertiser details in cache
                  @geo_chart=pub_geo_chart(@start_date,@end_date,@duration,@pub_name)
                  publisher=Publisher.find_by_publisher_name(@pub_name) if @pub_name!='' and @pub_name!=nil
                  # set the publisher detials in cache
                  @pub_details=AnalyticsData.publisher_data_get()
                  if @pub_details==nil or @pub_details==""
                        @pub_details= get_publisher_detail()
                        AnalyticsData.publisher_data_set(@pub_details)
                  end
                  search=Hash.new
                  #~ #form conditional statement for mongodb
                  search.store("dt",@delivery_date) if @delivery_date!=nil and @delivery_date!=''
                  search.store("pid","#{publisher.id}") if publisher!=nil and publisher!=''
                  search.store("st","#{@statescode[@state]}") if @state!=nil and @state!=''
                  #~ #open mongodb connection
                  db = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
                  coll = db.collection('pub_us_geostats')
                  @pub_data=coll.find(search).sort([:fl ,Mongo::DESCENDING]).skip(@limit).limit(@offset)
                  @max_limit=@pub_data.count()
                  #~ #for manual pagination
                  @paginate_url = "/admin_analytic/pub_geo_states?pub=#{@pub_name}&state=#{@state}&start_date=#{@start_date}&end_date=#{@end_date}&duration=#{@duration}"
                  render :action=>"pub_geo_states"
              else
                  flash[:notice]="Your are not an authorized user. Please login with different username."
                  redirect_to :controller=>'login'
              end
          end
      rescue Exception=>e
          puts "Error : /admin_analytic_controller/pub_geo_states : #{e.to_s}"
      end
  end
    
    #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    #Method Name: pub_geo_states_search
    #Purpose: this method is used to fetch dma search details.
    #Version: 2.3 
    #Author: Shujauddeen/Mangai
    #Last Modified: 21-Oct-2010 by Shujauddeen
    #Notes: None
    #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------        
   def pub_geo_states_search
       begin
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                  @duration=(params[:duration]==nil || params[:duration]=="") ? '0' : params[:duration]
                  @start_date= (params[:start_date]==nil || params[:start_date]=="") ? Time.now.strftime("%d-%b-%Y") : params[:start_date]
                  @end_date= (params[:end_date]==nil || params[:end_date]=="") ? Time.now.strftime("%d-%b-%Y") : params[:end_date]
                  @delivery_date={"$gte" => "#{Time.parse(@start_date).strftime("%Y-%m-%d")}", "$lte" => "#{Time.parse(@end_date).strftime("%Y-%m-%d")}"}
                  @mongo_datepicker=true
                  @statesname={"CT"=>"CONNECTICUT","LA"=>"LOUISIANA","VA"=>"VIRGINIA","TX"=>"TEXAS","OH"=>"OHIO","CA"=>"CALIFORNIA","NY"=>"NEW YORK","PA"=>"PENNSYLVANIA","NH"=>"NEW HAMPSHIRE","MO"=>"MISSOURI","MA"=>"MASSACHUSETTS","RI"=>"RHODE ISLAND","UT"=>"UTAH","GA"=>"GEORGIA","TN"=>"TENNESSEE","OR"=>"OREGON","FL"=>"FLORIDA","HI"=>"HAWAII","MI"=>"MICHIGAN","SC"=>"SOUTH CAROLINA","MD"=>"MARYLAND","VT"=>"VERMONT","IL"=>"ILLINOIS","IN"=>"INDIANA","WI"=>"WISCONSIN","NM"=>"NEW MEXICO","NC"=>"NORTH CAROLINA","NJ"=>"NEW JERSEY","ID"=>"IDAHO","WA"=>"WASHINGTON","MN"=>"MINNESOTA","DC"=>"DISTRICT OF COLUMBIA","CO"=>"COLORADO","DE"=>"DELAWARE","AL"=>"ALABAMA","AZ"=>"ARIZONA","IA"=>"IOWA","KY"=>"KENTUCKY","NV"=>"NEVADA","AR"=>"ARKANSAS","MS"=>"MISSISSIPPI","KS"=>"KANSAS","OK"=>"OKLAHOMA","AK"=>"ALASKA","ME"=>"MAINE","NE"=>"NEBRASKA","MT"=>"MONTANA","WV"=>"WEST VIRGINIA","SD"=>"SOUTH DAKOTA","WY"=>"WYOMING","ND"=>"NORTH DAKOTA"}
                  @statescode={"LOUISIANA"=>"LA", "WEST VIRGINIA"=>"WV", "NEW HAMPSHIRE"=>"NH", "ILLINOIS"=>"IL", "ARIZONA"=>"AZ", "MINNESOTA"=>"MN", "ALASKA"=>"AK", "MONTANA"=>"MT", "MICHIGAN"=>"MI", "OKLAHOMA"=>"OK", "SOUTH CAROLINA"=>"SC", "MAINE"=>"ME", "DELAWARE"=>"DE", "NEVADA"=>"NV", "KANSAS"=>"KS", "MISSISSIPPI"=>"MS", "TENNESSEE"=>"TN", "DISTRICT OF COLUMBIA"=>"DC", "PENNSYLVANIA"=>"PA", "HAWAII"=>"HI", "VERMONT"=>"VT", "OREGON"=>"OR", "WASHINGTON"=>"WA", "WISCONSIN"=>"WI", "SOUTH DAKOTA"=>"SD", "IOWA"=>"IA", "VIRGINIA"=>"VA", "NORTH CAROLINA"=>"NC", "CALIFORNIA"=>"CA", "IDAHO"=>"ID", "KENTUCKY"=>"KY", "WYOMING"=>"WY", "MARYLAND"=>"MD", "CONNECTICUT"=>"CT", "FLORIDA"=>"FL", "TEXAS"=>"TX", "MISSOURI"=>"MO", "MASSACHUSETTS"=>"MA", "ARKANSAS"=>"AR", "GEORGIA"=>"GA", "NEBRASKA"=>"NE", "NEW YORK"=>"NY", "NEW JERSEY"=>"NJ", "OHIO"=>"OH", "RHODE ISLAND"=>"RI", "COLORADO"=>"CO", "ALABAMA"=>"AL", "NORTH DAKOTA"=>"ND", "UTAH"=>"UT", "NEW MEXICO"=>"NM", "INDIANA"=>"IN"}
                  @pub_name=params[:publisher]['publisher_name'] unless params[:publisher]==nil
                  @state=params[:analytics_state]['state_name'].strip unless params[:analytics_state]==nil
                  @limit=(params[:limit]==nil ||  params[:limit]=='') ? 0 : params[:limit].to_i
                  @offset=(params[:offset]==nil ||  params[:offset]=='') ? (params[:show]==nil ||  params[:show]=='') ? 100 : params[:show].to_i  : params[:offset].to_i
                  @geo_chart=pub_geo_chart(@start_date,@end_date,@duration,@pub_name)
                  publisher=Publisher.find_by_publisher_name(@pub_name) if @pub_name!='' and @pub_name!=nil
                  # set the publisher detials in cache
                  @pub_details=AnalyticsData.publisher_data_get()
                  if @pub_details==nil or @pub_details==""
                        @pub_details= get_publisher_detail()
                        AnalyticsData.publisher_data_set(@pub_details)
                  end
                  search=Hash.new
                  #form conditional statement for mongodb
                  search.store("dt",@delivery_date) if @delivery_date!=nil and @delivery_date!=''
                  search.store("pid","#{publisher.id}") if publisher!=nil and publisher!=''
                  search.store("st","#{@statescode[@state]}") if (@statescode[@state]!=nil and @statescode[@state]!='')
                  search.store("st","#{@state}") if ((@state!=nil and @state!='') and (@statescode[@state]==nil or @statescode[@state]==''))
                  search.store("pid","#{@pub_name}") if ((@pub_name!=nil and @pub_name!='') and (publisher==nil or publisher==''))
                  #~ #open mongodb connection
                  db   = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
                  coll = db.collection('pub_us_geostats')
                  @pub_data=coll.find(search).sort([:fl ,Mongo::DESCENDING]).skip(@limit).limit(@offset)
                  @max_limit=@pub_data.count()
                  #for manual pagination
                  @paginate_url = "/admin_analytic/pub_geo_states?pub=#{@pub_name}&state=#{@state}&start_date=#{@start_date}&end_date=#{@end_date}&duration=#{@duration}"
                  render :action=>"pub_geo_states"
              else
                  flash[:notice]="Your are not an authorized user. Please login with different username."
                  redirect_to :controller=>'login'
              end
          end
      rescue Exception=>e
          puts "Error : /admin_analytic_controller/pub_geo_states_search : #{e.to_s}"
      end
    end
    #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    #Method Name: pub_geo_cities
    #Purpose: this method is used to fetch city wise data for US.
    #Version: 2.3 
    #Author: Shujauddeen/Mangai
    #Last Modified: 21-Oct-2010 by Shujauddeen
    #Notes: None
    #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------        
    def pub_geo_cities
       begin
            @aes = AESSecurity.new() #creating an object for AES Security
            if (session[:user_id]==nil)
                flash[:notice]="Your session has expired. Please login again."
                redirect_to :controller=>'login', :action=>'login'
            else
                if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                    @mongo_datepicker=true
                    @start_date= (params[:start_date]==nil || params[:start_date]=="") ? Time.now.strftime("%d-%b-%Y") : params[:start_date]
                    @end_date= (params[:end_date]==nil || params[:end_date]=="") ? Time.now.strftime("%d-%b-%Y") : params[:end_date]
                    @statesname={"CT"=>"CONNECTICUT","LA"=>"LOUISIANA","VA"=>"VIRGINIA","TX"=>"TEXAS","OH"=>"OHIO","CA"=>"CALIFORNIA","NY"=>"NEW YORK","PA"=>"PENNSYLVANIA","NH"=>"NEW HAMPSHIRE","MO"=>"MISSOURI","MA"=>"MASSACHUSETTS","RI"=>"RHODE ISLAND","UT"=>"UTAH","GA"=>"GEORGIA","TN"=>"TENNESSEE","OR"=>"OREGON","FL"=>"FLORIDA","HI"=>"HAWAII","MI"=>"MICHIGAN","SC"=>"SOUTH CAROLINA","MD"=>"MARYLAND","VT"=>"VERMONT","IL"=>"ILLINOIS","IN"=>"INDIANA","WI"=>"WISCONSIN","NM"=>"NEW MEXICO","NC"=>"NORTH CAROLINA","NJ"=>"NEW JERSEY","ID"=>"IDAHO","WA"=>"WASHINGTON","MN"=>"MINNESOTA","DC"=>"DISTRICT OF COLUMBIA","CO"=>"COLORADO","DE"=>"DELAWARE","AL"=>"ALABAMA","AZ"=>"ARIZONA","IA"=>"IOWA","KY"=>"KENTUCKY","NV"=>"NEVADA","AR"=>"ARKANSAS","MS"=>"MISSISSIPPI","KS"=>"KANSAS","OK"=>"OKLAHOMA","AK"=>"ALASKA","ME"=>"MAINE","NE"=>"NEBRASKA","MT"=>"MONTANA","WV"=>"WEST VIRGINIA","SD"=>"SOUTH DAKOTA","WY"=>"WYOMING","ND"=>"NORTH DAKOTA"}
                    @duration=(params[:duration]==nil || params[:duration]=="") ? '0' : params[:duration]
                    @delivery_date={"$gte" => "#{Time.parse(@start_date).strftime("%Y-%m-%d")}", "$lte" => "#{Time.parse(@end_date).strftime("%Y-%m-%d")}"}
                    @state=params[:state]
                    @city=params[:city]
                    @flag=params[:flag]
                    @pub_name=params[:pub]
                    @adclient=params[:adclient] if (params[:adclient]!=nil && params[:adclient]!='')
                    if params[:frm]=='link'
                        @display_pub= (@pub_name==nil or @pub_name=='' or @pub_name=='0') ? 'Unknown' : @pub_name
                        @display_state= (@state==nil or @state=='' or @state=='Unknown') ? 'Unknown' : @statesname[@state]
                    elsif params[:frm]=='chart'
                        @display_pub= (@pub_name==nil or @pub_name=='' or @pub_name=='0') ? '' : @pub_name
                        @display_state= (@state==nil or @state=='' or @state=='Unknown') ? 'Unknown' : @statesname[@state]
                    elsif params[:frm]=='disp'
                      @display_pub= (@pub_name==nil or @pub_name=='' or @pub_name=='0') ? 'Unknown' : @pub_name
                    end
                    publisher=Publisher.find_by_publisher_name(@pub_name) if @pub_name!='' and @pub_name!=nil
                    @geo_chart=pub_geo_chart(@start_date,@end_date,@duration,@pub_name,@flag)
                    @pub_details=AnalyticsData.publisher_data_get()
                    if @pub_details==nil or @pub_details==""
                        @pub_details= get_publisher_detail()
                        AnalyticsData.publisher_data_set(@pub_details)
                    end
                    
                    #form search parameter  
                    search=Hash.new
                    client=Adclient.find(:all, :conditions => ['app_name = ? AND status <> ?',   @adclient, 'Deleted']) if @adclient!='' and @adclient!=nil
                    search.store("dt",@delivery_date) if @delivery_date!=nil and @delivery_date!=''
                    search.store("pid","#{publisher.id}") if publisher!=nil and publisher!=''
                    search.store("pid","0") if @pub_name.to_s=='0'
                    search.store("st","#{@state}") if @state!=nil and @state!=''
                    search.store("st","") if @state=='Unknown'
                    search.store("ct","#{@city}") if @city!=nil and @city!=''
                    search.store("cid","#{client[0].id}") if client!=nil and client!=''
                    search.store("cid","0") if @adclient.to_s=='0'
                    @limit=(params[:limit]==nil ||  params[:limit]=='') ? 0 : params[:limit].to_i
                    @offset=(params[:offset]==nil ||  params[:offset]=='') ? 100 : params[:offset].to_i
                    #open mongodb connection
                    db  = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
                    coll = db.collection("pub_us_geostats")
                    @pub_geodetails=coll.find(search).sort([:fl ,Mongo::DESCENDING]).skip(@limit).limit(@offset)
                    @max_limit=@pub_geodetails.count()
                    @paginate_url = "/admin_analytic/pub_geo_cities?pub=#{@pub_name}&flag=#{@flag}&adclient=#{@adclient}&state=#{@state}&city=#{@city}&start_date=#{@start_date}&end_date=#{@end_date}&duration=#{@duration}&frm=#{params[:frm]}"
                    #~ render :layout=>false
                    #~ @state='Unknown' if params[:frm]=='link'
                else
                    flash[:notice]="Your are not an authorized user. Please login with different username."
                    redirect_to :controller=>'login'
                end
            end
        rescue Exception=>e
            puts "Error occured in pub_geo_cities method :: #{e}"
        end
      end
    
    #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    #Method Name: pub_geo_cities_search
    #Purpose: this method is used to search city wise data for US.
    #Version: 2.3 
    #Author: Shujauddeen/Mangai
    #Last Modified: 21-Oct-2010 by Shujauddeen
    #Notes: None
    #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------        
    def pub_geo_cities_search
         begin
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                  @mongo_datepicker=true
                  @statesname={"CT"=>"CONNECTICUT","LA"=>"LOUISIANA","VA"=>"VIRGINIA","TX"=>"TEXAS","OH"=>"OHIO","CA"=>"CALIFORNIA","NY"=>"NEW YORK","PA"=>"PENNSYLVANIA","NH"=>"NEW HAMPSHIRE","MO"=>"MISSOURI","MA"=>"MASSACHUSETTS","RI"=>"RHODE ISLAND","UT"=>"UTAH","GA"=>"GEORGIA","TN"=>"TENNESSEE","OR"=>"OREGON","FL"=>"FLORIDA","HI"=>"HAWAII","MI"=>"MICHIGAN","SC"=>"SOUTH CAROLINA","MD"=>"MARYLAND","VT"=>"VERMONT","IL"=>"ILLINOIS","IN"=>"INDIANA","WI"=>"WISCONSIN","NM"=>"NEW MEXICO","NC"=>"NORTH CAROLINA","NJ"=>"NEW JERSEY","ID"=>"IDAHO","WA"=>"WASHINGTON","MN"=>"MINNESOTA","DC"=>"DISTRICT OF COLUMBIA","CO"=>"COLORADO","DE"=>"DELAWARE","AL"=>"ALABAMA","AZ"=>"ARIZONA","IA"=>"IOWA","KY"=>"KENTUCKY","NV"=>"NEVADA","AR"=>"ARKANSAS","MS"=>"MISSISSIPPI","KS"=>"KANSAS","OK"=>"OKLAHOMA","AK"=>"ALASKA","ME"=>"MAINE","NE"=>"NEBRASKA","MT"=>"MONTANA","WV"=>"WEST VIRGINIA","SD"=>"SOUTH DAKOTA","WY"=>"WYOMING","ND"=>"NORTH DAKOTA"}
                  #~ @statescode={"LOUISIANA"=>"LA", "WEST VIRGINIA"=>"WV", "NEW HAMPSHIRE"=>"NH", "ILLINOIS"=>"IL", "ARIZONA"=>"AZ", "MINNESOTA"=>"MN", "ALASKA"=>"AK", "MONTANA"=>"MT", "MICHIGAN"=>"MI", "OKLAHOMA"=>"OK", "SOUTH CAROLINA"=>"SC", "MAINE"=>"ME", "DELAWARE"=>"DE", "NEVADA"=>"NV", "KANSAS"=>"KS", "MISSISSIPPI"=>"MS", "TENNESSEE"=>"TN", "DISTRICT OF COLUMBIA"=>"DC", "PENNSYLVANIA"=>"PA", "HAWAII"=>"HI", "VERMONT"=>"VT", "OREGON"=>"OR", "WASHINGTON"=>"WA", "WISCONSIN"=>"WI", "SOUTH DAKOTA"=>"SD", "IOWA"=>"IA", "VIRGINIA"=>"VA", "NORTH CAROLINA"=>"NC", "CALIFORNIA"=>"CA", "IDAHO"=>"ID", "KENTUCKY"=>"KY", "WYOMING"=>"WY", "MARYLAND"=>"MD", "CONNECTICUT"=>"CT", "FLORIDA"=>"FL", "TEXAS"=>"TX", "MISSOURI"=>"MO", "MASSACHUSETTS"=>"MA", "ARKANSAS"=>"AR", "GEORGIA"=>"GA", "NEBRASKA"=>"NE", "NEW YORK"=>"NY", "NEW JERSEY"=>"NJ", "OHIO"=>"OH", "RHODE ISLAND"=>"RI", "COLORADO"=>"CO", "ALABAMA"=>"AL", "NORTH DAKOTA"=>"ND", "UTAH"=>"UT", "NEW MEXICO"=>"NM", "INDIANA"=>"IN"}
                  @duration=(params[:duration]==nil || params[:duration]=="") ? '0' : params[:duration]
                  @start_date= (params[:start_date]==nil || params[:start_date]=="") ? Time.now.strftime("%d-%b-%Y") : params[:start_date]
                  @end_date= (params[:end_date]==nil || params[:end_date]=="") ? Time.now.strftime("%d-%b-%Y") : params[:end_date]
                  @delivery_date={"$gte" => "#{Time.parse(@start_date).strftime("%Y-%m-%d")}", "$lte" => "#{Time.parse(@end_date).strftime("%Y-%m-%d")}"}
                  @pub_name=params[:publisher]['publisher_name'] unless params[:publisher]==nil
                  @city=params[:analytics_city]['city_name'] unless params[:analytics_city]==nil
                  @limit=(params[:limit]==nil ||  params[:limit]=='') ? 0 : params[:limit].to_i
                  @offset=(params[:offset]==nil ||  params[:offset]=='') ? (params[:show]==nil ||  params[:show]=='') ? 100 : params[:show].to_i  : params[:offset].to_i
                  @flag='true'
                  @display_pub=@pub_name
                  # set the advertiser details in cache
                  @geo_chart=pub_geo_chart(@start_date,@end_date,@duration,@pub_name,@flag)
                  @state=''
                  @pub_details=AnalyticsData.publisher_data_get()
                    if @pub_details==nil or @pub_details==""
                        @pub_details= get_publisher_detail()
                        AnalyticsData.publisher_data_set(@pub_details)
                    end
                  publisher=Publisher.find_by_publisher_name(@pub_name) if @pub_name!='' and @pub_name!=nil
                  search=Hash.new
                  #form conditional statement for mongodb
                  search.store("dt",@delivery_date) if @delivery_date!=nil and @delivery_date!=''
                  search.store("pid","#{publisher.id}") if publisher!=nil and publisher!=''
                  search.store("st","#{@state}") if @state!=nil and @state!=''
                  search.store("ct","#{@city}") if @city!=nil and @city!=''
                  #~ #open mongodb connection
                  db   = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
                  coll = db.collection('pub_us_geostats')
                  @pub_geodetails=coll.find(search).sort([:fl ,Mongo::DESCENDING]).skip(@limit).limit(@offset)
                  @max_limit=@pub_geodetails.count()
                  #for manual pagination
                  @paginate_url = "/admin_analytic/pub_geo_cities?pub=#{@pub_name}&flag=#{@flag}&city=#{@city}&start_date=#{@start_date}&end_date=#{@end_date}&duration=#{@duration}#{(@pub_name==nil or @pub_name=='') ? '' : '&frm=disp'}"
                  render :action=>"pub_geo_cities"
              else
                  flash[:notice]="Your are not an authorized user. Please login with different username."
                  redirect_to :controller=>'login'
              end
          end
      rescue Exception=>e
          puts "Error : /admin_analytic_controller/pub_geo_cities_search : #{e.to_s}"
      end
    end
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Method Name: pub_geo_chart
  #Purpose: this method is used to draw pie-chart for publisher geo stats 
  #Version: 2.3 
  #Author: Shujauddeen
  #Last Modified: 30-Sep-2010 by Shujauddeen
  #Notes: None
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------        
    def pub_geo_chart(*args)
        begin
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],1,0)==0
                  start_date=args[0]
                  end_date=args[1]
                  duration=args[2]
                  delivery_time={"$gte" => "#{Time.parse(start_date).strftime("%Y-%m-%d")}", "$lte" => "#{Time.parse(end_date).strftime("%Y-%m-%d")}"} 
                  publisher=args[3] if args[3]!=nil and args[3]!=''
                  #initialize colors for piechart
                  pub=Publisher.find_by_publisher_name(publisher) if publisher!='' and publisher!=nil
                  search=Hash.new
                  #form search parameter
                  search.store("dt",delivery_time) if delivery_time!=nil and delivery_time!=''
                  search.store("pid","#{pub.id}") if pub!=nil and pub!=""
                  search.store("pid","") if (publisher!=nil and publisher!='') and (pub==nil or pub=="")
                  db   = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
                  coll = db.collection('pub_us_geostats')
                  geostats=coll.group(['st'], search, {'fl' => 0},  "function(doc, prev) { prev.fl += (doc.fl+doc.unfl)}")
                  chart_data="<map hoverColor='01B401' formatNumberScale='0' useSNameInLabels='1' showCanvasBorder='0' includeValueInLables='0'  showPercentageValues='1' fillColor='FFFFFF' defaultAnimation='0' showShadow='0' showBevel='0' leftMargin='5' ><data>"
                  count=0
                  for geo in geostats
                      if count<geo['fl'].to_i 
                          count=geo['fl'].to_i if geo['st']!=nil and geo['st']!=''
                      end
                      chart_data+="<entity id='#{geo['st']}' value='#{geo['fl']}' link='/admin_analytic/pub_geo_cities%3Fstart_date=#{start_date}%26end_date=#{end_date}%26duration=#{duration}%26pub=#{(pub==nil or pub=='') ? '' : pub.publisher_name}%26state=#{geo['st']}%26frm=chart#{args[2]=='true' ? '%26flag=true' : ''}'/>" if (geo['fl'].to_i>0 and geo['st']!=nil and geo['st']!='')
                  end
                  chart_data+="</data>"
                  chart_data+="<colorRange><color minValue='0' maxValue='#{(count/3)}' displayValue='Low' color='A7FF98' /><color minValue='#{((count/3))}' maxValue='#{(count-(count/3))}' displayValue='Moderate' color='2CCE00' /><color minValue='#{(count-(count/3))}' maxValue='#{(count)+1}' displayValue='High' color='007700' /></colorRange></map>"  
                  return chart_data
              else
                  flash[:notice]="Your are not an authorized user. Please login with different username."
                  redirect_to :controller=>'login'
              end
          end
        rescue Exception=>e
            puts "Error occured in pub_geo_chart method :: #{e}"
        end
      end
      
      #~ def generate_query(*args) #generate_query starts here
          
        #~ end 
  end
  
  
