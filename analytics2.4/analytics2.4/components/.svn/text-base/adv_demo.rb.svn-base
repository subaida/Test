require 'dbi'
require 'drb'
require 'AnalyticsDBConnection'
require 'rubygems'
require 'active_record'
ActiveRecord::Base.establish_connection(  
:adapter => "mysql",  
:host => HOSTNAME,  
:database => DATABASE,
:username => USERNAME,
:password => PASSWORD
#~ :host => "192.168.1.39",  
#~ :database => "zestadz_reports",
#~ :username => "root",
#~ :password => "mysql"
)
class Campaign < ActiveRecord::Base  
end
class Ad < ActiveRecord::Base  
end
class Advertiser < ActiveRecord::Base  
end
#~ class AdsdeliveryNew < ActiveRecord::Base  
#~ end
class AdvDemo

def initialize
  insert_adv_demo_record
end

def insert_adv_demo_record
      @owner=Array.new
      @url=Array.new
      @manufacture=Array.new
      k=0
      
      
      @impHash=Hash.new
      @clickHash=Hash.new
      @impHash={:a=>'2000',:b=>'2500',:c=>'3000',:d=>'3500',:e=>'4000',:f=>'4500',:g=>'5000',:h=>'5500',:i=>'6000',:j=>'1000',:k=>'1100',:l=>'1200',:m=>'1300',:n=>'1400',:o=>'1500',:p=>'1600',:q=>'1700',:r=>'1800',:s=>'1900'}
      @clickHash={'2000'=>'54','2500'=>'57','3000'=>'58','3500'=>'60','4000'=>'61','4500'=>'63','5000'=>'64','5500'=>'66','6000'=>'69','1000'=>'9','1100'=>'10','1200'=>'11','1300'=>'12','1400'=>'16','1500'=>'14','1600'=>'50','1700'=>'18','1800'=>'17','1900'=>'25'}
      @unique_user={'2000'=>'1750','2500'=>'1785','3000'=>'2556','3500'=>'380','4000'=>'425','4500'=>'550','5000'=>'660','5500'=>'740','6000'=>'5100','1000'=>'930','1100'=>'1020','1200'=>'800','1300'=>'1250','1400'=>'900','1500'=>'1410','1600'=>'1490','1700'=>'1560','1800'=>'1523','1900'=>'1753'}
      @cost=0.40
      def setValues
          @getImp = @impHash.values
          imp=@getImp[rand(@getImp.size)]
          click=@clickHash["#{imp}"]
          uniqueUser=@unique_user["#{imp}"]
          @@amtSpent=@cost*click.to_i
          @@zestRevenue=@@amtSpent*0.5
          @@imp=imp.to_i
          @@click=click.to_i
          @@uniqueUser=uniqueUser.to_i
      end
      @owner=["BHARTI TELEVENTURES LTD - ABTS","BHARTI TELESONIC","BHARTI TELETECH LIMITED","TATA TELESERVICES LTD","GMT BSNL DHULE","BSNL CGMM TELECOM FACTORY DEONAR MUMBAI" , "IDEA CELULAR","IONIDEA INTERACTIVE PVT LTD","BSNL DATA NETWORK BANGALORE","CELLONE BSNL", "HUTCHISON ESSAR","HUTCHISON ESSAR TELECOM LIMITED","RELIANCE-INFOCOM","RELIANCE COMMUNICATIONS LTD","3G","BHARTI AIRTEL LTD"]
      @url=["http://zestadz.com/ad/video/","http://mklix.com/wallpaper/download/","http://zibika.com/stock/nasdaq/","http://geehub.com/health/ad/","http://bolohealth.com/ad/calories/","http://alabot.com/video/six/ad/","http://yahoo.com/mobile/iphone/","http://rediff.com/poll/ad/","http://facebook.com/content/phone/ad","http://zapak.com/mobile/games/ad"]
      @manufacture=["Nokia","Sony Ericsson","Motorola","Samsumg","LG","Apple","O2","Blackberry","Orange","Philips","Panasonic","Benq"]
      @user_agent=["MOT-V3r/0E.C0.15R MIB/2.2.1 Profile/MIDP-2.0 Configuration/CLDC-1.1","Mozilla/4.0 (compatible; MSIE 6.0; Windows CE; IEMobile 6.8) SPV C200 /SW3.0 MSIE/6.0","Nokia6111","SAMSUNG-SGH-E100/T2 UP.Browser/6.1.0.6 (GUI) MMP/1.0","MOT-Z3/08.05.0BR MIB/BER2.2 Profile/MIDP-2.0 Configuration/CLDC-1.1 EGE/1.0","Mozilla/4.0 (compatible; MSIE 6.0; Windows CE; IEMobile 7.7) Sprint:MotoQ9c","SEC-SGHE310/1.0","Mozilla/5.0 (SymbianOS/9.2; U; Series60/3.1 NokiaE51-1/100.34.20; Profile/MIDP-2.0 Configuration/CLD","Nokia6301/2.0 (05.93) Profile/MIDP-2.1 Configuration/CLDC-1.1","SAMSUNG-SGH-X700/1.0 Profile/MIDP-2.0 Configuration/CLDC-1.1 UP.Browser/6.2.3.3.c.1.101 (GUI) MMP/2.0","SAMSUNG-SGH-A300/1.0 UP/4.1.19k UP.Browser/4.1.19k-XXXX","Mozilla/4.0 (compatible; MSIE 6.0; Windows CE; IEMobile 6.12) T-Mobile Dash","MOT-V3r/0E.C0.15R MIB/2.2.1 Profile/MIDP-2.0 Configuration/CLDC-1.1","MOT-V3r/0E.C0.15R MIB/2.2.1 Profile/MIDP-2.0 Configuration/CLDC-1.1","Mozilla/4.0 (compatible; MSIE 6.0; Windows CE; IEMobile 7.7) Sprint:MotoQ9c","SEC-SGHE315","SonyEricssonS500i/R8BE Browser/NetFront/3.3 Profile/MIDP-2.0 Configuration/CLDC-1.1","Nokia3650/1.0 SymbianOS/6.1 Series60/1.2 Profile/MIDP-1.0 Configuration/CLDC-1.0 004400231620145"]
                 begin
                      begin
                            k=0
                            adsid=Array.new
                            campaignid=Array.new
                            adclientsid=Array.new
                            advertiserid=Array.new
                            puts t = Time.now.strftime("%Y-%m-%d %H:%M:%S")
                            @info=Campaign.find_by_sql("select c.cpc cpc,c.cpm cpm,c.cost_metrics,c.advertiser_id advertiser_id,c.id campaign_id,a.id ad_id,adv.name advertiser_name,c.campaign_name campaign_name,a.name ad_name from campaigns c,advertisers adv,ads a where c.id=a.campaign_id and adv.id=c.advertiser_id and a.id in (1518,1517,1516,1515)")
                           # campaigns_summaries data
                           setValues
                           a="insert into campaigns_summaries (metrics, ad_client_type,impressions,clicks,cpc,cpm,ctr,amount_spent,gross_profit,zestadz_revenue,exceed_budget,advertiser_name,campaign_name,ad_name,country_name,advertiser_id,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values  ('#{@info[0].cost_metrics}','WAP','#{@@imp}','#{@@click}','#{@info[0].cpc}','#{@info[0].cpm}','#{(@@click/@@imp)*100}','#{@@amtSpent}','#{@@amtSpent}','#{@@zestRevenue}','0','#{@info[0].advertiser_name}','#{@info[0].campaign_name}','#{@info[0].ad_name}','','#{@info[0].advertiser_id}','#{@info[0].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())"
                           setValues
                           b="insert into campaigns_summaries (metrics, ad_client_type,impressions,clicks,cpc,cpm,ctr,amount_spent,gross_profit,zestadz_revenue,exceed_budget,advertiser_name,campaign_name,ad_name,country_name,advertiser_id,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values  ('#{@info[1].cost_metrics}','WAP','#{@@imp}','#{0}','#{0}','#{@info[1].cpm}','#{0}','#{@@imp*0.01}','#{@@imp*0.01}','#{(@@imp*0.01*0.5)}','0','#{@info[1].advertiser_name}','#{@info[1].campaign_name}','#{@info[1].ad_name}','','#{@info[1].advertiser_id}','#{@info[1].campaign_id}','#{@info[1].ad_id}',hour(curTime()),curDate(),now())"
                           setValues
                           c="insert into campaigns_summaries (metrics, ad_client_type,impressions,clicks,cpc,cpm,ctr,amount_spent,gross_profit,zestadz_revenue,exceed_budget,advertiser_name,campaign_name,ad_name,country_name,advertiser_id,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values  ('#{@info[2].cost_metrics}','SMS','#{@@imp}','#{0}','#{0}','#{@info[2].cpm}','#{0}','#{@@imp*0.01}','#{@@imp*0.01}','#{(@@imp*0.01)-(@@imp*0.01*0.2)}','0','#{@info[2].advertiser_name}','#{@info[2].campaign_name}','#{@info[2].ad_name}','','#{@info[2].advertiser_id}','#{@info[2].campaign_id}','#{@info[2].ad_id}',hour(curTime()),curDate(),now())"
                           setValues
                           d="insert into campaigns_summaries (metrics, ad_client_type,impressions,clicks,cpc,cpm,ctr,amount_spent,gross_profit,zestadz_revenue,exceed_budget,advertiser_name,campaign_name,ad_name,country_name,advertiser_id,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values  ('#{@info[3].cost_metrics}','WAP','#{@@imp}','#{@@click}','#{@info[3].cpc}','#{@info[3].cpm}','#{(@@click/@@imp)*100}','#{@@amtSpent}','#{@@amtSpent}','#{@@zestRevenue}','0','#{@info[3].advertiser_name}','#{@info[3].campaign_name}','#{@info[3].ad_name}','','#{@info[3].advertiser_id}','#{@info[3].campaign_id}','#{@info[3].ad_id}',hour(curTime()),curDate(),now())"
                          Campaign.connection.insert(a)
                          Campaign.connection.insert(b)
                          Campaign.connection.insert(c)
                          Campaign.connection.insert(d)
                           
                           # adv_carriers data
                           a="insert into adv_carriers (owner, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('#{@owner[rand(15)]}','#{rand(10)}','#{@info[0].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())"
                           b="insert into adv_carriers (owner, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('#{@owner[rand(15)]}','#{rand(10)}','#{@info[1].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())"
                           c="insert into adv_carriers (owner, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('#{@owner[rand(15)]}','#{rand(10)}','#{@info[2].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())"
                           d="insert into adv_carriers (owner, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('#{@owner[rand(15)]}','#{rand(10)}','#{@info[3].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())"
                          Campaign.connection.insert(a)
                          Campaign.connection.insert(b)
                          Campaign.connection.insert(c)
                          Campaign.connection.insert(d)
                          
                          
                          #adv_handsets
                          a="insert into adv_handsets (manufacture, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('#{@manufacture[rand(11)]}','#{rand(10)}','#{@info[0].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())"
                          b="insert into adv_handsets (manufacture, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('#{@manufacture[rand(11)]}','#{rand(10)}','#{@info[1].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())"
                          c="insert into adv_handsets (manufacture, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('#{@manufacture[rand(11)]}','#{rand(10)}','#{@info[2].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())"
                          d="insert into adv_handsets (manufacture, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('#{@manufacture[rand(11)]}','#{rand(10)}','#{@info[3].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())"
                          Campaign.connection.insert(a)
                          Campaign.connection.insert(b)
                          Campaign.connection.insert(c)
                          Campaign.connection.insert(d)
                           
                          #adv_handsets
                          a="insert into adv_devicesproperties (user_agent, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('#{@user_agent[rand(17)]}','#{rand(10)}','#{@info[0].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())"
                          b="insert into adv_devicesproperties (user_agent, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('#{@user_agent[rand(17)]}','#{rand(10)}','#{@info[1].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())"
                          c="insert into adv_devicesproperties (user_agent, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('#{@user_agent[rand(17)]}','#{rand(10)}','#{@info[2].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())"
                          d="insert into adv_devicesproperties (user_agent, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('#{@user_agent[rand(17)]}','#{rand(10)}','#{@info[3].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())"
                          Campaign.connection.insert(a)
                          Campaign.connection.insert(b)
                          Campaign.connection.insert(c)
                          Campaign.connection.insert(d)
                                
                          # adv_geolocations data
                          e="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AS','IN','ASIA','INDIA','CHENNAI','#{rand(50)}','#{@info[0].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())"
                          f="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AS','PK','ASIA','PAKISTAN','LAHORE','#{rand(50)}','#{@info[0].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())"  
                          g="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AS','AF','ASIA','AFGANITAN','KABUL','#{rand(50)}','#{@info[0].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())"  
                          h="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values('AS','CN','ASIA','CHINA','BEIGIN','#{rand(50)}','#{@info[0].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())"  
                          i="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AS','RU','ASIA','RUSSIA','MOSCOW','#{rand(50)}','#{@info[0].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())"  
                          j="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AS','IR','ASIA','IRAN','TEHRAN','#{rand(50)}','#{@info[0].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())"  
                          k="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AS','KZ','ASIA','KAZAKHSTAN','ASTANA','#{rand(50)}','#{@info[0].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())" 
                          l="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values  ('NA','US','NORTH AMERICA','UNITED STATES','TEXAS','#{rand(50)}','#{@info[0].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())" 
                          m="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('NA','MX','NORTH AMERICA','MEXICO','PANAMA','#{rand(50)}','#{@info[0].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())"  
                          n="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('NA','CA','NORTH AMERICA','CANADA','TORONTO','#{rand(50)}','#{@info[0].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())"  
                          o="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values  ('AF','DZ','AFRICA','ALGERIA','ADRAR','#{rand(50)}','#{@info[0].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())" 
                          p="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AF','CM','AFRICA','CAMEROON','SUD','#{rand(50)}','#{@info[0].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())" 
                          q="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AF','ZA','AFRICA','SOUTH AFRICA','CAPE TOWN','#{rand(50)}','#{@info[0].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())" 
                          r="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('SA','AR','SOUTH AMERICA','ARGENTINA','SALTA','#{rand(50)}','#{@info[0].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())" 
                          s="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('SA','BR','SOUTH AMERICA','BRAZIL','PARA','#{rand(50)}','#{@info[0].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())" 
                          t="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('SA','VE','SOUTH AMERICA','VENEZUELA','AMAZONAS','#{rand(50)}','#{@info[0].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())" 
                          u="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('EU','DE','EUROPE','GERMANY','BERLIN','#{rand(50)}','#{@info[0].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())" 
                          v="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('EU','GB','EUROPE','UNITED KINGDOM','LIVERPOOL','#{rand(50)}','#{@info[0].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())" 
                          w="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('EU','ES','EUROPE','SPAIN','REAL MADRID','#{rand(50)}','#{@info[0].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())" 
                          x="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('EU','FR','EUROPE','FRANCE','PARIS','#{rand(50)}','#{@info[0].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())"
                          y="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('EU','TK','EUROPE','TURKEY','ANKARA','#{rand(50)}','#{@info[0].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())"
                          z="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('OC','AU','AUSTRALIA','AUSTRALIA','MELBOURNE','#{rand(50)}','#{@info[0].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())" 
                          z1="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('OC','FJ','AUSTRALIA','FIJI','FIJI','#{rand(50)}','#{@info[0].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())" 
                          z2="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('OC','NZ','AUSTRALIA','NEW ZEALAND','AUCKLAND','#{rand(50)}','#{@info[0].campaign_id}','#{@info[0].ad_id}',hour(curTime()),curDate(),now())" 
                           Campaign.connection.insert(e)
                          Campaign.connection.insert(f)
                          Campaign.connection.insert(g)
                          Campaign.connection.insert(h)
                          Campaign.connection.insert(i)
                          Campaign.connection.insert(j)
                          Campaign.connection.insert(k)
                          Campaign.connection.insert(l)
                          Campaign.connection.insert(m)
                          Campaign.connection.insert(n)
                          Campaign.connection.insert(o)
                          Campaign.connection.insert(p)
                          Campaign.connection.insert(q)
                          Campaign.connection.insert(r)
                          Campaign.connection.insert(s)
                          Campaign.connection.insert(t)
                          Campaign.connection.insert(u)
                          Campaign.connection.insert(v)
                          Campaign.connection.insert(w)
                          Campaign.connection.insert(x)
                          Campaign.connection.insert(y)
                          Campaign.connection.insert(z)
                          Campaign.connection.insert(z1)
                          Campaign.connection.insert(z2)
                          
                          e="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AS','IN','ASIA','INDIA','CHENNAI','#{rand(50)}','#{@info[1].campaign_id}','#{@info[1].ad_id}',hour(curTime()),curDate(),now())"
                          f="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AS','PK','ASIA','PAKISTAN','LAHORE','#{rand(50)}','#{@info[1].campaign_id}','#{@info[1].ad_id}',hour(curTime()),curDate(),now())"  
                          g="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AS','AF','ASIA','AFGANITAN','KABUL','#{rand(50)}','#{@info[1].campaign_id}','#{@info[1].ad_id}',hour(curTime()),curDate(),now())"  
                          h="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AS','CN','ASIA','CHINA','BEIGIN','#{rand(50)}','#{@info[1].campaign_id}','#{@info[1].ad_id}',hour(curTime()),curDate(),now())"  
                          i="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AS','RU','ASIA','RUSSIA','MOSCOW','#{rand(50)}','#{@info[1].campaign_id}','#{@info[1].ad_id}',hour(curTime()),curDate(),now())"  
                          j="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AS','IR','ASIA','IRAN','TEHRAN','#{rand(50)}','#{@info[1].campaign_id}','#{@info[1].ad_id}',hour(curTime()),curDate(),now())"  
                          k="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AS','KZ','ASIA','KAZAKHSTAN','ASTANA','#{rand(50)}','#{@info[1].campaign_id}','#{@info[1].ad_id}',hour(curTime()),curDate(),now())" 
                          l="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('NA','US','NORTH AMERICA','UNITED STATES','TEXAS','#{rand(50)}','#{@info[1].campaign_id}','#{@info[1].ad_id}',hour(curTime()),curDate(),now())" 
                          m=" insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('NA','MX','NORTH AMERICA','MEXICO','PANAMA','#{rand(50)}','#{@info[1].campaign_id}','#{@info[1].ad_id}',hour(curTime()),curDate(),now())"  
                          n="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('NA','CA','NORTH AMERICA','CANADA','TORONTO','#{rand(50)}','#{@info[1].campaign_id}','#{@info[1].ad_id}',hour(curTime()),curDate(),now())"  
                          o="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values  ('AF','DZ','AFRICA','ALGERIA','ADRAR','#{rand(50)}','#{@info[1].campaign_id}','#{@info[1].ad_id}',hour(curTime()),curDate(),now())" 
                          p="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AF','CM','AFRICA','CAMEROON','SUD','#{rand(50)}','#{@info[1].campaign_id}','#{@info[1].ad_id}',hour(curTime()),curDate(),now())" 
                          q="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AF','ZA','AFRICA','SOUTH AFRICA','CAPE TOWN','#{rand(50)}','#{@info[1].campaign_id}','#{@info[1].ad_id}',hour(curTime()),curDate(),now())" 
                          r="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('SA','AR','SOUTH AMERICA','ARGENTINA','SALTA','#{rand(50)}','#{@info[1].campaign_id}','#{@info[1].ad_id}',hour(curTime()),curDate(),now())" 
                          s="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('SA','BR','SOUTH AMERICA','BRAZIL','PARA','#{rand(50)}','#{@info[1].campaign_id}','#{@info[1].ad_id}',hour(curTime()),curDate(),now())" 
                          t="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('SA','VE','SOUTH AMERICA','VENEZUELA','AMAZONAS','#{rand(50)}','#{@info[1].campaign_id}','#{@info[1].ad_id}',hour(curTime()),curDate(),now())" 
                          u=" insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('EU','DE','EUROPE','GERMANY','BERLIN','#{rand(50)}','#{@info[1].campaign_id}','#{@info[1].ad_id}',hour(curTime()),curDate(),now())" 
                          v="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('EU','GB','EUROPE','UNITED KINGDOM','LIVERPOOL','#{rand(50)}','#{@info[1].campaign_id}','#{@info[1].ad_id}',hour(curTime()),curDate(),now())" 
                          w="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('EU','ES','EUROPE','SPAIN','REAL MADRID','#{rand(50)}','#{@info[1].campaign_id}','#{@info[1].ad_id}',hour(curTime()),curDate(),now())" 
                          x="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('EU','FR','EUROPE','FRANCE','PARIS','#{rand(50)}','#{@info[1].campaign_id}','#{@info[1].ad_id}',hour(curTime()),curDate(),now())"
                          y="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('EU','TK','EUROPE','TURKEY','ANKARA','#{rand(50)}','#{@info[1].campaign_id}','#{@info[1].ad_id}',hour(curTime()),curDate(),now())"
                          z="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('OC','AU','AUSTRALIA','AUSTRALIA','MELBOURNE','#{rand(50)}','#{@info[1].campaign_id}','#{@info[1].ad_id}',hour(curTime()),curDate(),now())"
                          z1="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('OC','FJ','AUSTRALIA','FIJI','FIJI','#{rand(50)}','#{@info[1].campaign_id}','#{@info[1].ad_id}',hour(curTime()),curDate(),now())" 
                          z2="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('OC','NZ','AUSTRALIA','NEW ZEALAND','AUCKLAND','#{rand(50)}','#{@info[1].campaign_id}','#{@info[1].ad_id}',hour(curTime()),curDate(),now())" 
                           Campaign.connection.insert(e)
                          Campaign.connection.insert(f)
                          Campaign.connection.insert(g)
                          Campaign.connection.insert(h)
                          Campaign.connection.insert(i)
                          Campaign.connection.insert(j)
                          Campaign.connection.insert(k)
                          Campaign.connection.insert(l)
                          Campaign.connection.insert(m)
                          Campaign.connection.insert(n)
                          Campaign.connection.insert(o)
                          Campaign.connection.insert(p)
                          Campaign.connection.insert(q)
                          Campaign.connection.insert(r)
                          Campaign.connection.insert(s)
                          Campaign.connection.insert(t)
                          Campaign.connection.insert(u)
                          Campaign.connection.insert(v)
                          Campaign.connection.insert(w)
                          Campaign.connection.insert(x)
                          Campaign.connection.insert(y)
                          Campaign.connection.insert(z)
                          Campaign.connection.insert(z1)
                          Campaign.connection.insert(z2)
                          e="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AS','IN','ASIA','INDIA','CHENNAI','#{rand(50)}','#{@info[2].campaign_id}','#{@info[2].ad_id}',hour(curTime()),curDate(),now())"
                          f="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AS','PK','ASIA','PAKISTAN','LAHORE','#{rand(50)}','#{@info[2].campaign_id}','#{@info[2].ad_id}',hour(curTime()),curDate(),now())"  
                          g="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AS','AF','ASIA','AFGANITAN','KABUL','#{rand(50)}','#{@info[2].campaign_id}','#{@info[2].ad_id}',hour(curTime()),curDate(),now())"  
                          h="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values('AS','CN','ASIA','CHINA','BEIGIN','#{rand(50)}','#{@info[2].campaign_id}','#{@info[2].ad_id}',hour(curTime()),curDate(),now())"  
                          i="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AS','RU','ASIA','RUSSIA','MOSCOW','#{rand(50)}','#{@info[2].campaign_id}','#{@info[2].ad_id}',hour(curTime()),curDate(),now())"  
                          j="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AS','IR','ASIA','IRAN','TEHRAN','#{rand(50)}','#{@info[2].campaign_id}','#{@info[2].ad_id}',hour(curTime()),curDate(),now())"  
                          k="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AS','KZ','ASIA','KAZAKHSTAN','ASTANA','#{rand(50)}','#{@info[2].campaign_id}','#{@info[2].ad_id}',hour(curTime()),curDate(),now())" 
                          l="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values  ('NA','US','NORTH AMERICA','UNITED STATES','TEXAS','#{rand(50)}','#{@info[2].campaign_id}','#{@info[2].ad_id}',hour(curTime()),curDate(),now())" 
                          m=" insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('NA','MX','NORTH AMERICA','MEXICO','PANAMA','#{rand(50)}','#{@info[2].campaign_id}','#{@info[2].ad_id}',hour(curTime()),curDate(),now())"  
                          n="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('NA','CA','NORTH AMERICA','CANADA','TORONTO','#{rand(50)}','#{@info[2].campaign_id}','#{@info[2].ad_id}',hour(curTime()),curDate(),now())"  
                          o="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values  ('AF','DZ','AFRICA','ALGERIA','ADRAR','#{rand(50)}','#{@info[2].campaign_id}','#{@info[2].ad_id}',hour(curTime()),curDate(),now())" 
                          p="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AF','CM','AFRICA','CAMEROON','SUD','#{rand(50)}','#{@info[2].campaign_id}','#{@info[2].ad_id}',hour(curTime()),curDate(),now())" 
                          q="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AF','ZA','AFRICA','SOUTH AFRICA','CAPE TOWN','#{rand(50)}','#{@info[2].campaign_id}','#{@info[2].ad_id}',hour(curTime()),curDate(),now())" 
                          r="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('SA','AR','SOUTH AMERICA','ARGENTINA','SALTA','#{rand(50)}','#{@info[2].campaign_id}','#{@info[2].ad_id}',hour(curTime()),curDate(),now())" 
                          s="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('SA','BR','SOUTH AMERICA','BRAZIL','PARA','#{rand(50)}','#{@info[2].campaign_id}','#{@info[2].ad_id}',hour(curTime()),curDate(),now())" 
                          t="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('SA','VE','SOUTH AMERICA','VENEZUELA','AMAZONAS','#{rand(50)}','#{@info[2].campaign_id}','#{@info[2].ad_id}',hour(curTime()),curDate(),now())" 
                          u=" insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('EU','DE','EUROPE','GERMANY','BERLIN','#{rand(50)}','#{@info[2].campaign_id}','#{@info[2].ad_id}',hour(curTime()),curDate(),now())" 
                          v="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('EU','GB','EUROPE','UNITED KINGDOM','LIVERPOOL','#{rand(50)}','#{@info[2].campaign_id}','#{@info[2].ad_id}',hour(curTime()),curDate(),now())" 
                          w="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('EU','ES','EUROPE','SPAIN','REAL MADRID','#{rand(50)}','#{@info[2].campaign_id}','#{@info[2].ad_id}',hour(curTime()),curDate(),now())" 
                          x="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('EU','FR','EUROPE','FRANCE','PARIS','#{rand(50)}','#{@info[2].campaign_id}','#{@info[2].ad_id}',hour(curTime()),curDate(),now())"
                          y="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('EU','TK','EUROPE','TURKEY','ANKARA','#{rand(50)}','#{@info[2].campaign_id}','#{@info[2].ad_id}',hour(curTime()),curDate(),now())"
                          z="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('OC','AU','AUSTRALIA','AUSTRALIA','MELBOURNE','#{rand(50)}','#{@info[2].campaign_id}','#{@info[2].ad_id}',hour(curTime()),curDate(),now())"
                          z1="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('OC','FJ','AUSTRALIA','FIJI','FIJI','#{rand(50)}','#{@info[2].campaign_id}','#{@info[2].ad_id}',hour(curTime()),curDate(),now())" 
                          z2="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('OC','NZ','AUSTRALIA','NEW ZEALAND','AUCKLAND','#{rand(50)}','#{@info[2].campaign_id}','#{@info[2].ad_id}',hour(curTime()),curDate(),now())" 
                          
                           Campaign.connection.insert(e)
                          Campaign.connection.insert(f)
                          Campaign.connection.insert(g)
                          Campaign.connection.insert(h)
                          Campaign.connection.insert(i)
                          Campaign.connection.insert(j)
                          Campaign.connection.insert(k)
                          Campaign.connection.insert(l)
                          Campaign.connection.insert(m)
                          Campaign.connection.insert(n)
                          Campaign.connection.insert(o)
                          Campaign.connection.insert(p)
                          Campaign.connection.insert(q)
                          Campaign.connection.insert(r)
                          Campaign.connection.insert(s)
                          Campaign.connection.insert(t)
                          Campaign.connection.insert(u)
                          Campaign.connection.insert(v)
                          Campaign.connection.insert(w)
                          Campaign.connection.insert(x)
                          Campaign.connection.insert(y)
                          Campaign.connection.insert(z)
                          Campaign.connection.insert(z1)
                          Campaign.connection.insert(z2)
                          e="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AS','IN','ASIA','INDIA','CHENNAI','#{rand(50)}','#{@info[3].campaign_id}','#{@info[3].ad_id}',hour(curTime()),curDate(),now())"
                          f="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AS','PK','ASIA','PAKISTAN','LAHORE','#{rand(50)}','#{@info[3].campaign_id}','#{@info[3].ad_id}',hour(curTime()),curDate(),now())"  
                          g="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AS','AF','ASIA','AFGANITAN','KABUL','#{rand(50)}','#{@info[3].campaign_id}','#{@info[3].ad_id}',hour(curTime()),curDate(),now())"  
                          h="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values('AS','CN','ASIA','CHINA','BEIGIN','#{rand(50)}','#{@info[3].campaign_id}','#{@info[3].ad_id}',hour(curTime()),curDate(),now())"  
                          i="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AS','RU','ASIA','RUSSIA','MOSCOW','#{rand(50)}','#{@info[3].campaign_id}','#{@info[3].ad_id}',hour(curTime()),curDate(),now())"  
                          j="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AS','IR','ASIA','IRAN','TEHRAN','#{rand(50)}','#{@info[3].campaign_id}','#{@info[3].ad_id}',hour(curTime()),curDate(),now())"  
                          k="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AS','KZ','ASIA','KAZAKHSTAN','ASTANA','#{rand(50)}','#{@info[3].campaign_id}','#{@info[3].ad_id}',hour(curTime()),curDate(),now())" 
                          l="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values  ('NA','US','NORTH AMERICA','UNITED STATES','TEXAS','#{rand(50)}','#{@info[3].campaign_id}','#{@info[3].ad_id}',hour(curTime()),curDate(),now())" 
                          m=" insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('NA','MX','NORTH AMERICA','MEXICO','PANAMA','#{rand(50)}','#{@info[3].campaign_id}','#{@info[3].ad_id}',hour(curTime()),curDate(),now())"  
                          n="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('NA','CA','NORTH AMERICA','CANADA','TORONTO','#{rand(50)}','#{@info[3].campaign_id}','#{@info[3].ad_id}',hour(curTime()),curDate(),now())"  
                          o="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values  ('AF','DZ','AFRICA','ALGERIA','ADRAR','#{rand(50)}','#{@info[3].campaign_id}','#{@info[3].ad_id}',hour(curTime()),curDate(),now())" 
                          p="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AF','CM','AFRICA','CAMEROON','SUD','#{rand(50)}','#{@info[3].campaign_id}','#{@info[3].ad_id}',hour(curTime()),curDate(),now())" 
                          q="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('AF','ZA','AFRICA','SOUTH AFRICA','CAPE TOWN','#{rand(50)}','#{@info[3].campaign_id}','#{@info[3].ad_id}',hour(curTime()),curDate(),now())" 
                          r="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('SA','AR','SOUTH AMERICA','ARGENTINA','SALTA','#{rand(50)}','#{@info[3].campaign_id}','#{@info[3].ad_id}',hour(curTime()),curDate(),now())" 
                          s="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('SA','BR','SOUTH AMERICA','BRAZIL','PARA','#{rand(50)}','#{@info[3].campaign_id}','#{@info[3].ad_id}',hour(curTime()),curDate(),now())" 
                          t="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('SA','VE','SOUTH AMERICA','VENEZUELA','AMAZONAS','#{rand(50)}','#{@info[3].campaign_id}','#{@info[3].ad_id}',hour(curTime()),curDate(),now())" 
                          u=" insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('EU','DE','EUROPE','GERMANY','BERLIN','#{rand(50)}','#{@info[3].campaign_id}','#{@info[3].ad_id}',hour(curTime()),curDate(),now())" 
                          v="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('EU','GB','EUROPE','UNITED KINGDOM','LIVERPOOL','#{rand(50)}','#{@info[3].campaign_id}','#{@info[3].ad_id}',hour(curTime()),curDate(),now())" 
                          w="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('EU','ES','EUROPE','SPAIN','REAL MADRID','#{rand(50)}','#{@info[3].campaign_id}','#{@info[3].ad_id}',hour(curTime()),curDate(),now())" 
                          x="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('EU','FR','EUROPE','FRANCE','PARIS','#{rand(50)}','#{@info[3].campaign_id}','#{@info[3].ad_id}',hour(curTime()),curDate(),now())"
                          y="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('EU','TK','EUROPE','TURKEY','ANKARA','#{rand(50)}','#{@info[3].campaign_id}','#{@info[3].ad_id}',hour(curTime()),curDate(),now())"
                          z="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('OC','AU','AUSTRALIA','AUSTRALIA','MELBOURNE','#{rand(50)}','#{@info[3].campaign_id}','#{@info[3].ad_id}',hour(curTime()),curDate(),now())"
                          z1="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('OC','FJ','AUSTRALIA','FIJI','FIJI','#{rand(50)}','#{@info[3].campaign_id}','#{@info[3].ad_id}',hour(curTime()),curDate(),now())" 
                          z2="insert into adv_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,campaign_id,ad_id,delivery_hour,delivery_date,last_updated) values ('OC','NZ','AUSTRALIA','NEW ZEALAND','AUCKLAND','#{rand(50)}','#{@info[3].campaign_id}','#{@info[3].ad_id}',hour(curTime()),curDate(),now())" 
                          Campaign.connection.insert(e)
                          Campaign.connection.insert(f)
                          Campaign.connection.insert(g)
                          Campaign.connection.insert(h)
                          Campaign.connection.insert(i)
                          Campaign.connection.insert(j)
                          Campaign.connection.insert(k)
                          Campaign.connection.insert(l)
                          Campaign.connection.insert(m)
                          Campaign.connection.insert(n)
                          Campaign.connection.insert(o)
                          Campaign.connection.insert(p)
                          Campaign.connection.insert(q)
                          Campaign.connection.insert(r)
                          Campaign.connection.insert(s)
                          Campaign.connection.insert(t)
                          Campaign.connection.insert(u)
                          Campaign.connection.insert(v)
                          Campaign.connection.insert(w)
                          Campaign.connection.insert(x)
                          Campaign.connection.insert(y)
                          Campaign.connection.insert(z)
                          Campaign.connection.insert(z1)
                          Campaign.connection.insert(z2)
                      rescue Exception => e
                         puts "ERROR :: select :"+e.to_s
                      end
                      sleep(3600)
      end while(true)
             
end
end

  obj = AdvDemo.new
  DRb.start_service('druby://localhost:8982', obj)


