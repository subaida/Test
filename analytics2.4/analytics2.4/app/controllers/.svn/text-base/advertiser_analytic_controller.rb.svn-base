=begin
  advertiser_analytic_controller.rb
  Author :  Sathish Kumar Sadhasivam
  Version:  1.0
  Created:  22-08-2008
	Last Modified: 20-09-2007 by Sathish Kumar Sadhasivam
 
  Copyright (c) 2006-2007 by CalChennai Mobile-worx  Pvt Ltd
 
  All rights reserved.
 
  1059 Opal Way, Gardena, CA 90247 
 
  Y222, 2nd Floor, 2nd Avenue, Anna Nagar, Chennai 600040
  www.mobile-worx.com
 
  ALL IPR including that of source code, design documents, algorithms, flow documents,project plans,
  reviews, images,architectural documents and other documents related to this document are held by
  mobile-worx and any modification, alteration,re-engineering, reverse engineering or
  any change targeted towards any kinds of use would be severely dealt with under the Federal Laws
  of United States of America & Republic of India

  Contact us at info@mobile-worx.com
  
  Version : 1.0
  Note    : The ads controller functions allow authorised users(advertisers)
            to add, delete, list and edit ads.

=end

#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#The AdvertiserAnalytic controller does the main action of generating and displaying the charts basis on request.
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@@obj = AdvertiserXmlBuilder.new()
require 'csv'
require 'fastercsv/lib/faster_csv'
require 'aes_security.rb' #this is to require AES security component

class AdvertiserAnalyticController < ApplicationController
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#Method Name: index
	#Purpose: redirecting to advertiser analytic home page.
	#Version: 1.0
	#Author: Sathish Kumar Sadhasivam
	#Last Modified: 20-Sep-2008 by Sathish Kumar Sadhasivam
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	def index
		redirect_to :action=>'advertiser_home',:analytic=>'refresh'
	end
	      
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
            if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
                verifyDBconnection
                @camp_id=@aes.decrypt(session[:key],session[:iv],params[:campaign_id])
                if @camp_id!='SMS' and @camp_id!='WAP'
                    @ad_list=Ad.find(:all,:conditions=>["campaign_id = ?",@camp_id])
                end
                render :layout=>false
              #~ render :update do |page|
                #~ page.replace "select_ad_id", :partial=>"get_adlist"
              #~ end
           else
                flash[:notice]="Your are not an authorized user. Please login with different username."
                redirect_to :controller=>'login'
            end
        end
      rescue Exception => e
          puts "DEBUGGER :: ERROR :: in advertiser_analytic_controller - get_ad_list method :: #{e.to_s}"
          render :layout=>false
      end
	end
	
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#Method Name: advertiser_home
	#Purpose: rendering the advertiser analytic home page.
	#Version: 1.0
	#Author: Sathish Kumar Sadhasivam
	#Last Modified: 08-Oct-2008 by Sathish Kumar Sadhasivam
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    def advertiser_home
      begin
          @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
                  @analytic=params[:analytic]
                  user_id = @aes.decrypt(session[:key],session[:iv],session[:user_id])
                  @enddate=(params[:edate]!=nil && params[:edate]!='') ? Time.parse(params[:edate]).strftime("%d-%b-%Y") : (Time.now-86400).strftime("%d-%b-%Y")
                  @startdate= (params[:sdate]!=nil && params[:sdate]!='') ? Time.parse(params[:sdate]).strftime("%d-%b-%Y") : (Time.now-86400).strftime("%d-%b-%Y")
                  verifyDBconnection
                  if @analytic=='refresh'
                      redirect_to :action=>'generate_adv_report',:campaign_id=>params[:camp_id]!=nil ? params[:camp_id] : @aes.encrypt(session[:key],session[:iv],"WAP"),:ad_id=>@aes.encrypt(session[:key],session[:iv],'All'),:adv_start_on=>@startdate,:adv_end_on=>@enddate,:statistics=>'impressions',:duration=>(params[:duration]!=nil && params[:duration]!='') ? params[:duration].to_s : '1'
                  else
                      @advertiser=Advertiser.find_by_user_id(user_id)
                      @camp_list=Campaign.find(:all, :conditions=>["advertiser_id = ? ",@advertiser.id],:order => "status='Approved' desc")
                      @ad_list=Ad.find(:all,:conditions=>["campaign_id = ?",session[:advreport_camp_id]],:order => "status='Approved' desc") if session[:advreport_camp_id]!='SMS' and session[:advreport_camp_id]!='WAP'
                      @adid=session[:advreport_ad_id]
                      # ad id will ad the condition on query depends upon the selection
                      @adid= (@adid=="All" || @adid=="" || @adid==nil) ? "" : " and ad_id=#{@adid} "
                      campaignId= (session[:advreport_camp_id]=="SMS" || session[:advreport_camp_id]=="WAP" || session[:advreport_camp_id]==nil) ? "" : " and campaign_id=#{session[:advreport_camp_id]} "
                      ad_type=(session[:advreport_camp_id]=="SMS" || session[:advreport_camp_id]=="WAP" ) ? " and ad_client_type='#{session[:advreport_camp_id]}'" : ""
                      count_imp_click="select sum(clicks) as clicks , sum(impressions) as impressions , ((sum(clicks)/sum(impressions))*100) as ctr, sum(amount_spent) as amount_spent from campaigns_summaries where advertiser_id=#{@advertiser.id} #{campaignId} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' #{ad_type} group by advertiser_id"
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
          puts "DEBUGGER :: ERROR :: in advertiser_analytic_controller - advertiser_home method :: #{e.to_s}"
      end
    end
  
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#Method Name: generate_adv_report
	#Purpose: To genenrate the all charts xml. 
	#Version: 1.0
	#Author: Sathish Kumar Sadhasivam
	#Last Modified: 08-Oct-2008 by Sathish Kumar Sadhasivam
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	  
	def generate_adv_report
		begin
      @aes = AESSecurity.new() #creating an object for AES Security
      if (session[:user_id]==nil)
          flash[:notice]="Your session has expired. Please login again."
          redirect_to :controller=>'login', :action=>'login'
      else
          if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
              #creating the neccessary variables.
              advxml_string_hash=Hash.new
              advxml_array_hash=Hash.new
              smartLabel='0' #0 represent smartLable as disabled
              camp_id=session[:advreport_camp_id]=@aes.decrypt(session[:key],session[:iv],params[:campaign_id]) if params[:campaign_id]!=nil
              session[:advreport_ad_id]=@aes.decrypt(session[:key],session[:iv],params[:ad_id]) if params[:ad_id]!=nil
              session[:advreport_start_on]=params[:adv_start_on] if params[:adv_start_on]!=nil
              session[:advreport_end_on]=params[:adv_end_on] if params[:adv_end_on]!=nil
              session[:duration]=params[:duration]
              session[:page]=params[:page]==""? 0 : params[:page].to_i
              verifyDBconnection
              # Fetch the summary performance of the particular campaign
              report_type=session[:advreport_type]=params[:statistics] if params[:statistics]!=nil
              # building the start and end date
              session[:advreport_end_on]? session[:advreport_end_on]:(Time.now).strftime("%d-%b-%Y") 
              session[:advreport_start_on]? session[:advreport_start_on]:(Time.now).strftime("%d-%b-%Y")
              user_id = @aes.decrypt(session[:key],session[:iv],session[:user_id])
              advertiser=Advertiser.find_by_user_id(user_id)
              session[:adv_id]=advertiser.id
              #@camp_list=Campaign.find(:all, :conditions=>["advertiser_id = ? ",advertiser.id])
              #@ad_list=Ad.find(:all,:conditions=>["campaign_id = ?",camp_id])
              if camp_id!='WAP' and camp_id!='SMS'
                  campaign=Campaign.find(camp_id) 
                  ad_type=(campaign.ad_medium).upcase
              end
              #calls generate query method to construct TRAFFIC query and xml - Query for Traffic Sources 
              if params[:ad_id]!=nil and params[:ad_id]!=""
                  advXML_summary_report=@@obj.generate_query(session[:advreport_camp_id],session[:advreport_ad_id],"#{session[:adv_id]}-campaigns_summaries-#{session[:duration]}",'Campaigns_Summary','delivery_date',report_type,params[:adv_start_on],params[:adv_end_on])
                  if advXML_summary_report==nil
                      advXML_summary_report={:xml_string=>nil,:xml_array=>nil} 
                  end
                  #calls generate query method to construct summary on devices (Handsets) query and xml - Query for Device_Summary
                  advXML_handset_report=@@obj.generate_query(session[:advreport_camp_id],session[:advreport_ad_id],"#{session[:adv_id]}-adv_handsets-#{session[:duration]}-#{smartLabel}",'Device_Summary','delivery_date',report_type,params[:adv_start_on],params[:adv_end_on],'handset','impressions','','advertiser_analytic') if ad_type!='SMS' and camp_id!='SMS'
                   if advXML_handset_report==nil
                      advXML_handset_report={:xml_string=>nil,:xml_array=>nil} 
                  end
                  #calls generate query method to construct summary on hour basis (hourly traffic) query and xml - Query for hourly_report
                  #~ advXML_hourly_report=@@obj.generate_query(session[:advreport_camp_id],session[:advreport_ad_id],"#{session[:adv_id]}-campaigns_summaries-#{session[:duration]}",'hourly_report','delivery_hour','impressions',params[:adv_start_on],params[:adv_end_on]) 
                  #~ if advXML_hourly_report==nil
                      #~ advXML_hourly_report={:xml_string=>nil,:xml_array=>nil} 
                  #~ end
                  #calls generate query method to construct summary on carrier (carrier traffic) query and xml - Query for Carrier_Traffic
                  advXML_carrier_report=@@obj.generate_query(session[:advreport_camp_id],session[:advreport_ad_id],"#{session[:adv_id]}-adv_carriers-#{session[:duration]}-#{smartLabel}",'Carrier_Traffic','delivery_date',report_type,params[:adv_start_on],params[:adv_end_on],'operator', 'requests','','advertiser_analytic')  if ad_type!='SMS' and camp_id!='SMS'
                  if advXML_carrier_report==nil
                      advXML_carrier_report={:xml_string=>nil,:xml_array=>nil} 
                  end
                    
                  #calls generate query method to construct summary on continent (traffic) query and xml - Query for Carrier_Traffic
                  advXML_continent_traffic_report=@@obj.generate_query(session[:advreport_camp_id],session[:advreport_ad_id],"#{session[:adv_id]}-adv_geolocations-#{session[:duration]}",'Traffic','delivery_date',report_type,params[:adv_start_on],params[:adv_end_on],'continent_code', 'impressions','continent_code','advertiser_analytic')  if ad_type!='SMS' and camp_id!='SMS'
                  if advXML_continent_traffic_report==nil
                      advXML_continent_traffic_report={:xml_string=>nil,:xml_array=>nil} 
                  end
                  #calls generate query method to construct summary on device property query and xml - Query for Device Property 
                  advXML_device_property_traffic_report=@@obj.generate_query(session[:advreport_camp_id],session[:advreport_ad_id],"#{session[:adv_id]}-adv_devicesproperties-#{session[:duration]}-#{smartLabel}",'DeviceProperties_Traffic','delivery_date',report_type,params[:adv_start_on],params[:adv_end_on])  if ad_type!='SMS' and camp_id!='SMS'
                  if advXML_device_property_traffic_report==nil
                      advXML_device_property_traffic_report={:xml_string=>nil,:xml_array=>nil} 
                  end
                  #calls generate query method to construct campaign's ad wise summary query and xml - Query for ad wise  
                  advXML_ad_wise_report=@@obj.generate_query(session[:advreport_camp_id],session[:advreport_ad_id],"#{session[:adv_id]}-campaigns_summaries-#{session[:duration]}",'Ad_Wise','a.name as ad_name',report_type,params[:adv_start_on],params[:adv_end_on])  
                  if advXML_ad_wise_report==nil
                      advXML_ad_wise_report={:xml_string=>nil,:xml_array=>nil}
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
                end
                advxml_string_hash={:summary=>advXML_summary_report[:xml_string],:handset=>advXML_handset_report[:xml_string],:carrier=>advXML_carrier_report[:xml_string],:continent_traffic=>advXML_continent_traffic_report[:xml_string],:device_property=>advXML_device_property_traffic_report[:xml_string],:adwise=>advXML_ad_wise_report[:xml_string]}
                advxml_array_hash={:handsets_arr=>advXML_handset_report[:xml_array],:carrier_arr=>advXML_carrier_report[:xml_array]}
                # putting the hashes into the session variables to access that in views
                session[:advxml_string]=advxml_string_hash
                session[:advxml_array]=advxml_array_hash
                #rendering the advertiser_home action 
                redirect_to :controller=>'advertiser_analytic', :action=>'advertiser_home'
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
	#Method Name: advertiser_adwise	
	#Purpose: To show the adwise chart in adwise home page. It shows the particular campaign's all ads performance chart. 
	#Version: 1.0
	#Author: Sathish Kumar Sadhasivam
	#Last Modified: 20-Sep-2008 by Sathish Kumar Sadhasivam
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	def advertiser_continent
		begin
        @aes = AESSecurity.new() #creating an object for AES Security
        if (session[:user_id]==nil)
            flash[:notice]="Your session has expired. Please login again."
            redirect_to :controller=>'login', :action=>'login'
        else
            if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
                @continent=@continent={"SA"=>"South America","NA"=>"North America","AS"=>"Asia","EU"=>"Europe","AF"=>"Africa","OC"=>"Oceania","CA"=>"Central America","ME"=>"Middle East"}
                session[:page]=params[:page]==""? 0 : params[:page].to_i
                verifyDBconnection
                # ad id will ad the condition on query depends upon the selection
                @adid= (session[:advreport_ad_id]=="All" ) ? "" : " and ad_id=#{session[:advreport_ad_id]} "
                campaignId= (session[:advreport_camp_id]=="SMS" || session[:advreport_camp_id]=="WAP" || session[:advreport_camp_id]==nil) ? "" : " and campaign_id=#{session[:advreport_camp_id]} "
                report_type='impressions'
                @advXML_continent_report=@@obj.generate_query(session[:advreport_camp_id],session[:advreport_ad_id],"#{session[:adv_id]}-adv_geolocations-#{session[:duration]}",'Traffic','delivery_date',report_type,session[:advreport_start_on],session[:advreport_end_on],'continent_code', 'impressions','continent_code','advertiser_analytic') 
                #frame query to retrive traffic source recordset from the database.
                # sub query  which is used inside the main query.
                sub_query="select sum(impressions) as sum_region from adv_geolocations where  advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and impressions>0"   
                # Main query
                query="select if(continent_code='CB','NA',continent_code) as continent, sum(impressions) as sum_region,((sum(impressions)/(#{sub_query}))*100) as percentage from adv_geolocations where advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and impressions>0 group by continent order by sum_region desc "
                @countrydata_pages, @countrydata = paginate_by_sql CampaignsSummary,query,10
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
	#Last Modified: 20-Sep-2008 by Sathish Kumar Sadhasivam
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  def advertiser_traffic_continent
       begin
           @aes = AESSecurity.new() #creating an object for AES Security
            if (session[:user_id]==nil)
                flash[:notice]="Your session has expired. Please login again."
                redirect_to :controller=>'login', :action=>'login'
            else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
                  key='rh21nr8e0vav0h0v'
                  iv='1pnee1ng36nuare8'
                  europe={"AL"=>"Albania","AD"=>"Andorra","AT"=>"Austria","BY"=>"Belarus","BE"=>"Belgium","BA"=>"Bosnia and Herzegovina","BG"=>"Bulgaria","HR"=>"Croatia","CZ"=>"Czech Republic","DK"=>"Denmark","EE"=>"Estonia","FI"=>"Finland","FR"=>"France","DE"=>"Germany","GR"=>"Greece","HU"=>"Hungary","IS"=>"Iceland","IE"=>"Ireland","IT"=>"Italy","LV"=>"Liechtenstein","LI"=>"Liechtenstein","LT"=>"Lithuania","LU"=>"Luxembourg","MK"=>"Macedonia","MT"=>"Malta","MD"=>"Moldova","MC"=>"Monaco","ME"=>"Montenegro","NL"=>"Netherlands","NO"=>"Norway","PL"=>"Poland","PT"=>"Portugal","RO"=>"Romania","SM"=>"San Marino","CS"=>"Serbia","SK"=>"Slovakia","SI"=>"Slovenia","ES"=>"Spain","SE"=>"Sweden","CH"=>"Switzerland","UA"=>"Ukraine","GB"=>"United Kingdom","VA"=>"Vatican City ","CY"=>"Cyprus","TR"=>"Turkey","RU"=>"Russia","AX"=>"Aland Islands","FO"=>"Faroe Islands","GI"=>"Gibraltar"}
                  northAmerica={"AG"=>"Antigua and Barbuda","BS"=>"Bahamas","BB"=>"Barbados","BZ"=>"Belize","CA"=>"Canada","CR"=>"Costa Rica","CU"=>"Cuba","DM"=>"Dominica","DO"=>"Dominican Rep.","SV"=>"El Salvador","GD"=>"Grenada","GT"=>"Guatemala","HT"=>"Haiti","HN"=>"Honduras","JM"=>"Jamaica","MX"=>"Mexico","NI"=>"Nicaragua","PA"=>"Panama","KN"=>"St. Kitts & Nevis","LC"=>"St. Lucia","VC"=>"St. Vincent & the Grenadines","TT"=>"Trinidad & Tobago","US"=>"United States","GL"=>"Greenland","PR"=>"Puerto Rico","KY"=>"Cayman Islands","AI"=>"Anguilla","AW"=>"Aruba","BM"=>"Bermuda","GP"=>"Guadeloupe","MQ"=>"Martinique","MS"=>"Montserrat","AN"=>"Netherlands Antilles","TC"=>"Turks And Caicos Islands","VG"=>"Virgin Islands - British","VI"=>"VIRGIN ISLANDS - U.S"}
                  southAmerica={"AR"=>"Argentina","BO"=>"Bolivia","BR"=>"Brazil","CL"=>"Chile","CO"=>"Colombia","EC"=>"Ecuador","FK"=>"Falkland Islands","GF"=>"French Guiana","GY"=>"Guyana","PY"=>"Paraguay","PE"=>"Peru","SR"=>"Suriname","UY"=>"Uruguay","VE"=>"Venezuela"}
                  asia={"AF"=>"Afghanistan","AM"=>"Armenia","AZ"=>"Azerbaijan","BD"=>"Bangladesh","BT"=>"Bhutan","BN"=>"Brunei","MM"=>"Burma (Myanmar)","KH"=>"Cambodia","CN"=>"China","TP"=>"East Timor","GE"=>"Georgia","IN"=>"India","ID"=>"Indonesia","IR"=>"Iran","JP"=>"Japan","KZ"=>"Kazakhstan","KP"=>"Korea (north)","KR"=>"Korea (south)","KG"=>"Kyrgyzstan","LA"=>"Laos","MY"=>"Malaysia","MN"=>"Mongolia","NP"=>"Nepal","PK"=>"Pakistan","PH"=>"Philippines","RU"=>"Russian Federation","SG"=>"Singapore","LK"=>"Sri Lanka","TJ"=>"Tajikistan","TH"=>"Thailand","TM"=>"Turkmenistan","UZ"=>"Uzbekistan","VN"=>"Vietnam","TW"=>"Taiwan","HK"=>"Hong Kong","MO"=>"Macau","IO"=>"BRITISH INDIAN OCEAN TERRITORY","MV"=>"Maldives"}
                  africa={"DZ"=>"Algeria","AO"=>"Angola","BJ"=>"Benin","BW"=>"Botswana","BF"=>"Burkina Faso","BI"=>"Burundi","CM"=>"Cameroon","CV"=>"Cape Verde","CF"=>"Central African Republic","TD"=>"Chad","KM"=>"Comoros","CI"=>"Cote d Ivoire","CD"=>"Democratic Republic of the Congo","DJ"=>"Djibouti","EG"=>"Egypt","GQ"=>"Equatorial Guinea","ER"=>"Eritrea","ET"=>"Ethiopia","GA"=>"Gabon","GH"=>"Ghana","GN"=>"Guinea","GW"=>"Guinea-Bissau","KE"=>"Kenya","LS"=>"Lesotho","LR"=>"Liberia","LY"=>"Libya","MG"=>"Madagascar","MW"=>"Malawi","ML"=>"Mali","MR"=>"Mauritania","MA"=>"Morocco","MZ"=>"Mozambique","NA"=>"Namibia","NE"=>"Niger","NG"=>"Nigeria","RW"=>"Rwanda","ST"=>"Sao Tome and Principe","SN"=>"Senegal","SY"=>"Seycelles","SL"=>"Sierra Leone","SO"=>"Somalia","ZA"=>"South Africa","SD"=>"Sudan","SZ"=>"Swaziland","TZ"=>"Tanzania","TG"=>"Togo","TN"=>"Tunisia","UG"=>"Uganda","WS"=>"Western Sahara","ZM"=>"Zambia","ZW"=>"Zimbabwe","GM"=>"Gambia","CG"=>"Congo","MU"=>"Mauritius","YT"=>"Mayotte","RE"=>"Reunion","SC"=>"SEYCHELLES"}
                  oceania={"AU"=>"Australia","FJ"=>"Fiji","KI"=>"Kiribati","MH"=>"Marshall Islands","FM"=>"Micronesia","NR"=>"Nauru","NZ"=>"New Zealand","PW"=>"Palau","PG"=>"Papua New Guinea","WS"=>"Samoa","SB"=>"Solomon Islands","TO"=>"Tonga","TV"=>"Tuvalu","VU"=>"Vanuatu","NC"=>"New Caledonia","AS"=>"American Samoa","CK"=>"Cook Islands","GU"=>"Guam","MP"=>"Northern Mariana Islands","NF"=>"Norfolk Islands","NU"=>"Niue","PF"=>"French Polynesia","TK"=>"Tokelau","UM"=>"United States Minor Outlying Islands"}
                  middleEast={"AF"=>"Afghanistan","BH"=>"Bahrain","IR"=>"Iran","IQ"=>"Iraq","IL"=>"Israel","JO"=>"Jordan","KW"=>"Kuwait","KG"=>"Kyrgyzstan ","LB"=>"Lebanon","OM"=>"Oman","PK"=>"Pakistan","QA"=>"Qatar","SA"=>"Saudi Arabia","SY"=>"Syria","TI"=>"Tajikistan","TU"=>"Turkey","TX"=>"Turkmenistan","AE"=>"United Arab Emirates","UZ"=>"Uzbekistan","YE"=>"Yemen"}
                  centralAmerica={"BZ"=>"Belize","CR"=>"Costa Rica","SV"=>"El Salvador","GT"=>"Guatemala","HN"=>"Honduras","NI"=>"Nicaragua","PA"=>"Panama"}
                  session[:adv_continent_info]=params[:params] if params[:params] !=nil && params[:params]!=''
                  @continent_code=session[:adv_continent_info].split('/')[0]   #initialize continent code from params
                  @campaign_id=session[:adv_continent_info].split('/')[1]  # initialize campaign id
                  flag=session[:adv_continent_info].split('/')[3]
                  if flag==nil 
                      @campaign_id=@aes.decrypt(key,iv,"#{@campaign_id}")
                  elsif flag.to_s=='1'
                      @campaign_id=@aes.decrypt(session[:key],session[:iv],"#{@campaign_id}")  # initialize publisher id 
                  end
                  @adid=session[:adv_continent_info].split('/')[2] # initialize ad id 
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
                 session[:page]=params[:page]==""? 0 : params[:page].to_i
                 verifyDBconnection
                 #intialize start and end date
                 @startdate=Time.parse(session[:advreport_start_on]).strftime('%Y-%m-%d')
                 @enddate=Time.parse(session[:advreport_end_on]).strftime('%Y-%m-%d')
                 cont_code=@continent_code=='NA' ? "'NA' or continent_code='CB'" : "'#{@continent_code}'"
                 @advXML_continent_traffic_report=@@obj.generate_query(@campaign_id,@adid,"#{session[:adv_id]}-adv_geolocations-#{session[:duration]}",'Traffic_Continent','delivery_date',session[:advreport_type],session[:advreport_start_on],session[:advreport_end_on],'country_code', 'impressions','continent_code',@continent_code)
                 #call generate query method to construct traffic source- country wise query and to generate traffic source map.
                 #frame query to retrive traffic source recordset from the database.
                 @adid= (session[:advreport_ad_id]=="All" ) ? "" : " and ad_id=#{session[:advreport_ad_id]} "
                 campaignId= (session[:advreport_camp_id]=="SMS" || session[:advreport_camp_id]=="WAP" || session[:advreport_camp_id]==nil) ? "" : " and campaign_id=#{session[:advreport_camp_id]} "
                 sub_query="select sum(impressions) as sum_region from adv_geolocations where (continent_code=#{cont_code}) and  advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and impressions>0"   
                 # main query
                 query="select country_code as country_code , sum(impressions) as sum_region,((sum(impressions)/(#{sub_query}))*100) as percentage from adv_geolocations  where (continent_code=#{cont_code}) and  advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and impressions>0 group by country_code order by sum_region desc "
                 @countrydata_pages, @countrydata = paginate_by_sql CampaignsSummary,query,10
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
            if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
                @smartLabel='1'
                session[:page]=params[:page]==""? 0 : params[:page].to_i
                verifyDBconnection
                #~ @adid= (session[:advreport_ad_id]=="All" ) ? "" : " and ad_id=#{session[:advreport_ad_id]} "
                report_type='impressions'
                @adid= (session[:advreport_ad_id]=="All" ) ? "" : " and ad_id=#{session[:advreport_ad_id]} "
                ad_type=(session[:advreport_camp_id]=="SMS" || session[:advreport_camp_id]=="WAP" ) ? " and ad_client_type='#{session[:advreport_camp_id]}'" : ""
                campaignId= (session[:advreport_camp_id]=="SMS" || session[:advreport_camp_id]=="WAP" || session[:advreport_camp_id]==nil) ? "" : " and campaign_id=#{session[:advreport_camp_id]} "
                @advXML_ad_wise_report=@@obj.generate_query(session[:advreport_camp_id],session[:advreport_ad_id],"#{session[:adv_id]}-campaigns_summaries-#{session[:duration]}-#{@smartLabel}",'Ad_Wise','a.name as ad_name',report_type,session[:advreport_start_on],session[:advreport_end_on])
                sql ="select ad_id , sum(impressions) as impressions,sum(clicks) as sum_clicks,((sum(clicks)/sum(impressions))*100) as sum_ctr,sum(amount_spent) as sum_amount_spent from campaigns_summaries where advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and (impressions>0 or clicks>0) #{ad_type} group by ad_id order by impressions desc"
                @adwise_pages, @adwises = paginate_by_sql CampaignsSummary,sql,10
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
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
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
	#Last Modified: 08-March-2009 by Md Shujauddeen
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	def advertiser_update_text
		begin
			 @aes = AESSecurity.new() #creating an object for AES Security
        if (session[:user_id]==nil)
            flash[:notice]="Your session has expired. Please login again."
            redirect_to :controller=>'login', :action=>'login'
        else
            if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
                @report_type=params[:report_type]
                session[:page]=params[:page]==""? 0 : params[:page].to_i
                verifyDBconnection
                campaignId= (session[:advreport_camp_id]=="SMS" || session[:advreport_camp_id]=="WAP" || session[:advreport_camp_id]==nil) ? "" : " and campaign_id=#{session[:advreport_camp_id]} "
                ad_type=(session[:advreport_camp_id]=="SMS" || session[:advreport_camp_id]=="WAP" ) ? " and ad_client_type='#{session[:advreport_camp_id]}'" : ""
                @adid= (session[:advreport_ad_id]=="All" || session[:advreport_ad_id]=="" || session[:advreport_ad_id]==nil) ? "" : " and ad_id=#{session[:advreport_ad_id]} "
                sql="select date_format(delivery_date,'%Y/%m/%d') as delivered_date , sum(impressions) as impressions, sum(clicks) as clicks, ((sum(clicks)/sum(impressions))*100) as ctr, sum(amount_spent) as amount_spent from campaigns_summaries where advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and (impressions>0 or clicks>0) #{ad_type} group by Year(delivery_date),MONTH(delivery_date),Day(delivery_date)"
                @AdvCampaignSummaries_pages, @AdvCampaignSummaries = paginate_by_sql AdvCarrier,sql,10
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
	#Last Modified: 10-Aug-2009 by Md Shujauddeen
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	def advertiser_deviceproperty
		begin
        @aes = AESSecurity.new() #creating an object for AES Security
        if (session[:user_id]==nil)
            flash[:notice]="Your session has expired. Please login again."
            redirect_to :controller=>'login', :action=>'login'
        else
            if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
                @smartLabel='1'
                session[:page]=params[:page]==""? 0 : params[:page].to_i
                verifyDBconnection
                @adid= (session[:advreport_ad_id]=="All" ) ? "" : " and ad_id=#{session[:advreport_ad_id]} "
                campaignId= (session[:advreport_camp_id]=="SMS" || session[:advreport_camp_id]=="WAP" || session[:advreport_camp_id]==nil) ? "" : " and campaign_id=#{session[:advreport_camp_id]} "
                report_type=session[:advreport_type]
                @advXML_device_property_traffic_report=@@obj.generate_query(session[:advreport_camp_id],session[:advreport_ad_id],"#{session[:adv_id]}-adv_devicesproperties-#{session[:duration]}-#{@smartLabel}",'DeviceProperties_Traffic','delivery_date',session[:advreport_start_on],session[:advreport_start_on],session[:advreport_end_on])
                sql = " select properties as property_name, sum(requests) as property_count,((sum(requests)/( select sum(requests) as counter from adv_devicesproperties where advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and requests>0 ))*100) as percentage from adv_devicesproperties where advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and requests>0 group by property_name order by property_count desc"
                @deviceproperty_pages, @deviceproperty = paginate_by_sql AdvDevicesproperty,sql,10
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
	#Last Modified: 20-Sep-2008 by Md Shujauddeen
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	def advertiser_hourtraffic
		begin
		 @aes = AESSecurity.new() #creating an object for AES Security
        if (session[:user_id]==nil)
            flash[:notice]="Your session has expired. Please login again."
            redirect_to :controller=>'login', :action=>'login'
        else
            if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
                session[:page]=params[:page]==""? 0 : params[:page].to_i
                verifyDBconnection
                @adid= (session[:advreport_ad_id]=="All" ) ? "" : " and ad_id=#{session[:advreport_ad_id]} "
                campaignId= (session[:advreport_camp_id]=="SMS" || session[:advreport_camp_id]=="WAP" || session[:advreport_camp_id]==nil) ? "" : " and campaign_id=#{session[:advreport_camp_id]} "
                ad_type=(session[:advreport_camp_id]=="SMS" || session[:advreport_camp_id]=="WAP" ) ? " and ad_client_type='#{session[:advreport_camp_id]}'" : ""
                report_type=session[:advreport_type]
                @advXML_hour_traffic_report=@@obj.generate_query(session[:advreport_camp_id],session[:advreport_ad_id],"#{session[:adv_id]}-campaigns_summaries-#{session[:duration]}",'hourly_report','delivery_hour','impressions',session[:advreport_start_on],session[:advreport_end_on]) 			
                sql="select delivery_hour , sum(impressions) as impressions, ((sum(impressions)/(select sum(impressions) as impressions from campaigns_summaries where advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and impressions>0 	))*100) as percentage from campaigns_summaries where advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and impressions>0 #{ad_type} group by delivery_hour"
                @hourtraffic_pages, @hour_traffic = paginate_by_sql CampaignsSummary,sql,24
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
	#Last Modified: 20-Sep-2008 by Md Shujauddeen
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	def advertiser_carrier
		begin
        @aes = AESSecurity.new() #creating an object for AES Security
        if (session[:user_id]==nil)
            flash[:notice]="Your session has expired. Please login again."
            redirect_to :controller=>'login', :action=>'login'
        else
            if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
                @smartLabel='1'
                session[:page]=params[:page]==""? 0 : params[:page].to_i
                verifyDBconnection
                @adid= (session[:advreport_ad_id]=="All" ) ? "" : " and ad_id=#{session[:advreport_ad_id]} "
                campaignId= (session[:advreport_camp_id]=="SMS" || session[:advreport_camp_id]=="WAP" || session[:advreport_camp_id]==nil) ? "" : " and campaign_id=#{session[:advreport_camp_id]} "
                report_type=session[:advreport_type]
                @advXML_carrier_report=@@obj.generate_query(session[:advreport_camp_id],session[:advreport_ad_id],"#{session[:adv_id]}-adv_carriers-#{session[:duration]}-#{@smartLabel}",'Carrier_Traffic','delivery_date',report_type,session[:advreport_start_on],session[:advreport_end_on],'operator', 'requests','','advertiser_analytic')
                sql="select carriers as operator , sum(requests) as requests,(sum(requests)/(select sum(requests) from adv_carriers where advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid}  and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and requests>0)*100) as percentage from adv_carriers where advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid}  and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and requests>0 group by operator order by requests desc"                
                @carriers_pages, @carriers = paginate_by_sql AdvCarrier,sql,10      
            else
                flash[:notice]="Your are not an authorized user. Please login with different username."
                redirect_to :controller=>'login', :action=>'login'
            end
        end
		rescue Exception=>e
			puts "DEBUG :: ERROR :: in advertiser_analytic_controller - advertiser_carrier method Exception :: #{e.to_s}"
			render :action=>'advertiser_carrier'
		end
	end
	
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	#Method Name: advertiser_handset
	#Purpose: To show the top 5 handsets traffic on particular campaigns performance and list the other handsets with traffic on it.
	#Version: 1.0
	#Author: Sathish Kumar Sadhasivam
	#Last Modified: 20-Sep-2008 by Md Shujauddeen
	#Notes: None
	#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	def advertiser_handset
		begin
         @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
                  @smartLabel='1'
                  session[:page]=params[:page]==""? 0 : params[:page].to_i
                  verifyDBconnection
                  @adid= (session[:advreport_ad_id]=="All" ) ? "" : " and ad_id=#{session[:advreport_ad_id]} "
                  campaignId= (session[:advreport_camp_id]=="SMS" || session[:advreport_camp_id]=="WAP" || session[:advreport_camp_id]==nil) ? "" : " and campaign_id=#{session[:advreport_camp_id]} "
                  report_type=session[:advreport_type]
                  @advXML_handset_report=@@obj.generate_query(session[:advreport_camp_id],session[:advreport_ad_id],"#{session[:adv_id]}-adv_handsets-#{session[:duration]}-#{@smartLabel}",'Device_Summary','delivery_date',session[:advreport_type],session[:advreport_start_on],session[:advreport_end_on],'handset','impressions','','advertiser_analytic')
                  #Original query to check
                  sql="	select handset,sum(impressions) as requests, ((sum(impressions))/(select sum(impressions) as total_c from adv_handsets where advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and impressions>0))*100 as percentage from adv_handsets where  advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and impressions>0 group by handset order by requests desc"
                  @handsets_pages, @handsets = paginate_by_sql CampaignsSummary,sql,10
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
    #Method Name: adv_generate_csv
    #Purpose: To export the table data to csv file.
    #Version: 1.0
    #Author: Sathish Kumar Sadhasivam
    #Last Modified: 08-Oct-2008 by Md Shujauddeen
    #Notes: None
    #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------      
    def adv_generate_csv
      begin
         @aes = AESSecurity.new() #creating an object for AES Security
          if (session[:user_id]==nil)
              flash[:notice]="Your session has expired. Please login again."
              redirect_to :controller=>'login', :action=>'login'
          else
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
                 filename = "zestadz #{params[:heading]}" + ".csv"
                 send_data(session[:csv_string],:type => 'text/csv; charset=utf-8; header=present',:filename => filename)
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
	#Method Name: traffic_country	
	#Purpose: To show the adwise chart in adwise home page. It shows the particular campaign's all ads performance chart. 
	#Version: 1.0
	#Author: Md Shujauddeen
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
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
                  key='rh21nr8e0vav0h0v'
                  iv='1pnee1ng36nuare8'
                  @smartLabel='1'
                  session[:adv_operator]=params[:operator] if params[:operator]!=nil && params[:operator]!=''
                  @operator=session[:adv_operator].split('/')[0]   #initialize continent code from params
                  @campaign_id=session[:adv_operator].split('/')[1]  # initialize campaign id
                  @campaign_id=@aes.decrypt(key,iv,"#{@campaign_id}")
                  @adid=session[:adv_operator].split('/')[2] # initialize ad id 
                  session[:page]=params[:page]==""? 0 : params[:page].to_i
                  verifyDBconnection
                 #intialize start and end date
                 @startdate=Time.parse(session[:advreport_start_on]).strftime('%Y-%m-%d')
                 @enddate=Time.parse(session[:advreport_end_on]).strftime('%Y-%m-%d')
                 #call generate query method to construct traffic source- country wise query and to generate traffic source map.
                 #frame query to retrive traffic source recordset from the database.
                  @advXML_owner_report=@@obj.generate_query(@campaign_id,@adid,"#{session[:adv_id]}-adv_carriers-#{session[:duration]}-#{@smartLabel}",'Owner_Traffic','delivery_date',session[:advreport_type],session[:advreport_start_on],session[:advreport_end_on],'carrier', 'requests',@operator)
                  @adid= (session[:advreport_ad_id]=="All" ) ? "" : " and ad_id=#{session[:advreport_ad_id]} "
                  campaignId= (session[:advreport_camp_id]=="SMS" || session[:advreport_camp_id]=="WAP" || session[:advreport_camp_id]==nil) ? "" : " and campaign_id=#{session[:advreport_camp_id]} "
                  #~ sql="select delivery_date , owner , sum(requests) as requests, ((((sum(requests))/(select sum(requests) from adv_carriers where campaign_id=#{session[:advreport_camp_id]} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and owner!='ip' and owner!='')))*100) as percentage from adv_carriers where  campaign_id=#{session[:advreport_camp_id]} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and owner!='ip' and owner!='' group by owner order by requests desc"
                  sql="select carr.owner as carrier,sum(carr.requests) as requests,(sum(carr.requests)/(select sum(carr.requests) from adv_carriers carr, owners own where advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00' and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and carr.owner=own.carrier and own.operator='#{@operator}' and requests>0)*100) as percentage  from adv_carriers carr,owners own where advertiser_id=#{session[:adv_id]} #{campaignId} #{@adid} and delivery_date>='#{(Time.parse(session[:advreport_start_on])).strftime("%Y-%m-%d")} 00:00:00'  and delivery_date<='#{(Time.parse(session[:advreport_end_on])).strftime("%Y-%m-%d")} 23:59:59' and carr.owner=own.carrier and own.operator='#{@operator}' and requests>0 group by carrier order by requests desc"
                  @owner_pages, @owner = paginate_by_sql AdvCarrier,sql,10
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
              if @aes.checkSecurity(session[:user_id],session[:key],session[:iv],5,0)==0
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
			puts "DEBUG :: ERROR :: in advertiser_analytic_controller - advertiser_handset method Exception :: #{e.to_s}"
			render :action=>'advertiser_handset_model'
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
