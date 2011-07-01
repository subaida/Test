#/*
# * billing.rb
# *
# * Author : Asghar Ali
# * Version: 1.0
# * Created: 24-01-2008
# * Last Modified: 24-01-2008
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
# *     of United States of America & Republic of India
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


#require "dbi"
require 'rubygems'
require 'active_record'



ActiveRecord::Base.establish_connection(  
                                        :adapter => "mysql",  
:host => "192.168.1.4",  
:database => "zestadz_development",
:username => "root",
:password => "sqlworx@ch"
)
class Addelivery < ActiveRecord::Base     
end
class User < ActiveRecord::Base  
end
class Adsdelivery < ActiveRecord::Base  
end

#--------------------------------------------------------------------------
#class Name: Billing
#Purpose: The purpose of this class is to debit the advertiser account and 
#         credit the publisher account and add the deliveries into addeliveries 
#         table.
#Version:0.c3
#Last modified: 4/jun/2007
#---------------------------------------------------------------------------
class Billing
  
  DATABASE_FAILED = -1
  DATABASE_SUCCESS = -2
  ADDL_FAILED = -3
  ADDL_SUCCESS = -4
  ADS_FAILED = -5
  ADS_SUCCESS = -6
  ADV_DEBIT_FAILED = -7
  ADV_DEBIT_SUCCESS = -8
  PPT_FAILED = -9
  PPT_SUCCESS = -10
  ADACC_FAILED = -11
  ADACC_SUCCESS = -12
  CAMP_FAILED = -13
  CAMP_SUCCESS = -14
  EXCEPTION = -15

    
    
  def processBill(publisher_id, ua, user_agent, ipaddress, remote_ip, campaign_id, ad_id, metrics, cost, ad_type, ad_client_type, keywords, sex, demographic, city, platform, dlr_id, user_id, client_id, delivery_time, software_version, region, country, fc_id, status, pay_status, cType, from_display)
    begin
      #puts "1 entered into the processBill action : #{Time.now}"
      zestadz_revenue = 0.0
      gross_margin = 0.0
      gross_profit = 0.0
      impressions = 0
      currency_symbol = '$'
      clicks = 0
      advertiser_id = 0
      begin 
           ppt=Adsdelivery.find_by_sql("SELECT id, amount FROM publisherpayments WHERE publisher_id = #{publisher_id.to_s}")
      rescue 
      puts "exception 0..."
        Adsdelivery.establish_connection(  
                                        :adapter => "mysql",  
:host => "192.168.1.4",  
:database => "zestadz_development",
:username => "root",
:password => "sqlworx@ch"
)
           ppt=Adsdelivery.find_by_sql("SELECT id, amount FROM publisherpayments WHERE publisher_id = #{publisher_id.to_s}")
      end
      publisher_payments_id = ppt[0].id
      #ppt[0].amount.to_s
      amount = ppt[0].amount
      if(pay_status == "Fraud" or pay_status == "IpFraud")
        pay_status = "Fraud"
        adsdelivery_sql = "insert into adsdeliveries(ua, user_agent, ipaddress, remote_ip, campaign_id, ad_id, metrics, cost, ad_type, ad_client_type, keywords, sex, demographic, city, platform, dlr_id, user_id, client_id, delivery_time, software_version, region, country, fc_id, pay_status, status, zestadz_revenue, gross_margin, gross_profit, impressions, clicks, advertiser_id, publisher_payments_id, currency_symbol) values('#{ua}', '#{user_agent}', '#{ipaddress}', '#{remote_ip}', #{campaign_id},#{ ad_id}, '#{metrics}', #{cost}, '#{ad_type}', '#{ad_client_type}', '#{keywords}', '#{sex}', '#{demographic}', '#{city}', '#{platform}', '#{dlr_id}', #{user_id}, #{client_id}, '#{delivery_time}', '#{software_version}', '#{region}', '#{country}', '#{fc_id}', '#{pay_status}', '#{status}', #{zestadz_revenue}, #{gross_margin}, #{gross_profit}, #{impressions}, #{clicks}, #{advertiser_id}, #{publisher_payments_id}, '#{currency_symbol}')"
        begin
              insertAd=Adsdelivery.connection.insert(adsdelivery_sql)
        rescue 
        puts "exception 1..."
        Adsdelivery.establish_connection(  
                                :adapter => "mysql",  
                                :host => "192.168.1.4",  
                                :database => "zestadz_development",
                                :username => "root",
                                :password => "sqlworx@ch"
                                )
          insertAd=Adsdelivery.connection.insert(adsdelivery_sql)
        end
	    else
        begin
              campaign=Adsdelivery.find_by_sql("select advertiser_id from campaigns where id=#{campaign_id.to_s}")
        rescue 
        puts "exception 2..."
        Adsdelivery.establish_connection(  
                                :adapter => "mysql",  
                                :host => "192.168.1.4",  
                                :database => "zestadz_development",
                                :username => "root",
                                :password => "sqlworx@ch"
                                )
          campaign=Adsdelivery.find_by_sql("select advertiser_id from campaigns where id=#{campaign_id.to_s}")
          end
        puts advertiser_id = campaign[0].advertiser_id
	      if from_display=="impressions"
          if cType=="wap" && (ad_type=="Text+Picture" || ad_type=="Picture")
            cost = 0.0
          end
          if metrics=="CPC" && cType=="sms"
            metrics = "CPM"
          end
        end
        pay_status = "UnPaid"
        status = "Active"
        begin
              publisher = Adsdelivery.find_by_sql("select percentage from publishers where id=#{publisher_id}")
        rescue 
        puts "exception 3..."
        Adsdelivery.establish_connection(  
                                :adapter => "mysql",  
                                :host => "192.168.1.4",  
                                :database => "zestadz_development",
                                :username => "root",
                                :password => "sqlworx@ch"
                                )
          publisher = Adsdelivery.find_by_sql("select percentage from publishers where id=#{publisher_id}")
        end
        temp_cost = (cost.to_f * publisher[0].percentage.to_f)/100        
        zestadz_revenue = cost.to_f
        gross_profit = cost.to_f - temp_cost.to_f
	      if zestadz_revenue.to_f==0
          gross_margin = 0.0
        else
          gross_margin = (gross_profit.to_f/zestadz_revenue.to_f)*100
        end
        if from_display == "clicks"
          clicks = 1
          impressions = 0
        else
          impressions = 1
          clicks = 0
        end
        adsdelivery_sql = "insert into adsdeliveries(ua, user_agent, ipaddress, remote_ip, campaign_id, ad_id, metrics, cost, ad_type, ad_client_type, keywords, sex, demographic, city, platform, dlr_id, user_id, client_id, delivery_time, software_version, region, country, fc_id, pay_status, status, zestadz_revenue, gross_margin, gross_profit, impressions, clicks, advertiser_id, publisher_payments_id, currency_symbol) values('#{ua}', '#{user_agent}', '#{ipaddress}', '#{remote_ip}', #{campaign_id},#{ ad_id}, '#{metrics}', #{cost.to_f}, '#{ad_type}', '#{ad_client_type}', '#{keywords}', '#{sex}', '#{demographic}', '#{city}', '#{platform}', '#{dlr_id}', #{user_id}, #{client_id}, '#{delivery_time}', '#{software_version}', '#{region}', '#{country}', '#{fc_id}', '#{pay_status}', '#{status}', #{zestadz_revenue}, #{gross_margin}, #{gross_profit}, #{impressions}, #{clicks}, #{advertiser_id}, #{publisher_payments_id}, '#{currency_symbol}')"
      if from_display == "clicks"
        begin
              insertAd=Adsdelivery.connection.insert(adsdelivery_sql)
              selectDelivery=Adsdelivery.find_by_sql('select max(id) as max from adsdeliveries')
              selectAd=Adsdelivery.find_by_sql("select clicks from ads where id = #{ad_id.to_s}")
        rescue 
        puts "exception 4..."
        Adsdelivery.establish_connection(  
                                :adapter => "mysql",  
                                :host => "192.168.1.4",  
                                :database => "zestadz_development",
                                :username => "root",
                                :password => "sqlworx@ch"
                                )
          insertAd=Adsdelivery.connection.insert(adsdelivery_sql)
          selectDelivery=Adsdelivery.find_by_sql('select max(id) as max from adsdeliveries')
          selectAd=Adsdelivery.find_by_sql("select clicks from ads where id = #{ad_id.to_s}")
        end
        adClicks = selectAd[0].clicks
        adClicks = 1 + adClicks.to_i
        begin
        updateAd = Adsdelivery.find_by_sql("update ads set clicks = #{adClicks.to_s} where id = #{ad_id.to_s}");
        rescue 
        puts "exception 5..."
        Adsdelivery.establish_connection(  
                                :adapter => "mysql",  
                                :host => "192.168.1.4",  
                                :database => "zestadz_development",
                                :username => "root",
                                :password => "sqlworx@ch"
                                )
          updateAd = Adsdelivery.find_by_sql("update ads set clicks = #{adClicks.to_s} where id = #{ad_id.to_s}");
        end
      else
        begin
              insertAd=Adsdelivery.connection.insert(adsdelivery_sql)
              selectDelivery=Adsdelivery.find_by_sql("select max(id) as max from adsdeliveries")
              selectAd=Adsdelivery.find_by_sql("select impressions from ads where id = #{ad_id.to_s} ")
        rescue 
        puts "exception 6.."
        Adsdelivery.establish_connection(  
                                :adapter => "mysql",  
                                :host => "192.168.1.4",  
                                :database => "zestadz_development",
                                :username => "root",
                                :password => "sqlworx@ch"
                                )
          insertAd=Adsdelivery.connection.insert(adsdelivery_sql)
          selectDelivery=Adsdelivery.find_by_sql("select max(id) as max from adsdeliveries")
          selectAd=Adsdelivery.find_by_sql("select impressions from ads where id = #{ad_id.to_s} ")
        end
        adImpressions = selectAd[0].impressions
        puts adImpressions = 1 + adImpressions.to_i
        begin
              updateAd=Adsdelivery.connection.update("update ads set impressions = #{adImpressions.to_s} where id = #{ad_id.to_s}")
        rescue 
        puts "exception 7..."
        Adsdelivery.establish_connection(  
                                :adapter => "mysql",  
                                :host => "192.168.1.4",  
                                :database => "zestadz_development",
                                :username => "root",
                                :password => "sqlworx@ch"
                                )
          updateAd=Adsdelivery.connection.update("update ads set impressions = #{adImpressions.to_s} where id = #{ad_id.to_s}")
        end
      end
       if(pay_status == "UnPaid")
          if(debitAdvertiser(advertiser_id,cost,selectDelivery[0].max) == ADV_DEBIT_SUCCESS)
            creditPublisher(amount, publisher_id ,cost)
            return ADV_DEBIT_SUCCESS
          else
            return ADV_DEBIT_FAILED
          end
        end
       end
    rescue Exception=>e
      puts "An exception has occurred in process action of Billing component. The Exception is #{e.to_s}"
      return EXCEPTION
    end
  end
  
  def creditPublisher(amount, publisher_id, cost)
    begin
        publisher = Adsdelivery.find_by_sql("select percentage from publishers where id=#{publisher_id}")
      temp_cost = (cost.to_f * publisher[0].percentage.to_f)/100
      newbalance = amount.to_f + temp_cost.to_f  
      begin
          updateaccount = Adsdelivery.connection.update("update publisherpayments set amount= #{newbalance.to_s} where publisher_id= #{publisher_id.to_s}")    
      rescue 
      puts "exception 8.."
        Adsdelivery.establish_connection(  
                                :adapter => "mysql",  
                                :host => "192.168.1.4",  
                                :database => "zestadz_development",
                                :username => "root",
                                :password => "sqlworx@ch"
                                )
          updateaccount = Adsdelivery.connection.update("update publisherpayments set amount= #{newbalance.to_s} where publisher_id= #{publisher_id.to_s}")    
        end
      return PPT_SUCCESS
    rescue Exception => e 
      puts "An exception has occurred in the creditpublisher of billing component. The Exception is #{e.to_s}"
      return EXCEPTION
    end
  end 
  
  def debitAdvertiser(advId,cost,deliveryId)
      begin
      balance    = 0.0
      newbalance = 0.0
      begin
            balance = Adsdelivery.find_by_sql("select balance from advertiseraccounts where advertiser_id=#{advId.to_s}")
      rescue 
      puts "exception 9..."
        Adsdelivery.establish_connection(  
                                :adapter => "mysql",  
                                :host => "192.168.1.4",  
                                :database => "zestadz_development",
                                :username => "root",
                                :password => "sqlworx@ch"
                                )
          balance = Adsdelivery.find_by_sql("select balance from advertiseraccounts where advertiser_id=#{advId.to_s}")
        end
      balance[0].balance.to_f
      newbalance = balance[0].balance.to_f - cost.to_f
      if(newbalance < 0)
        begin
              deleteDelivery = Adsdelivery.connection.update("update adsdeliveries set status='no amount' where id = #{deliveryId.to_s}")
        rescue 
        puts "exception 10..."
        Adsdelivery.establish_connection(  
                                :adapter => "mysql",  
                                :host => "192.168.1.4",  
                                :database => "zestadz_development",
                                :username => "root",
                                :password => "sqlworx@ch"
                                )
          deleteDelivery = Adsdelivery.connection.update("update adsdeliveries set status='no amount' where id = #{deliveryId.to_s}")
        end
      end 
        begin
              updateaccount =Adsdelivery.connection.update("update advertiseraccounts set balance = #{newbalance.to_s} where advertiser_id=#{advId.to_s}")
              campaign_id =Adsdelivery.find_by_sql("select campaign_id from adsdeliveries where id=#{deliveryId}")
              sql="update campaigns set amount_spent=amount_spent+#{cost.to_f} where id=#{campaign_id[0].campaign_id}"
              amount_spent =Adsdelivery.connection.update(sql)
        rescue 
        puts "exception 11..."
        Adsdelivery.establish_connection(  
                                :adapter => "mysql",  
                                :host => "192.168.1.4",  
                                :database => "zestadz_development",
                                :username => "root",
                                :password => "sqlworx@ch"
                                )
              updateaccount =Adsdelivery.connection.update("update advertiseraccounts set balance = #{newbalance.to_s} where advertiser_id=#{advId.to_s}")
              campaign_id =Adsdelivery.find_by_sql("select campaign_id from adsdeliveries where id=#{deliveryId}")
              sql="update campaigns set amount_spent=amount_spent+#{cost.to_f} where id=#{campaign_id[0].campaign_id}"
              amount_spent =Adsdelivery.connection.update(sql)
        end
        return ADV_DEBIT_SUCCESS
    rescue Exception => e 
      puts "An exception is thrown in debitadvertiser of billing component. The Exception is #{e.to_s}"
      return EXCEPTION
    end
  end  
    
  def smsSent(pNo,carrierId,time)
    begin
      insertSms  =Adsdelivery.connection.insert("insert into smsdeliveries (phone_number,time_delivered,carrier_id)values('#{pNo.to_s}', '#{time.to_s}' , '#{carrierId.to_s}')")
    rescue Exception => e
puts "exception 12..."    
          Adsdelivery.establish_connection(  
                                :adapter => "mysql",  
                                :host => "192.168.1.4",  
                                :database => "zestadz_development",
                                :username => "root",
                                :password => "sqlworx@ch"
                                )
        insertSms  =Adsdelivery.connection.insert("insert into smsdeliveries (phone_number,time_delivered,carrier_id)values('#{pNo.to_s}', '#{time.to_s}' , '#{carrierId.to_s}')")
    end
  end  
end
