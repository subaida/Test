require 'dbi'
 class Populator
    def populate
      begin
        puts"populator has started successfully------ #{Time.now}"
        loopStart=Hash.new()
        #loopStart={'1'=>'2009-10-12','2'=>'2009-10-13','3'=>'2009-10-14','4'=>'2009-10-15','5'=>'2009-10-16','6'=>'2009-10-17','7'=>'2009-10-18','8'=>'2009-10-19','9'=>'2009-10-20','10'=>'2009-10-21','11'=>'2009-10-22','12'=>'2009-10-23','13'=>'2009-10-24','14'=>'2009-10-25','15'=>'2009-10-26','16'=>'2009-10-27','17'=>'2009-10-28','18'=>'2009-10-29','19'=>'2009-10-30','20'=>'2009-10-31','21'=>'2009-11-01','22'=>'2009-11-02','23'=>'2009-11-03','24'=>'2009-11-04','25'=>'2009-11-05','26'=>'2009-11-06','27'=>'2009-11-07','28'=>'2009-11-08','29'=>'2009-11-09','30'=>'2009-11-10','31'=>'2009-11-11','32'=>'2009-11-12','33'=>'2009-11-13','34'=>'2009-11-14','35'=>'2009-11-15','36'=>'2009-11-16','37'=>'2009-11-17','38'=>'2009-11-18','39'=>'2009-11-19','40'=>'2009-11-20','41'=>'2009-11-21','42'=>'2009-11-22','43'=>'2009-11-23','44'=>'2009-11-24','45'=>'2009-11-25','46'=>'2009-11-26','47'=>'2009-11-27','48'=>'2009-11-28','49'=>'2009-11-29','50'=>'2009-11-30','51'=>'2009-12-01','52'=>'2009-12-02','53'=>'2009-12-03','54'=>'2009-12-04','55'=>'2009-12-05','56'=>'2009-12-06','57'=>'2009-12-07','58'=>'2009-12-08','59'=>'2009-12-09','60'=>'2009-12-10','61'=>'2009-12-11','62'=>'2009-12-12','63'=>'2009-12-13','64'=>'2009-12-14','65'=>'2009-12-15','66'=>'2009-12-16','67'=>'2009-12-17','68'=>'2009-12-18','69'=>'2009-12-19','70'=>'2009-12-20','71'=>'2009-12-21','72'=>'2009-12-22','73'=>'2009-12-23','74'=>'2009-12-24','75'=>'2009-12-25','76'=>'2009-12-26','77'=>'2009-12-27','78'=>'2009-12-28','79'=>'2009-12-29','80'=>'2009-12-30','81'=>'2009-12-31','82'=>'2010-01-01','83'=>'2010-01-02','84'=>'2010-01-03','85'=>'2010-01-04','86'=>'2010-01-05','87'=>'2010-01-06','88'=>'2010-01-07','89'=>'2010-01-08','90'=>'2010-01-09','91'=>'2010-01-10','92'=>'2010-01-11','93'=>'2010-01-12','94'=>'2010-01-13','95'=>'2010-01-14','96'=>'2010-01-15','97'=>'2010-01-16','98'=>'2010-01-17','99'=>'2010-01-18','100'=>'2010-01-19','101'=>'2010-01-20','102'=>'2010-01-21','103'=>'2010-01-22','104'=>'2010-01-23','105'=>'2010-01-24','106'=>'2010-01-25','107'=>'2010-01-26','108'=>'2010-01-27','109'=>'2010-01-28','110'=>'2010-01-29','111'=>'2010-01-30','112'=>'2010-01-31','113'=>'2010-02-01','114'=>'2010-02-02','115'=>'2010-02-03','116'=>'2010-02-04','117'=>'2010-02-05'}
        loopStart={'1'=>'2009-12-20','2'=>'2009-12-21'}
        for i in 1..loopStart.size
            start_counter=loopStart["#{i}"]
            #~ #=============================advertiser summary==================================
            #~ @db_conn = DBI.connect("DBI:MYSQL:zestadz_analytics:localhost","root","mysql")
            #~ @adv_rec=@db_conn.execute("select SQL_NO_CACHE metrics, ad_client_type, sum(impressions) impression, sum(clicks) as click, sum(amount_spent) as amt_spent,sum(gross_profit) as grs_profit, sum(zestadz_revenue) as zest_revenue,sum(unique_visitors) as uniq_visitors, advertiser_id, campaign_id, ad_id,delivery_hour, delivery_date from campaigns_summaries where delivery_date='#{start_counter}' group by delivery_date, ad_id order by null")
            #~ @db_conn.disconnect
            #~ @db_conn = DBI.connect("DBI:MYSQL:zestadz_analytics:localhost","root","mysql")
            #~ for row in @adv_rec
                #~ @db_conn.execute("insert into test_advertiser_summaries(metrics,ad_client_type,impressions,clicks,amount_spent,gross_profit,zestadz_revenue,unique_visitors,advertiser_id,campaign_id,ad_id,delivery_hour,delivery_date) VALUES ('#{row['metrics']}','#{row['ad_client_type']}',#{row['impression']},#{row['click']},#{row['amt_spent']},#{row['grs_profit']},#{row['zest_revenue']},'#{row['uniq_visitors']}',#{row['advertiser_id']},#{row['campaign_id']},#{row['ad_id']},#{row['delivery_hour']},'#{row['delivery_date']}')")
            #~ end
            #~ @db_conn.disconnect
            #~ sleep(60)
            #~ #=============================publisher summary=================================
            #~ @db_conn = DBI.connect("DBI:MYSQL:zestadz_analytics:localhost","root","mysql")
            #~ @pub_rec=@db_conn.execute("select SQL_NO_CACHE ad_client_type, ad_type, sum(impressions) as impression, sum(clicks) as click, sum(fill_rate) as fl_rate, sum(requests_unique_visitors) as sum_visitor, sum(revenue) as sum_revenue,pub_id, client_id, delivery_hour, delivery_date from adclients_summaries where delivery_date='#{start_counter}' group by delivery_date,pub_id,client_id order by null")
            #~ @db_conn.disconnect
            #~ @db_conn = DBI.connect("DBI:MYSQL:zestadz_analytics:localhost","root","mysql")
            #~ for row in @pub_rec
                #~ @db_conn.execute("insert into test_publisher_summaries(ad_client_type,ad_type,impressions,clicks,fill_rate,requests_unique_visitors,revenue,pub_id,client_id,delivery_hour,delivery_date) VALUES ('#{row['ad_client_type']}','#{row['ad_type']}',#{row['impression']},#{row['click']},#{row['fl_rate']},#{row['sum_visitor']},#{row['sum_revenue']},#{row['pub_id']},#{row['client_id']},#{row['delivery_hour']},'#{row['delivery_date']}')")
            #~ end
            #~ @db_conn.disconnect
            #~ sleep(60)
            #~ #==============================campaigns summary=================================
            #~ @db_conn = DBI.connect("DBI:MYSQL:zestadz_analytics:localhost","root","mysql")
            #~ @pub_rec=@db_conn.execute("select SQL_NO_CACHE metrics, ad_client_type, sum(impressions) impression, sum(clicks) as click, sum(amount_spent) as amt_spent,sum(gross_profit) as grs_profit, sum(zestadz_revenue) as zest_revenue,handset,handset_model,sum(unique_visitors) as uniq_visitors, advertiser_id, campaign_id, ad_id,continent_code,country_code, delivery_hour, delivery_date from campaigns_summaries where delivery_date='#{start_counter}' group by delivery_date, ad_id,continent_code,country_code,handset order by null")
            #~ @db_conn.disconnect
            #~ @db_conn = DBI.connect("DBI:MYSQL:zestadz_analytics:localhost","root","mysql")
            #~ for row in @pub_rec
                #~ @db_conn.execute("insert into test_campaigns_summaries(metrics,ad_client_type,impressions,clicks,amount_spent,gross_profit,zestadz_revenue,handset,handset_model,unique_visitors,advertiser_id,campaign_id,ad_id,continent_code,country_code,delivery_hour,delivery_date) VALUES ('#{row['metrics']}','#{row['ad_client_type']}',#{row['impression']},#{row['click']},#{row['amt_spent']},#{row['grs_profit']},#{row['zest_revenue']},\"#{row['handset']}\",\"#{row['handset_model']}\",'#{row['uniq_visitors']}',#{row['advertiser_id']},#{row['campaign_id']},#{row['ad_id']},\"#{row['continent_code']}\",\"#{row['country_code']}\",#{row['delivery_hour']},'#{row['delivery_date']}')")
            #~ end
            #~ @db_conn.disconnect
            #~ sleep(60)
            #~ #==============================adclient summary==================================
            #~ @db_conn = DBI.connect("DBI:MYSQL:zestadz_analytics:localhost","root","mysql")
            #~ @pub_rec=@db_conn.execute("select SQL_NO_CACHE ad_client_type, ad_type, sum(impressions) as impression, sum(clicks) as click, sum(fill_rate) as fl_rate, sum(requests_unique_visitors) as sum_visitor, sum(revenue) as sum_revenue, adclient_name,handset,handset_model,user_agent,pub_id, client_id, continent_code, country_code, delivery_hour, delivery_date from adclients_summaries where delivery_date='#{start_counter}' group by delivery_date, client_id,continent_code,country_code,handset order by null")
            #~ @db_conn.disconnect
            #~ @db_conn = DBI.connect("DBI:MYSQL:zestadz_analytics:localhost","root","mysql")
            #~ for row in @pub_rec
                #~ @db_conn.execute("insert into test_adclients_summaries(ad_client_type,ad_type,impressions,clicks,fill_rate,requests_unique_visitors,revenue,adclient_name,handset,handset_model,user_agent,pub_id,client_id,continent_code,country_code,delivery_hour,delivery_date) VALUES ('#{row['ad_client_type']}','#{row['ad_type']}',#{row['impression']},#{row['click']},#{row['fl_rate']},#{row['sum_visitor']},#{row['sum_revenue']},\"#{row['adclient_name']}\",\"#{row['handset']}\",\"#{row['handset_model']}\",\"#{row['user_agent']}\",#{row['pub_id']},#{row['client_id']},\"#{row['continent_code']}\",\"#{row['country_code']}\",#{row['delivery_hour']},'#{row['delivery_date']}')")
            #~ end
            #~ @db_conn.disconnect
            #~ sleep(60)
            #~ #========================adv carriers========================================
            #~ @db_conn = DBI.connect("DBI:MYSQL:zestadz_analytics:localhost","root","mysql")
            #~ @pub_rec=@db_conn.execute("select SQL_NO_CACHE owner, sum(requests) as request,advertiser_id,campaign_id,ad_id,delivery_hour, delivery_date from adv_carriers where delivery_date='#{start_counter}' group by delivery_date, ad_id,owner order by null")
            #~ @db_conn.disconnect
            #~ @db_conn = DBI.connect("DBI:MYSQL:zestadz_analytics:localhost","root","mysql")
            #~ for row in @pub_rec
                #~ @db_conn.execute("insert into test_adv_carriers(owner,requests,advertiser_id,campaign_id,ad_id,delivery_hour,delivery_date) VALUES (\"#{(row['owner']!=nil && row['owner']!='') ? row['owner'].to_s.gsub(/([,])/,'') : row['owner']}\",#{row['request']},#{row['advertiser_id']},#{row['campaign_id']},#{row['ad_id']},#{row['delivery_hour']},'#{row['delivery_date']}')")
            #~ end
            #~ @db_conn.disconnect
            #~ sleep(60)
            #~ #==========================adv properties======================================
            #~ @db_conn = DBI.connect("DBI:MYSQL:zestadz_analytics:localhost","root","mysql")
            #~ @pub_rec=@db_conn.execute("select SQL_NO_CACHE user_agent , sum(requests) as request,handset,handset_model,advertiser_id,campaign_id, ad_id,delivery_hour, delivery_date from adv_devicesproperties where delivery_date='#{start_counter}' group by delivery_date, ad_id,handset,handset_model order by null")
            #~ @db_conn.disconnect
            #~ @db_conn = DBI.connect("DBI:MYSQL:zestadz_analytics:localhost","root","mysql")
            #~ for row in @pub_rec
                #~ @db_conn.execute("insert into test_adv_devicesproperties(user_agent,requests,handset,handset_model,advertiser_id,campaign_id,ad_id,delivery_hour,delivery_date) VALUES(\"#{row['user_agent']}\",#{row['request']},\"#{row['handset']}\",\"#{row['handset_model']}\",#{row['advertiser_id']},#{row['campaign_id']},#{row['ad_id']},#{row['delivery_hour']},'#{row['delivery_date']}')")
            #~ end
            #~ @db_conn.disconnect
            #~ sleep(60)
            #~ #==========================pub channels======================================
            #~ @db_conn = DBI.connect("DBI:MYSQL:zestadz_analytics:localhost","root","mysql")
            #~ @pub_rec=@db_conn.execute("select SQL_NO_CACHE channel, sum(requests) as request,sum(fill_rate) as fl_rate, pub_id, client_id, ad_client_type, delivery_hour, delivery_date from pub_channels where delivery_date='#{start_counter}' group by delivery_date, client_id,channel order by null")
            #~ @db_conn.disconnect
            #~ @db_conn = DBI.connect("DBI:MYSQL:zestadz_analytics:localhost","root","mysql")
            #~ for row in @pub_rec
                #~ @db_conn.execute("insert into test_pub_channels(channel,requests,fill_rate,pub_id,client_id,ad_client_type,delivery_hour,delivery_date) VALUES(\"#{row['channel']}\",#{row['request']},#{row['fl_rate']},#{row['pub_id']},#{row['client_id']},'#{row['ad_client_type']}',#{row['delivery_hour']},'#{row['delivery_date']}')")
            #~ end
            #~ @db_conn.disconnect
            #~ sleep(60)
            #~ #===========================pub carriers=====================================
            #~ @db_conn = DBI.connect("DBI:MYSQL:zestadz_analytics:localhost","root","mysql")
            #~ @pub_rec=@db_conn.execute("select SQL_NO_CACHE owner, sum(requests) as request,sum(fill_rate) as fl_rate, pub_id, client_id, ad_client_type, delivery_hour, delivery_date from pub_carriers where delivery_date='#{start_counter}' group by delivery_date, client_id,owner order by null")
            #~ @db_conn.disconnect
            #~ @db_conn = DBI.connect("DBI:MYSQL:zestadz_analytics:localhost","root","mysql")
            #~ for row in @pub_rec
                #~ @db_conn.execute("insert into test_pub_carriers(owner,requests,fill_rate,pub_id,client_id,ad_client_type,delivery_hour,delivery_date) VALUES(\"#{(row['owner']!=nil && row['owner']!='') ? row['owner'].to_s.gsub(/([,])/,'') : row['owner']}\",#{row['request']},#{row['fl_rate']},#{row['pub_id']},#{row['client_id']},'#{row['ad_client_type']}',#{row['delivery_hour']},'#{row['delivery_date']}')")
            #~ end
            #~ @db_conn.disconnect
            #~ sleep(60)
            #=============================pub urls===================================
            @db_conn = DBI.connect("DBI:MYSQL:zestadz_analytics:localhost","root","mysql")
            @pub_rec=@db_conn.execute("select SQL_NO_CACHE delivery_date, delivery_hour, pub_id, client_id, url, sum(requests) as request,sum(fill_rate) as fl_rate from pub_urls where delivery_date='#{start_counter}' and (requests > 0 or fill_rate > 0) group by delivery_date, client_id, url order by client_id,requests desc")
            @db_conn.disconnect
            @db_conn = DBI.connect("DBI:MYSQL:zestadz_analytics:localhost","root","mysql")
            count=0
            global_count=0
            flag=nil
            requests=0
            url=''
            fill_rate=0
            pub_id=0
            client_id=0
            delivery_hour=0
            delivery_date=''
            url_flag=true
            for row in @pub_rec
                global_count+=1
                if flag!=nil and flag!=row['client_id'].to_i
                    if count>5
                        insert_query="insert into test_pub_urls(url,requests,fill_rate,pub_id,client_id,delivery_hour,delivery_date) VALUES (\"#{url}\",#{requests},#{fill_rate},#{pub_id},#{client_id},#{delivery_hour},'#{delivery_date}')"
                       @db_conn.execute(insert_query)
                    end
                    count=0
                    requests=0
                    fill_rate=0
                    url=''
                    pub_id=0
                    client_id=0
                    delivery_hour=0
                    delivery_date=''  
                end
                flag=row['client_id'].to_i
                count+=1
                if (count.to_i<=5)
                    insert_query="insert into test_pub_urls(url,requests,fill_rate,pub_id,client_id,delivery_hour,delivery_date) VALUES (\"#{row['url']}\",#{row['request']},#{row['fl_rate']},#{row['pub_id']},#{row['client_id']},#{row['delivery_hour']},'#{row['delivery_date']}')"
                    url_flag=true
                else
                    url_flag=false
                    requests+=row['request'].to_i
                    fill_rate+=row['fl_rate'].to_i
                    url='Others'
                    pub_id=row['pub_id']
                    client_id=row['client_id']
                    delivery_hour=row['delivery_hour']
                    delivery_date=row['delivery_date']
                    if(@pub_rec.rows.to_i==global_count.to_i)
                      url_flag=true
                      insert_query="insert into test_pub_urls(url,requests,fill_rate,pub_id,client_id,delivery_hour,delivery_date) VALUES (\"#{url}\",#{requests},#{fill_rate},#{pub_id},#{client_id},#{delivery_hour},'#{delivery_date}')"
                    end
                end
                @db_conn.execute(insert_query) if url_flag==true
            end
            @db_conn.disconnect
            sleep(60)
            #================================================================
        end
        puts"dump finished---------------#{Time.now}"  
        rescue Exception=>e
          puts"An error occured and the exception is :: #{e.to_s}"
        end
    end
end
@obj = Populator.new
@obj.populate
