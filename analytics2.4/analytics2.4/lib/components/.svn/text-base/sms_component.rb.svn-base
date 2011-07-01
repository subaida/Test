#/*
# * sms_component.rb
# *
# * Author : Asghar Ali
# * Version: 0.8
# * Created:  
# * Last Modified: November , Asghar Ali
# *
# * Copyright (c) 2003-2006 by CalChennai Mobile-worx  Pvt Ltd
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
##


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

class Token < ActiveRecord::Base  
end

class SmsComponent
  
  CLIENT_TYPE_FAILED = 203
  CLIENT_NOT_ACTIVE = 199
  CLIENT_NOT_PRESENT = 216
  CLIENT_ERROR = 26
  AD_ERROR = 204
  TOKEN_ERROR = 205
  
  def deliverad(phno, text, reqid, cid, fcid, meta, keyword, age, sex, dg)
    begin
      if reqid==nil || reqid==""
        reqid=2
      end
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
      if cid!=nil || cid!=""
        clients = Adclient.find_by_sql("select count(id) as count, status, client_type, ad_type, screen_size, publisher_id from adclients where id=#{cid} group by id")
        if(clients[0].count=='1')
          clientStatus = clients[0].status
          clientType = clients[0].client_type
          ad_type = clients[0].ad_type
          screen_size = clients[0].screen_size
          publisher_id = clients[0].publisher_id
          #publisher =  Publisher.find_by_sql("select * where id=#{publisher_id}")
          publisher = Publisher.find(:first, :conditions=>["id=?", publisher_id])
          if(clientStatus=="Active")
            if(clientType=="sms")
              if fcid!=''
                begin
               # fcid = decode(fcid)
               fcid = '1'
                rescue Exception=>e
                  fcid="1"
                end
              end
              if ad_type=="Text"
                temp_type_of_ad = "(type_of_ad='Text')"
              end
              if screen_size=="Text"
                temp_screen_size = "ad_size='Text'"
              end
              puts sql = "select SQL_BUFFER_RESULT * from sortedads where (ad_medium='#{clientType}' or ad_medium='#{clientType.upcase}') and #{temp_type_of_ad} and #{temp_screen_size}"# and (keywords like '%#{new_keyword}%' or demographic like '%#{new_dg}%')"
              adids = Sortedad.find_by_sql(sql)
              puts adids.length
              puts temp_id = rand(adids.length)
              puts adids[temp_id]['ad_type']
              ads = ad_details(phno, text, reqid, adids[temp_id],cid)
              if(ads == "FAILURE") 
                return AD_ERROR
              else 
                t = Time.now 
                dateTime = t.strftime("%Y-%m-%d %H:%M:%S") 
                obj = DRbObject.new(nil, 'druby://localhost:8979')   
                obj.doBilling(publisher_id, "sms", "sms", "sms", "sms", adids[temp_id].campaign_id, adids[temp_id].ad_id, adids[temp_id].metric, adids[temp_id].cost.to_f, adids[temp_id].type_of_ad, adids[temp_id].ad_medium, adids[temp_id].keywords, sex, dg, "sms", 'mobile', '', publisher.user_id, cid, dateTime, '1.0', "sms", "sms", '1', clientStatus, 'OK', clientType, "impressions")
                return ads
              end
            else
              #says that the requesting client is not a sms client
              return CLIENT_TYPE_FAILED
            end
          else
            #says that the cid sent, is not active
            return CLIENT_NOT_ACTIVE
          end
        else
          #says that the cid sent, is not present in the database
          return CLIENT_NOT_PRESENT
        end
      else
        #says that the cid is not present
        return CLIENT_NOT_PRESENT
      end
    rescue Exception=>e
      puts "An exception has occurred in deliverad of the sms component. The Exception is #{e.to_s}"
      return CLIENT_ERROR
    end
    
  end
  
  def deliverAdWS
    
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
        puts "Inside default AD"
        puts res = encode(clientId.to_s).concat('~').concat(addetails.to_s)
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
  
  def ad_details(phno, text, reqid, ad_record,cid)
    begin
      adText = ""
      returnString = ""
      if(ad_record['type_of_ad'] == 'Text')
        adText = ad_record['ad_text']
        if(adText == "" || adText == nil)
          return EMPTY_AD
        end
        returnString = reqid.concat("~").concat(text).concat("\n---\n").concat(adText).concat("\n---\n").concat(cid)
      end
        return returnString
    rescue Exception => e
      puts "An error has occurred in ad_details action of sms components. The Exception is #{e.to_s}"
      return AD_ERROR
    end
  end
  
  
  def getToken(cid)
    begin
      clients = Adclient.find_by_sql("select count(id) as count, status, client_type, ad_type, screen_size, publisher_id from adclients where id=#{cid} group by id")
      if(clients[0].count=='1')
        clientStatus = clients[0].status
        clientType = clients[0].client_type
        clients[0].publisher_id
        if(clientStatus=="Active")
          if(clientType=="sms")
            t = Time.now                                   
            tokenTime = t.strftime("%Y-%m-%d %H:%M:%S")
            token = t.strftime("%Y%m%d%H%M%S").concat(cid)
            adtoken = Token.new
            adtoken.token = token
            adtoken.token_time = tokenTime 
            adtoken.client_id = cid
            adtoken.client_type = clientType
            adtoken.save 
            return  token
          else
            return "The adclient was not of the type 'SMS'"
          end
        elsif (clientStatus=="InActive")
          return "The adclient is InActive."
        end
      else
        return "The adclient does not exist."
      end
    rescue Exception=>e
      puts "An error occurred when generating the token in the sms_component. The Exception is #{e.to_s}"
      return TOKEN_ERROR
    end
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
      else
        output = myXICE.lastResult.to_s
        return output
      end    
    rescue StandardError => e
      puts "The exception has occured in decode method of sms_component. The exception is #{e.to_s}"
    end        
  end
  
  def returndecode(clientId)
    return decode(clientId)         
  end

end