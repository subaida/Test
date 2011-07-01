#~ require 'dbi'
#~ require 'rubygems' 
class WhyNoAds
  def create
    begin
     dbh = DBI.connect("DBI:MYSQL:zestadz:192.168.0.15", "root", "mysql")
     ads_sql = "select c.country as country,c.carriers as carrier,c.devices as device,c.device_models as model,a.forbidden_adclients as fad from advertiseraccounts acc,ads a, campaigns c where acc.advertiser_id=c.advertiser_id and c.id=a.campaign_id and c.daily_budget_status=1 and CURDATE() between c.starting_on and c.ending_on and IF(c.houseads=1,a.status='Approved' and c.status='Approved',a.status='Approved' and c.status='Approved'and acc.balance > 5  and c.daily_amount_spent < (c.budget_per_day - 5) and c.amount_spent < (c.max_budget - 5)) group by country,carrier,device,model,fad"
            ads_row = dbh.execute(ads_sql)
            grouped_ads=Hash.new
            while ads = ads_row.fetch do
                #initializing the countries variable with targetted countries
                #splitting the targrtted locations(country) string and having it into array for checking that how many countries is this ad targetted for
                if (ads["carrier"]==nil or ads["carrier"].strip=="")
                    carriers = []
                else
                    #else we set all the targetted device names
                    carriers = ads["carrier"].split(",").uniq
                end
                #initializing devices variable with targetted devices and model
                if (ads["device"]==nil or ads["device"].strip=="")
                    devices = []
                else
                    #else we set all the targetted device names
                    devices = ads["device"].split(",").uniq
                end
                if (ads["model"]==nil or ads["model"].strip=="")
                    models = []
                else
                    #else we set all the targetted device names
                    models = ads["model"].split(",").uniq
                end
                if (ads["fad"]==nil or ads["fad"].strip=="")
                    fads = []
                else
                    #else we set all the targetted device names
                    temp_fads=(ads["fad"].to_s.chop)
                    temp_fads.slice!(0)
                    fads = temp_fads.split("--").uniq
                end
                #looping through all the targetter countries in the countries array variable
                for ad_country in carriers
                    #~ country = ad_country.gsub(" ","") unless (ad_country==nil or ad_country.strip=="")
                    unless (ad_country==nil or ad_country.strip=="")
                        #looping through all the targetted devices in the devices array variable  
                        countryName = ad_country.strip.upcase.split(".")[0]
                        carrierName = ad_country.strip.upcase.split(".")[1]
                        if grouped_ads.keys.include?(countryName)
                            if grouped_ads[countryName]["carrier"].include?("ALL")
                               grouped_ads[countryName]["carrier"] = ["ALL"]
                            else  
                               grouped_ads[countryName]["carrier"].concat([carrierName]).uniq!
                            end
                             if grouped_ads[countryName]["devices"].include?("ALL DEVICES")
                               grouped_ads[countryName]["devices"] = ["ALL DEVICES"]
                            else  
                               grouped_ads[countryName]["devices"].concat(devices).uniq!
                            end        
                             
                            if grouped_ads[countryName]["models"].include?("ALL.ALL")
                               grouped_ads[countryName]["models"] = ["ALL.ALL"]
                            else  
                               grouped_ads[countryName]["models"].concat(models).uniq!
                            end 
                            grouped_ads[countryName]["fad"].concat(fads).uniq!
                        else
                            value = {"carrier"=>[(carrierName.include?("ALL")) ? "ALL" : carrierName],"devices"=>(devices.include?("ALL DEVICES")) ? ["ALL DEVICES"] : devices,"models"=>(models.include?("ALL.ALL")) ? ["ALL.ALL"] : models,"fad"=>fads}
                            grouped_ads.store(countryName,value)
                        end
                        countryName = carrierName = value = nil
                    end
                end
                c = countries = carriername = carriers = devices = chan = channels = mobile_properties = mobile_property = keywords = keyword = ad_medium = metrics = cost = country = country_carrier = all_carriers = device = property = device_manufacturer = ranked_ad = ad_banner = temp_fads=fads=nil
            end
            return grouped_ads
          end
  rescue Exception=>e
      puts"Error occurred in why_no_ads.rb :: #{e}"
  end
end
#~ a=WhyNoAds.new.create
#~ puts a.inspect