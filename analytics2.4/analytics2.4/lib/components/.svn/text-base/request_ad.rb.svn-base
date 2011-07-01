require 'dbi'
class Request_Ad
  def initialize
    @dbh = DBI.connect("DBI:MYSQL:zestadz_development:192.168.1.4","root","sqlworx@ch")
  end
  def sortAds
    begin
      ads="select distinct(a.id) as ad_id, a.ad_type, a.ad_text, a.ad_picture, a.ad_size, c.id as campaign_id, c.keywords, c.cost_metrics, c.CPC, c.CPM, c.handset_range, c.currency_symbol, ct.client_type, (select countryname from locs where id=cl.location_id) as location, (select cityname from locs where id=cl.location_id) as city from ads a, campaigns c, cclienttypes ct, clocations cl where a.status = 'Active' and c.status='Active' and a.campaign_id = c.id and CURDATE() between c.starting_on and c.ending_on and  c.max_budget > c.amount_spent and c.budget_per_day > (select CASE WHEN sum(bill_amount) IS NULL THEN 0 ELSE sum(bill_amount) END  from addeliveries where DATE_FORMAT(bill_date_time,'%Y-%m-%d') = CURDATE())"
      sth = @dbh.prepare(ads)
      sth.execute
      while row=sth.fetch do
        temp_cost = row['cost_metrics'] == 'CPC' ? row['CPC'] : row['CPM']
        #@dbh.execute("delete from sortedads")
        update_rank = "INSERT INTO sortedads (ad_id, type_of_ad, ad_text, ad_picture_url, ad_size, campaign_id, keywords, metric, cost, mobile_manufacturer_list, currency, ad_medium, location, city) VALUES (#{row['ad_id'].to_i},'#{row['ad_type'].to_s}', '#{row['ad_text'].to_s}', '#{row['ad_picture'].to_s}', '#{row['ad_size']}', #{row['campaign_id'].to_i}, '#{row['keywords'].to_s}', '#{row['cost_metrics'].to_s}', #{temp_cost.to_f}, '#{row['handset_range'].to_s}', '#{row['currency_symbol'].to_s}', '#{row['client_type'].to_s}', '#{row['location'].to_s}', '#{row['city'].to_s}')"
        update_rank_sql = @dbh.prepare(update_rank)
        update_rank_sql.execute
      end
    rescue Exception =>e  
      puts "ERROR :: SortedADS :"+e.to_s
    end
  end
end
requestAd=Request_Ad.new   
requestAd.sortAds
