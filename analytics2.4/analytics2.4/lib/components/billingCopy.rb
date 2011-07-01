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

require "dbi"


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
  @@debug = true
    
  def initialize       
    begin        
      @dbconn = DBI.connect("DBI:Mysql:zestadz_development:192.168.1.4", "root", "sqlworx@ch")
      return DATABASE_SUCCESS
    rescue Exception =>e
      puts "An exception has occurred while connecting to the database. The Exception is #{e.to_s}"
      @dbconn = DBI.connect("DBI:Mysql:zestadz_development:192.168.1.4", "root", "sqlworx@ch")
      return DATABASE_FAILED
    else
    end
  end
    
    
    
  def processBill(publisher_id, ua, user_agent, ipaddress, remote_ip, campaign_id, ad_id, metrics, cost, ad_type, ad_client_type, keywords, sex, demographic, city, platform, dlr_id, user_id, client_id, delivery_time, software_version, region, country, fc_id, status, pay_status, cType, from_display)
    begin
      zestadz_revenue = 0.0
      gross_margin = 0.0
      gross_profit = 0.0
      impressions = 0
      currency_symbol = '$'
      clicks = 0
      advertiser_id = 0
      if @dbconn!=nil
        ppt = @dbconn.select_one('SELECT id, amount FROM publisherpayments WHERE publisher_id = '+publisher_id.to_s)                    
      else
        @dbconn = DBI.connect("DBI:Mysql:zestadz_development:192.168.1.4", "root", "sqlworx@ch")
        ppt = @dbconn.select_one('SELECT id, amount FROM publisherpayments WHERE publisher_id = '+publisher_id.to_s)                      
      end
      publisher_payments_id = ppt[0]
      amount = ppt[1]
      if(pay_status == "Fraud" or pay_status == "IpFraud")
        pay_status = "Fraud"
        adsdelivery = "insert into adsdeliveries(ua, user_agent, ipaddress, remote_ip, campaign_id, ad_id, metrics, cost, ad_type, ad_client_type, keywords, sex, demographic, city, platform, dlr_id, user_id, client_id, delivery_time, software_version, region, country, fc_id, pay_status, status, zestadz_revenue, gross_margin, gross_profit, impressions, clicks, advertiser_id, publisher_payments_id, currency_symbol) values('#{ua}', '#{user_agent}', '#{ipaddress}', '#{remote_ip}', #{campaign_id},#{ ad_id}, '#{metrics}', #{cost}, '#{ad_type}', '#{ad_client_type}', '#{keywords}', '#{sex}', '#{demographic}', '#{city}', '#{platform}', '#{dlr_id}', #{user_id}, #{client_id}, '#{delivery_time}', '#{software_version}', '#{region}', '#{country}', '#{fc_id}', '#{pay_status}', '#{status}', #{zestadz_revenue}, #{gross_margin}, #{gross_profit}, #{impressions}, #{clicks}, #{advertiser_id}, #{publisher_payments_id}, '#{currency_symbol}')"
        if @dbconn!=nil
          insertAd = @dbconn.do(adsdelivery)
        else
          @dbconn = DBI.connect("DBI:Mysql:zestadz_development:192.168.1.4", "root", "sqlworx@ch")
          insertAd = @dbconn.do(adsdelivery)
        end
        if !insertAd
          throw("Cannot insert record in Adsdeliveries table. Please check the data inserted.")
          return ADDL_FAILED
        end
      else
        if @dbconn!=nil
          campaign = @dbconn.select_one('select advertiser_id from campaigns where id= '+campaign_id.to_s)
        else
          @dbconn = DBI.connect("DBI:Mysql:zestadz_development:192.168.1.4", "root", "sqlworx@ch")
          campaign = @dbconn.select_one('select advertiser_id from campaigns where id= '+campaign_id.to_s)          
        end
        advertiser_id = campaign[0]
        #----------------new caluculation for billing----------------------
        
        if from_display=="impressions"
           # " impression(CPM)"
           # if cType=="sms"
	    if ad_client_type=="sms"
                if @dbconn!=nil
                    sms_charge = @dbconn.select_one('select sms_charge from publishers where id= '+publisher_id.to_s)
                else
                    @dbconn = DBI.connect("DBI:Mysql:zestadz_development:192.168.1.4", "root", "sqlworx@ch")
                    sms_charge = @dbconn.select_one('select sms_charge from publishers where id= '+publisher_id.to_s)
                end
                #cost = sms_charge['sms_charge']
                cost = "0.60"
                gross_profit = (cost.to_f - sms_charge['sms_charge'])
                zestadz_revenue = cost.to_f
                #gross_profit = temp_cost.to_f
                gross_margin = (gross_profit.to_f/zestadz_revenue.to_f)*100
            else
              # not an sms ,impression(CPM)
               # if cType=="wap" && ad_type=="Text"
		if ad_client_type=="wap" && ad_type=="Text"
                   # wap , text , impression(CPM)
                    cost = 0.0
                else
                   # wap , text+picture or picture , impression(CPM)
                    if @dbconn!=nil
                        publisher = @dbconn.select_one("select percentage from publishers where id=#{publisher_id}")
                    else
                        @dbconn = DBI.connect("DBI:Mysql:zestadz_development:192.168.1.4", "root", "sqlworx@ch")
                        publisher = @dbconn.select_one("select percentage from publishers where id=#{publisher_id}")
                    end
                    temp_cost = (cost.to_f * (100-publisher['percentage'].to_f))/100        
                    zestadz_revenue = cost.to_f
                    gross_profit = cost.to_f - temp_cost.to_f
                    if zestadz_revenue.to_f==0
                        gross_margin = 0.0
                    else
                        gross_margin = (gross_profit.to_f/zestadz_revenue.to_f)*100
                    end
                end
            end
        else
          # clicks(CPC)
         # if cType=="wap" || cType=="J2ME"
	   if ad_client_type=="wap" || ad_client_type=="J2ME"
              if @dbconn!=nil
                  publisher = @dbconn.select_one("select percentage from publishers where id=#{publisher_id}")
              else
                  @dbconn = DBI.connect("DBI:Mysql:zestadz_development:192.168.1.4", "root", "sqlworx@ch")
                  publisher = @dbconn.select_one("select percentage from publishers where id=#{publisher_id}")
              end
              temp_cost = (cost.to_f * publisher['percentage'].to_f)/100        
              zestadz_revenue = cost.to_f
              gross_profit = cost.to_f - temp_cost.to_f
              if zestadz_revenue.to_f==0
                  gross_margin = 0.0
              else
                  gross_margin = (gross_profit.to_f/zestadz_revenue.to_f)*100
              end
          end
          
        end
        
        #------------------------------------
        pay_status = "UnPaid"
        status = "Active"
        
        if from_display == "clicks" #Can be either impressions or clicks to keep count
          clicks = 1
          impressions = 0
        else
          impressions = 1
          clicks = 0
        end
        adsdelivery = "insert into adsdeliveries(ua, user_agent, ipaddress, remote_ip, campaign_id, ad_id, metrics, cost, ad_type, ad_client_type, keywords, sex, demographic, city, platform, dlr_id, user_id, client_id, delivery_time, software_version, region, country, fc_id, pay_status, status, zestadz_revenue, gross_margin, gross_profit, impressions, clicks, advertiser_id, publisher_payments_id, currency_symbol) values('#{ua}', '#{user_agent}', '#{ipaddress}', '#{remote_ip}', #{campaign_id},#{ ad_id}, '#{metrics}', #{cost.to_f}, '#{ad_type}', '#{ad_client_type}', '#{keywords}', '#{sex}', '#{demographic}', '#{city}', '#{platform}', '#{dlr_id}', #{user_id}, #{client_id}, '#{delivery_time}', '#{software_version}', '#{region}', '#{country}', '#{fc_id}', '#{pay_status}', '#{status}', #{zestadz_revenue}, #{gross_margin}, #{gross_profit}, #{impressions}, #{clicks}, #{advertiser_id}, #{publisher_payments_id}, '#{currency_symbol}')"
        if from_display == "clicks"
          if @dbconn!=nil
            insertAd = @dbconn.do(adsdelivery)
            selectDelivery = @dbconn.select_one('select max(id) as max from adsdeliveries ')
            selectAd = @dbconn.select_one("select clicks from ads where id = "+ad_id.to_s)
          else
            @dbconn = DBI.connect("DBI:Mysql:zestadz_development:192.168.1.4", "root", "sqlworx@ch")
            insertAd = @dbconn.do(adsdelivery)
            selectDelivery = @dbconn.select_one('select max(id) as max from adsdeliveries ')
            selectAd = @dbconn.select_one("select clicks from ads where id = "+ad_id.to_s)
          end
          adClicks = selectAd[0]
          adClicks = 1 + adClicks.to_i
          if @dbconn!=nil
            updateAd = @dbconn.execute('update ads set clicks = ' + adClicks.to_s + ' where id = '+ad_id.to_s);
          else
            @dbconn = DBI.connect("DBI:Mysql:zestadz_development:192.168.1.4", "root", "sqlworx@ch")
            updateAd = @dbconn.execute('update ads set clicks = ' + adClicks.to_s + ' where id = '+ad_id.to_s);
          end
        else
          if @dbconn!=nil
            insertAd = @dbconn.do(adsdelivery)
            selectDelivery = @dbconn.select_one('select max(id) as max from adsdeliveries ')
            selectAd = @dbconn.select_one("select impressions from ads where id = "+ad_id.to_s)
          else
            @dbconn = DBI.connect("DBI:Mysql:zestadz_development:192.168.1.4", "root", "sqlworx@ch")
            insertAd = @dbconn.do(adsdelivery)
            selectDelivery = @dbconn.select_one('select max(id) as max from adsdeliveries ')
            selectAd = @dbconn.select_one("select impressions from ads where id = "+ad_id.to_s)
          end
          adImpressions = selectAd[0]
          adImpressions = 1 + adImpressions.to_i
          if @dbconn!=nil
            updateAd = @dbconn.execute('update ads set impressions = ' + adImpressions.to_s + ' where id = '+ad_id.to_s);
          else
            @dbconn = DBI.connect("DBI:Mysql:zestadz_development:192.168.1.4", "root", "sqlworx@ch")
            updateAd = @dbconn.execute('update ads set impressions = ' + adImpressions.to_s + ' where id = '+ad_id.to_s);
          end
        end
        if !updateAd
          throw("Cannot insert record in ads. Please check the data inserted.")
          return ADS_FAILED
        end
        if(pay_status == "UnPaid")
          if(debitAdvertiser(advertiser_id,cost,selectDelivery['max']) == ADV_DEBIT_SUCCESS)
            creditPublisher(amount, publisher_id ,cost)
            #return ADV_DEBIT_SUCCESS
          else
            #return ADV_DEBIT_FAILED
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
      if @dbconn!=nil
        publisher = @dbconn.select_one("select percentage from publishers where id=#{publisher_id}")
      else
        @dbconn = DBI.connect("DBI:Mysql:zestadz_development:192.168.1.4", "root", "sqlworx@ch")
        publisher = @dbconn.select_one("select percentage from publishers where id=#{publisher_id}")
      end
      temp_cost = (cost.to_f * publisher['percentage'].to_f)/100
      newbalance = amount.to_f + temp_cost.to_f      
      if @dbconn!=nil
        updateaccount = @dbconn.do('update publisherpayments set amount="'+newbalance.to_s+'" where publisher_id='+publisher_id.to_s)    
      else
        @dbconn = DBI.connect("DBI:Mysql:zestadz_development:192.168.1.4", "root", "sqlworx@ch")
        updateaccount = @dbconn.do('update publisherpayments set amount="'+newbalance.to_s+'" where publisher_id='+publisher_id.to_s)    
      end
      if !updateaccount
        throw("Cannot insert record in publisherpayments table. Please the check the data inserted.")
        return PPT_FAILED
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
      if @dbconn!=nil
        balance = @dbconn.select_one('select balance from advertiseraccounts where advertiser_id='+advId.to_s)
      else
        @dbconn = DBI.connect("DBI:Mysql:zestadz_development:192.168.1.4", "root", "sqlworx@ch")
        balance = @dbconn.select_one('select balance from advertiseraccounts where advertiser_id='+advId.to_s)
      end
      newbalance = balance['balance'].to_f - cost.to_f
      if(newbalance < 0)
        if @dbconn!=nil
          deleteDelivery = @dbconn.execute("update adsdeliveries set status='no amount' where id = #{deliveryId.to_s}")
        else
          @dbconn = DBI.connect("DBI:Mysql:zestadz_development:192.168.1.4", "root", "sqlworx@ch")
          deleteDelivery = @dbconn.execute("update adsdeliveries set status='no amount' where id = #{deliveryId.to_s}")
        end
        if !deleteDelivery
          throw("Cannot delete record in adsdeliveries table. Please the check the data inserted.")
          return ADDL_FAILED
        end
      else
        if @dbconn!=nil
          updateaccount = @dbconn.execute('update advertiseraccounts set balance = "'+newbalance.to_s+'" where advertiser_id='+advId.to_s)
        else
          @dbconn = DBI.connect("DBI:Mysql:zestadz_development:192.168.1.4", "root", "sqlworx@ch")
          updateaccount = @dbconn.execute('update advertiseraccounts set balance = "'+newbalance.to_s+'" where advertiser_id='+advId.to_s)
        end
        if !updateaccount
          throw("Cannot update in advertiseraccounts table. Please the check the data inserted.")
          return ADACC_FAILED
        end
        if @dbconn!=nil
          campaign_id = @dbconn.select_one("select campaign_id from adsdeliveries where id=#{deliveryId}")
        else
          @dbconn = DBI.connect("DBI:Mysql:zestadz_development:192.168.1.4", "root", "sqlworx@ch")
          campaign_id = @dbconn.select_one("select campaign_id from addeliveries where id=#{deliveryId}")
        end
        sql="update campaigns set amount_spent=amount_spent+"+"#{cost.to_f} where id=#{campaign_id['campaign_id']}"
        if @dbconn!=nil
          amount_spent = @dbconn.execute(sql)
        else
          @dbconn = DBI.connect("DBI:Mysql:zestadz_development:192.168.1.4", "root", "sqlworx@ch")
          amount_spent = @dbconn.execute(sql)
        end
        if !amount_spent
          throw("Cannot update record in campaigns table. Please the check the data inserted.")
          return CAMP_FAILED
        end
        return ADV_DEBIT_SUCCESS
      end             
      #end
    rescue Exception => e 
      puts "An exception is thrown in debitadvertiser of billing component. The Exception is #{e.to_s}"
      return EXCEPTION
    end
  end  
    
  def smsSent(pNo,carrierId,time)
    begin
      insertSms = @dbconn.execute('insert into smsdeliveries (phone_number,time_delivered,carrier_id)values("'+pNo.to_s+'","'+time.to_s+'","'+carrierId.to_s+'")')
    rescue Exception => e 
    end
  end  
end
