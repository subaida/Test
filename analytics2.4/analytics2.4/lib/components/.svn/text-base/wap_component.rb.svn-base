#/*
# * wap_component.rb
# *
# * Author : Asghar Ali
# * Version: 0.7
# * Created: 15-01-2008 
# * Last Modified: 21-01-2008
# *
# * Copyright (c) 2003-2006 by CalChennai Mobile-worx Pvt Ltd
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
# * of United States of America & Republic of India
# *
# *
# * Contact us at 
# * info@mobile-worx.com
# *
# * Notes 
# * Version:
# * Note:
# */
 
require 'date'
require 'time'
require 'net/http'
require "xice.rb"
require 'dbi'
require 'rubygems'  
require 'active_record'  
ActiveRecord::Base.establish_connection(  
  :adapter => "mysql",  
  :host => "mw55",  
  :database => "zestadz_development",
  :username => "root",
  :password => "adminmobile"
)  
   
class WurflDevice < ActiveRecord::Base  
end  

class Ipligence < ActiveRecord::Base  
end

class Publisher < ActiveRecord::Base  
end

class Sortedad < ActiveRecord::Base  
end

class WapComponent
  MW_ADID = "1"
  MW_IMG = "http://mw22:4004/ad/ad_picture/".concat(MW_ADID.to_s).concat("/").concat("mw.jpg")
  #MW_IMG = "http://www.zestadz.com/ad/ad_picture/".concat(MW_ADID.to_s).concat("/").concat("mw.jpg")
  MW_TEXT = "Advertise here ... MOBILE-WORX"
  MW_TYPE = 3
  Mw_SERVER = "http://mw22:4004"
  #Mw_SERVER = "http://www.zestadz.com"
  CLIENT_TYPE_FAILED = 203
  CLIENT_NOT_ACTIVE = 199
  CLIENT_NOT_PRESENT = 216
  CLIENT_ERROR = 26
  AD_ERROR = 204
  TOKEN_ERROR = 205
  EMPTY_AD = -6009
  IP_FRAUD = 206
  USER_AGENT_FRAUD = 207
  USER_AGENT_EMPTY = 208
  @@debug = true
  
  def deliverad(ua, ip, cid, fcid, meta, keyword, age, sex, dg)
   # begin
      # The variable that are optional - initialised if nil----------------
      if keyword==nil || keyword==""
        keyword = ""
      end
      if age==nil || age==""
        age = ""
      end
      if sex==nil || sex==""
        sex = ""
      end
      if dg==nil || dg==""
        dg = ""
      end
      #-------------------------------------------------------------------------
      if ua!=nil || ua!=""
        #dev = WurflDevice.find_by_user_agent(ua) #fraud control - checking if the user is trying to request via browser or mobile phone
        if true #dev if the user is actually accessing via a phone browser
          if ip!=nil || ip!=""
            #temp_ipligence = Ipligence.find(:first, :conditions=>"ip_from <= '#{returnIPLong(ip)}' and ip_to >= '#{returnIPLong(ip)}'", :limit=>1)
            if true #temp_ipligence!=nil || temp_ipligence!=""
              country = 'INDIA' #temp_ipligence.country_name
              city = 'Chennai' #temp_ipligence.city_name
              region = 'NORTH INDIA' #temp_ipligence.region_name
              temp_ipligence = nil
            else
              country = "India"
            end
            if cid!=nil || cid!=""
              cid = decode(cid)
              clients = Adclient.find_by_sql("select count(id) as count, status, client_type, ad_type, screen_size, publisher_id from adclients where id=#{cid} group by id")
              if(clients[0].count=='1')
                clientStatus = clients[0].status
                clientType = clients[0].client_type
                ad_type = clients[0].ad_type
                screen_size = clients[0].screen_size
                publisher_id = clients[0].publisher_id
                publisher = Publisher.find(:first, :conditions=>["id=?", publisher_id])
                if(clientStatus=="Active")
                  if(clientType=="wap" || clientType=="WAP")
                    return returnads(fcid, meta, keyword, age, sex, dg, ad_type, screen_size, country, clientType, publisher_id, ua, ip, city, publisher.user_id, cid , region, clientStatus, "UnPaid")
                  else
                    puts "says that the requesting client is not a wap client"
                    return returnads(fcid, meta, keyword, age, sex, dg, ad_type, screen_size, country, clientType, publisher_id, ua, ip, city, publisher.user_id, cid , region, "InActive", "Fraud")
                  end
                else
                  puts "says that the cid sent, is not active"
                  return returnads(fcid, meta, keyword, age, sex, dg, ad_type, screen_size, country, clientType, publisher_id, ua, ip, city, publisher.user_id, cid , region, "InActive", "Fraud")
                end
              else
                puts "says that the cid sent, is not present in the database"
                return returnads(fcid, meta, keyword, age, sex, dg, "Text", "Text", country, "wap", 146, ua, ip, city, publisher.user_id, 16 , region, "InActive", "Fraud")
              end
            else
              puts "says that the cid is not present"
              return returnads(fcid, meta, keyword, age, sex, dg, "Text", "Text", country, "wap", 146, ua, ip, city, 685, 16, region, "InActive", "Fraud")
            end
          else
            puts "says that the ip is not present"
            return returnads(fcid, meta, keyword, age, sex, dg, "Text", "Text", "India", "wap", 146, ua, "127.0.0.1", "Chennai", 685, 16, "SOUTH INDIA", "InActive", "Fraud")
          end
        else
          puts "says that the user agent is fraud"
          return returnads(fcid, meta, keyword, age, sex, dg, "Text", "Text", "India", "wap", 146, "Nokia", ip, "Chennai", 685, 16, "SOUTH INDIA", "InActive", "Fraud")
        end
      else
        puts "does not satisfy user agent"
        return returnads(fcid, meta, keyword, age, sex, dg, "Text", "Text", "India", "wap", 146, "Nokia", "127.0.0.1", "Chennai", 685, 16, "SOUTH INDIA", "InActive", "Fraud")
      end
#    rescue Exception=>e
#      puts "An exception has occurred in deliverad of the wap component. The Exception is #{e.to_s}"
#      return returnads("fcid", "meta", "keyword", "age", "sex", "dg", "Text", "Text", "India", "wap", 146, "Nokia", "127.0.0.1", "Chennai", 685, 16, "region", "InActive", "Fraud")
#    ensure
      
#    end
    
  end
  
  def returnads(fcid, meta, keyword, age, sex, dg, ad_type, screen_size, country, clientType, publisher_id, ua, ip, city, user_id, cid , region, clientStatus, pay_status)
    if fcid=="1"
      fcid="1"
    end
    puts cid
    new_keyword = meta+","+keyword
    new_dg = age+","+sex+","+dg
    if ad_type=="Text+Picture"
      temp_type_of_ad = "(type_of_ad='Text+Picture' or type_of_ad='Picture' or type_of_ad='Text')"
    elsif ad_type=="Picture"
      temp_type_of_ad = "(type_of_ad='Picture' or type_of_ad='Text')"
    else
      temp_type_of_ad = "(type_of_ad='Text')"
    end
    if screen_size=="305x64"
      temp_screen_size = "(ad_size='305x64' or ad_size='215x34' or ad_size='167x30' or ad_size='112x20' or ad_size='Text')"
    elsif screen_size=="215x34"
      temp_screen_size = "(ad_size='215x34' or ad_size='167x30' or ad_size='112x20' or ad_size='Text')"
    elsif screen_size=="167x30"
      temp_screen_size = "(ad_size='167x30' or ad_size='112x20' or ad_size='Text')"
    elsif screen_size=="112x20"
      temp_screen_size = "(ad_size='112x20' or ad_size='Text')"
    else
      temp_screen_size = "ad_size='Text'"
    end
    
    #sql = "select SQL_BUFFER_RESULT * from sortedads where (location='#{country}' or location='All') and (ad_medium='#{clientType}' or ad_medium='ALL') and #{temp_type_of_ad} and #{temp_screen_size}"# and (keywords like '%#{new_keyword}%' or demographic like '%#{new_dg}%')"
    #removing the location targetting from this query
    puts "sorted ads query trace 1"
    puts sql = "select SQL_BUFFER_RESULT * from sortedads where (ad_medium='#{clientType}' or ad_medium='#{clientType.upcase}') and #{temp_type_of_ad} and #{temp_screen_size}"# and (keywords like '%#{new_keyword}%' or demographic like '%#{new_dg}%')"
    adids = Sortedad.find_by_sql(sql)
    
    t = Time.now 
    dateTime = t.strftime("%Y-%m-%d %H:%M:%S") 
    tokTime = Time.now
    token = tokTime.strftime("%Y%m%d%H%M%S").concat(cid)
    puts adids.length
    puts temp_id = rand(adids.length)
    #check_amount = Advertiseraccount.find_by_sql("select (amount_spent < max_budget) as check_amount from campaigns where id=(select advertiser_id from ads where id=#{adids[temp_id].ad_id})")
    #puts check_amount.check_amount
    ads = ad_details(adids[temp_id], token)
    if(ads==AD_ERROR) 
      return encode(token.to_s).concat('~').concat(ads).concat('~').concat(cid)
    elsif(ads==EMPTY_AD)
      return encode(token.to_s).concat('~').concat(ads).concat('~').concat(cid)
    else
      puts "THIS IS BILLING SERVER DRB CALLING BLOCK"
      obj = DRbObject.new(nil, 'druby://localhost:8979')
      obj.doBilling(publisher_id, ua, ua, ip, ip, adids[temp_id].campaign_id, adids[temp_id].ad_id, adids[temp_id].metric, adids[temp_id].cost.to_f, adids[temp_id].type_of_ad, clientType, adids[temp_id].keywords, sex, dg, city, 'mobile', token, user_id, cid, dateTime, '1.0', region, country, "1", clientStatus, pay_status, clientType, "impressions")
      return encode(token.to_s).concat('~').concat(ads).concat('~').concat(cid)
    end
  end
  
  def deliverAdWS
    
  end

  
  def returnIPLong(ipaddress)
    b = Array.new
    b = ipaddress.to_s.split(".")
    a1 = b[0].to_i
    a2 = b[1].to_i
    a3 = b[2].to_i
    a4 = b[3].to_i
    return (a4 + (a3 * 256) + (a2 * 256 * 256) + (a1 * 256 * 256 * 256))
  end
  
  #--------------------------------------------------------------------------
  #Method Name: defaultAd
  #Purpose: This method is used to deliver the default when an error is occured
  #Version:0.4.009
  #Last modified: 12/july/2007
  #--------------------------------------------------------------------------
  def defaultAd(clientId)
    begin
      returnString = MW_TYPE.to_s.concat("~").concat(MW_IMG.to_s).concat("~").concat(MW_ADID.to_s).concat("~").concat(MW_TEXT.to_s)
      addetails = returnString
      if(clientId == "FAILURE")
        res = "ZestADZ advertise here! visit www.zestadz.com"
      else  
        putln "Inside default AD"
        putln res = encode(clientId.to_s).concat('~').concat(addetails.to_s)
      end
      return res
    rescue Exception=>e
      puts "Exception in defaultAD thrown. #{e.to_s}"
      res = "Advertise on ZestADZ. visit www.zestadz.com"
      return res
    ensure
      res = "Advertise on ZestADZ. visit www.zestadz.com"
      return res
    end
  end

  #--------------------------------------------------------------------------
  #Method Name: ad_details
  #Purpose: This method is used to get the details of the ad like adtype,adsourcepath,adsource
  #Version:0.4.009
  #Last modified: 12/july/2007
  #--------------------------------------------------------------------------
  
  def ad_details(ad_record, token)
    #begin
      typ = 0
      adTxtOrBanner = ""
      adText = ""
      adImage = ""
      slash = "/"
      returnString = ""
      adImageURL = ""
      adTxtOrBannerURL = ""
      if(ad_record['type_of_ad'] == 'Picture')
        typ = 1
        if(adTxtOrBanner == "" || adTxtOrBanner == nil)
          return EMPTY_AD
        else                        
          if(adTxtOrBanner.index('/')!=nil)
            tempImage = Array.new
            tempImage = adTxtOrBanner.split("/")
            adTxtOrBanner = tempImage.last
          end
          adTxtOrBannerURL = "#{Mw_SERVER}/ad/ad_picture/".concat(token.to_s).concat(slash.lstrip.rstrip.to_s).concat(adTxtOrBanner.to_s)
        end
        returnString = (typ.to_s).concat("~").concat(adTxtOrBannerURL.to_s).concat("~").concat(encode(token.to_s))
      elsif(ad_record['type_of_ad'] == 'Text')
        typ = 2
        adTxtOrBanner = ad_record['ad_text']
        if(adTxtOrBanner == "" || adTxtOrBanner == nil)
          return EMPTY_AD
        end
        returnString = (typ.to_s).concat("~").concat(adTxtOrBanner.to_s).concat("~").concat(encode(token.to_s))
      elsif(ad_record['type_of_ad'] == 'Text+Picture')
        typ = 3
        adImage = ad_record['ad_picture_url']
        adText = ad_record['ad_text']
        if(adImage == "" || adImage == nil)
          return EMPTY_AD
        else
          if(adImage.index('/') == nil)
          else    
            tempImage = Array.new
            tempImage = adImage.split("/")
            adImage = tempImage.last
          end
          adImageURL = ""          
          adImageURL = "#{Mw_SERVER}/ad/ad_picture/".concat(token.to_s).concat(slash.lstrip.rstrip.to_s).concat(adImage.to_s)                        
        end  
        returnString = (typ.to_s).concat("~").concat(adImageURL.to_s).concat("~").concat(encode(token.to_s)).concat("~").concat(adText.to_s)                           
      end
      return returnString
#    rescue Exception=>e
#      puts "Exception thrown in wapdetails #{e.to_s}"
#      return AD_ERROR
#    end
  end
  
  def encode(input)
    begin
      myXICE = XICE.new
      ret = myXICE.encryptText(input, "password")
      if ret == -1
    	output = -1
      else
        output = myXICE.lastResult.to_s
      end
      return output
    rescue Exception=>e
      puts "Exception in encode action #{e.to_s}"
      return -1
    end
  end
  
  def decode(input)
    begin
      myXICE = XICE.new
      ret = myXICE.decryptText(input, "password")
      if ret == -1
    	output = -1
      else
        output = myXICE.lastResult.to_s
      end  
      return output
    rescue Exception=>e
      puts "Exception in Decode action. #{e.to_s}"
      return -1
    end
  end
  
  def returndecode(clientId)
    return decode(clientId)         
  end
  
end
