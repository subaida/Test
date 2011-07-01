require 'dbi'
require 'drb'

require 'rubygems'
require 'active_record'
require 'AnalyticsDBConnection'
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
class PubDemo

def initialize
  insert_pub_demo_record
end

def insert_pub_demo_record
      @owner=Array.new
      @url=Array.new
      @channel=Array.new
      @manufacture=Array.new
      k=0
      @impHash=Hash.new
      @clickHash=Hash.new
      @impHash={:a=>'2000',:b=>'2500',:c=>'3000',:d=>'3500',:e=>'4000',:f=>'4500',:g=>'5000',:h=>'5500',:i=>'6000',:j=>'1000',:k=>'1100',:l=>'1200',:m=>'1300',:n=>'1400',:o=>'1500',:p=>'1600',:q=>'1700',:r=>'1800',:s=>'1900'}
      @clickHash={'2000'=>'54','2500'=>'57','3000'=>'58','3500'=>'60','4000'=>'61','4500'=>'63','5000'=>'64','5500'=>'66','6000'=>'69','1000'=>'9','1100'=>'10','1200'=>'11','1300'=>'12','1400'=>'16','1500'=>'14','1600'=>'50','1700'=>'18','1800'=>'17','1900'=>'25'}
      @unique_user={'2000'=>'1750','2500'=>'1785','3000'=>'2556','3500'=>'380','4000'=>'425','4500'=>'550','5000'=>'660','5500'=>'740','6000'=>'5100','1000'=>'930','1100'=>'1020','1200'=>'800','1300'=>'1250','1400'=>'900','1500'=>'1410','1600'=>'1490','1700'=>'1560','1800'=>'1523','1900'=>'1753'}
      @cost=0.40
      def setValues
            @publisher_percentage=0.5
            @getImp = @impHash.values
            imp=@getImp[rand(@getImp.size)]
            click=@clickHash["#{imp}"]
            uniqueUser=@unique_user["#{imp}"]
            @@revenue=@cost*click.to_i*@publisher_percentage
            @@imp=imp.to_i
            @@click=click.to_i
            @@uniqueUser=uniqueUser.to_i
      end
      @owner=["BHARTI TELEVENTURES LTD - ABTS","BHARTI TELESONIC","BHARTI TELETECH LIMITED","TATA TELESERVICES LTD","GMT BSNL DHULE","BSNL CGMM TELECOM FACTORY DEONAR MUMBAI" , "IDEA CELULAR","IONIDEA INTERACTIVE PVT LTD","BSNL DATA NETWORK BANGALORE","CELLONE BSNL", "HUTCHISON ESSAR","HUTCHISON ESSAR TELECOM LIMITED","RELIANCE-INFOCOM","RELIANCE COMMUNICATIONS LTD","3G","BHARTI AIRTEL LTD"]
      @keyword=["Food","Cricket","IPL","Hollywood","Health","Fresher","Sports","Football"]
      @channel=["Student","Professional","Doctor","NGO","College","Tourism"]
      @url=["http://zestadz.com/ad/video/","http://mklix.com/wallpaper/download/","http://zibika.com/stock/nasdaq/","http://geehub.com/health/ad/","http://bolohealth.com/ad/calories/","http://alabot.com/video/six/ad/","http://yahoo.com/mobile/iphone/","http://rediff.com/poll/ad/","http://facebook.com/content/phone/ad","http://zapak.com/mobile/games/ad"]
      @manufacture=["Nokia","Sony Ericsson","Motorola","Samsumg","LG","Apple","O2","Blackberry","Orange","Philips","Panasonic","Benq"]
      @user_agent=["MOT-V3r/0E.C0.15R MIB/2.2.1 Profile/MIDP-2.0 Configuration/CLDC-1.1","SAMSUNG-SGH-T319/T319UVFD4 Profile/MIDP-2.0 Configuration/CLDC-1.1 UP.Browser/6.2.3.3.c.1.101 (GUI) ","SAMSUNG-SGH-T729/T729UVGF9 Profile/MIDP-2.0 Configuration/CLDC-1.1 UP.Browser/6.2.3.3.c.1.101 (GUI) ","SAMSUNG-SGH-T729/T729UVGF9 Profile/MIDP-2.0 Configuration/CLDC-1.1 UP.Browser/6.2.3.3.c.1.101 (GUI) ","MOT-Z3/08.05.0BR MIB/BER2.2 Profile/MIDP-2.0 Configuration/CLDC-1.1 EGE/1.0","Mozilla/4.0 (compatible; MSIE 6.0; Windows CE; IEMobile 7.7) Sprint:MotoQ9c","SAMSUNG-SGH-T729/T729UVGF9 Profile/MIDP-2.0 Configuration/CLDC-1.1 UP.Browser/6.2.3.3.c.1.101 (GUI) ","Mozilla/5.0 (SymbianOS/9.2; U; Series60/3.1 NokiaE51-1/100.34.20; Profile/MIDP-2.0 Configuration/CLD","Nokia6301/2.0 (05.93) Profile/MIDP-2.1 Configuration/CLDC-1.1","SAMSUNG-SGH-T729/T729UVGF9 Profile/MIDP-2.0 Configuration/CLDC-1.1 UP.Browser/6.2.3.3.c.1.101 (GUI) ","SAMSUNG-SGH-T729/T729UVGF9 Profile/MIDP-2.0 Configuration/CLDC-1.1 UP.Browser/6.2.3.3.c.1.101 (GUI) ","Mozilla/4.0 (compatible; MSIE 6.0; Windows CE; IEMobile 6.12) T-Mobile Dash","MOT-V3r/0E.C0.15R MIB/2.2.1 Profile/MIDP-2.0 Configuration/CLDC-1.1","MOT-V3r/0E.C0.15R MIB/2.2.1 Profile/MIDP-2.0 Configuration/CLDC-1.1","Mozilla/4.0 (compatible; MSIE 6.0; Windows CE; IEMobile 7.7) Sprint:MotoQ9c","SAMSUNG-SGH-T329/T329UVGK1 Profile/MIDP-2.0 Configuration/CLDC-1.1 UP.Browser/6.2.3.3.c.1.101 (GUI) ","SonyEricssonS500i/R8BE Browser/NetFront/3.3 Profile/MIDP-2.0 Configuration/CLDC-1.1","SAMSUNG-SGH-T729/T729UVGF9 Profile/MIDP-2.0 Configuration/CLDC-1.1 UP.Browser/6.2.3.3.c.1.101 (GUI) "]
                  begin
                      begin
                            k=0
                            adsid=Array.new
                            campaignid=Array.new
                            adclientsid=Array.new
                            advertiserid=Array.new
                            puts t = Time.now.strftime("%Y-%m-%d %H:%M:%S")
                            @info=Campaign.find_by_sql("select adc.publisher_id publisher_id,adc.id client_id,adc.app_name client_name,p.publisher_name publisher_name from adclients adc,publishers p where p.id=adc.publisher_id and adc.id in (1346,1347)")
                            
                           # adclients_summaries data
                           setValues
                           a="insert into adclients_summaries (ad_client_type,ad_type,impressions,clicks,requests_unique_visitors,ctr,ecpm,revenue,pub_name,adclient_name,pub_id,client_id,country_name,delivery_hour,delivery_date,last_updated) values  ('WAP','Text','#{@@imp}','#{@@click}','#{@@uniqueUser}','#{(@@click/@@imp)*100}','#{(@@revenue/@@imp)*1000}','#{@@revenue}','#{@info[0].publisher_name}','#{@info[0].client_name}','#{@info[0].publisher_id}','#{@info[0].client_id}','',hour(curTime()),curDate(),now())"
                           setValues
                           b="insert into adclients_summaries (ad_client_type,ad_type,impressions,clicks,requests_unique_visitors,ctr,ecpm,revenue,pub_name,adclient_name,pub_id,client_id,country_name,delivery_hour,delivery_date,last_updated) values  ('SMS','Text','#{@@imp}','#{0}','#{@@uniqueUser}','#{0}','#{0}','#{@@imp*0.01*0.2}','#{@info[1].publisher_name}','#{@info[1].client_name}','#{@info[1].publisher_id}','#{@info[1].client_id}','',hour(curTime()),curDate(),now())"
                          Campaign.connection.insert(a)
                          Campaign.connection.insert(b)
                           
                           # pub_channels data
                           a="insert into pub_channels (channel, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('#{@channel[rand(5)]}','#{rand(10)}','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())"
                           b="insert into pub_channels (channel, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('#{@channel[rand(5)]}','#{rand(10)}','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())"
                          
                          Campaign.connection.insert(a)
                          Campaign.connection.insert(b)
                           
                            #pub_handsets
                          a="insert into pub_handsets (vendor, requests,pub_id,client_id,delivery_hour,delivery_date,last_updated) values ('#{@manufacture[rand(11)]}','#{rand(10)}','#{@info[0].publisher_id}','#{@info[0].client_id}',hour(curTime()),curDate(),now())"
                          b="insert into pub_handsets (vendor, requests,pub_id,client_id,delivery_hour,delivery_date,last_updated) values ('#{@manufacture[rand(11)]}','#{rand(10)}','#{@info[0].publisher_id}','#{@info[0].client_id}',hour(curTime()),curDate(),now())"
                          Campaign.connection.insert(a)
                          Campaign.connection.insert(b)
                          
                          # pub_keywords data
                           #~ a="insert into pub_keywords (keywords, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('#{@keyword[rand(6)]}','#{rand(10)}','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())"
                           #~ b="insert into pub_keywords (keywords, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('#{@keyword[rand(6)]}','#{rand(10)}','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())"
                          
                          #~ Campaign.connection.insert(a)
                          #~ Campaign.connection.insert(b)
                          #~ #pub_handsets
                         
                           
                        #adv_handsets
                           a="insert into pub_urls (url, requests,pub_id,client_id,delivery_hour,delivery_date,last_updated) values ('#{@url[rand(9)]}','#{rand(10)}','#{@info[0].publisher_id}','#{@info[0].client_id}',hour(curTime()),curDate(),now())"
                           b="insert into pub_urls (url, requests,pub_id,client_id,delivery_hour,delivery_date,last_updated) values ('#{@url[rand(9)]}','#{rand(10)}','#{@info[0].publisher_id}','#{@info[0].client_id}',hour(curTime()),curDate(),now())"
                          Campaign.connection.insert(a)
                          Campaign.connection.insert(b)
                                
                                
                          #pub_unique_visitors     
                          e="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.168.0.15','#{rand(50)}','IN','INDIA','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())"
                          f="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.168.1.39','#{rand(50)}','PK','PAKISTAN','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())"  
                          g="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.168.3.6','#{rand(50)}','AF','AFGANITAN','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())"  
                          h="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.168.2.9','#{rand(50)}','CN','CHINA','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())"  
                          i="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.168.3.7','#{rand(50)}','RU','RUSSIA','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())"  
                          j="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('184.133.6.9','#{rand(50)}','IR','IRAN','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())"  
                          k="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('187.168.58.6','#{rand(50)}','KZ','KAZAKHSTAN','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())" 
                          l="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('185.169.3.98','#{rand(50)}','US','UNITED STATES','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())" 
                          m="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('154.235.24.32','#{rand(50)}','MX','MEXICO','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())"  
                          n="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('195.153.65.2','#{rand(50)}','CA','CANADA','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())"  
                          o="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('122.112.23.45','#{rand(50)}','DZ','ALGERIA','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())" 
                          p="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.145.4.9','#{rand(50)}','CM','CAMEROON','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())" 
                          q="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.168.0.15','#{rand(50)}','ZA','SOUTH AFRICA','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())" 
                          r="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.168.1.55','#{rand(50)}','AR','ARGENTINA','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())" 
                          s="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.135.36.2','#{rand(50)}','BR','BRAZIL','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())" 
                          t="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.167.2.8','#{rand(50)}','VE','VENEZUELA','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())" 
                          u=" insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.168.0.15','#{rand(50)}','DE','GERMANY','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())" 
                          v="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.158.12.5','#{rand(50)}','GB','UNITED KINGDOM','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())" 
                          w="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.65.55.2','#{rand(50)}','ES','SPAIN','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())" 
                          x="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.168.5.9','#{rand(50)}','FR','FRANCE','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())"
                          y="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.168.77.5','#{rand(50)}','TK','TURKEY','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())"
                          z="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.168.25.5','#{rand(50)}','AU','AUSTRALIA','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())" 
                          z1="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('175.25.36.2','#{rand(50)}','FJ','FIJI','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())" 
                          z2="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.168.5.9','#{rand(50)}','NZ','NEW ZEALAND','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())" 
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
                          
                          
                         #pub_unique_visitors     
                          e="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.168.0.15','#{rand(50)}','IN','INDIA','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())"
                          f="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.168.1.39','#{rand(50)}','PK','PAKISTAN','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())"  
                          g="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.168.3.6','#{rand(50)}','AF','AFGANITAN','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())"  
                          h="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.168.2.9','#{rand(50)}','CN','CHINA','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())"  
                          i="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.168.3.7','#{rand(50)}','RU','RUSSIA','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())"  
                          j="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('184.133.6.9','#{rand(50)}','IR','IRAN','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())"  
                          k="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('187.168.58.6','#{rand(50)}','KZ','KAZAKHSTAN','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())" 
                          l="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('185.169.3.98','#{rand(50)}','US','UNITED STATES','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())" 
                          m="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('154.235.24.32','#{rand(50)}','MX','MEXICO','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())"  
                          n="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('195.153.65.2','#{rand(50)}','CA','CANADA','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())"  
                          o="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('122.112.23.45','#{rand(50)}','DZ','ALGERIA','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())" 
                          p="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.145.4.9','#{rand(50)}','CM','CAMEROON','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())" 
                          q="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.168.0.15','#{rand(50)}','ZA','SOUTH AFRICA','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())" 
                          r="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.168.1.55','#{rand(50)}','AR','ARGENTINA','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())" 
                          s="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.135.36.2','#{rand(50)}','BR','BRAZIL','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())" 
                          t="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.167.2.8','#{rand(50)}','VE','VENEZUELA','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())" 
                          u=" insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.168.0.15','#{rand(50)}','DE','GERMANY','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())" 
                          v="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.158.12.5','#{rand(50)}','GB','UNITED KINGDOM','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())" 
                          w="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.65.55.2','#{rand(50)}','ES','SPAIN','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())" 
                          x="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.168.5.9','#{rand(50)}','FR','FRANCE','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())"
                          y="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.168.77.5','#{rand(50)}','TK','TURKEY','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())"
                          z="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.168.25.5','#{rand(50)}','AU','AUSTRALIA','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())" 
                          z1="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('175.25.36.2','#{rand(50)}','FJ','FIJI','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())" 
                          z2="insert into pub_unique_visitors (ipaddress,requests,country_code,country_name,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('192.168.5.9','#{rand(50)}','NZ','NEW ZEALAND','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())" 
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
                          
                          
                          e="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('AS','IN','ASIA','INDIA','CHENNAI','#{rand(100)}','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())"
                          f="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('AS','PK','ASIA','PAKISTAN','LAHORE','#{rand(100)}','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())"  
                          g="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('AS','AF','ASIA','AFGANITAN','KABUL','#{rand(100)}','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())"  
                          h="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values('AS','CN','ASIA','CHINA','BEIGIN','#{rand(100)}','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())"  
                          i="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('AS','RU','ASIA','RUSSIA','MOSCOW','#{rand(100)}','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())"  
                          j="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('AS','IR','ASIA','IRAN','TEHRAN','#{rand(100)}','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())"  
                          k="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('AS','KZ','ASIA','KAZAKHSTAN','ASTANA','#{rand(100)}','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())" 
                          l="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values  ('NA','US','NORTH AMERICA','UNITED STATES','TEXAS','#{rand(100)}','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())" 
                          m="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('NA','MX','NORTH AMERICA','MEXICO','PANAMA','#{rand(100)}','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())"  
                          n="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('NA','CA','NORTH AMERICA','CANADA','TORONTO','#{rand(100)}','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())"  
                          o="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values  ('AF','DZ','AFRICA','ALGERIA','ADRAR','#{rand(100)}','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())" 
                          p="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('AF','CM','AFRICA','CAMEROON','SUD','#{rand(100)}','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())" 
                          q="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('AF','ZA','AFRICA','SOUTH AFRICA','CAPE TOWN','#{rand(100)}','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())" 
                          r="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('SA','AR','SOUTH AMERICA','ARGENTINA','SALTA','#{rand(100)}','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())" 
                          s="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('SA','BR','SOUTH AMERICA','BRAZIL','PARA','#{rand(100)}','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())" 
                          t="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('SA','VE','SOUTH AMERICA','VENEZUELA','AMAZONAS','#{rand(100)}','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())" 
                          u=" insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('EU','DE','EUROPE','GERMANY','BERLIN','#{rand(100)}','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())" 
                          v="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('EU','GB','EUROPE','UNITED KINGDOM','LIVERPOOL','#{rand(100)}','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())" 
                          w="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('EU','ES','EUROPE','SPAIN','REAL MADRID','#{rand(100)}','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())" 
                          x="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('EU','FR','EUROPE','FRANCE','PARIS','#{rand(100)}','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())"
                          y="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('EU','TK','EUROPE','TURKEY','ANKARA','#{rand(100)}','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())"
                          z="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('OC','AU','AUSTRALIA','AUSTRALIA','MELBOURNE','#{rand(100)}','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())" 
                          z1="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('OC','FJ','AUSTRALIA','FIJI','FIJI','#{rand(100)}','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())" 
                          z2="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('OC','NZ','AUSTRALIA','NEW ZEALAND','AUCKLAND','#{rand(100)}','#{@info[0].publisher_id}','#{@info[0].client_id}','WAP',hour(curTime()),curDate(),now())" 
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
                          
                          e="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('AS','IN','ASIA','INDIA','CHENNAI','#{rand(100)}','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())"
                          f="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('AS','PK','ASIA','PAKISTAN','LAHORE','#{rand(100)}','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())"  
                          g="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('AS','AF','ASIA','AFGANITAN','KABUL','#{rand(100)}','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())"  
                          h="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values('AS','CN','ASIA','CHINA','BEIGIN','#{rand(100)}','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())"  
                          i="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('AS','RU','ASIA','RUSSIA','MOSCOW','#{rand(100)}','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())"  
                          j="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('AS','IR','ASIA','IRAN','TEHRAN','#{rand(100)}','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())"  
                          k="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('AS','KZ','ASIA','KAZAKHSTAN','ASTANA','#{rand(100)}','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())" 
                          l="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values  ('NA','US','NORTH AMERICA','UNITED STATES','TEXAS','#{rand(100)}','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())" 
                          m="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('NA','MX','NORTH AMERICA','MEXICO','PANAMA','#{rand(100)}','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())"  
                          n="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('NA','CA','NORTH AMERICA','CANADA','TORONTO','#{rand(100)}','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())"  
                          o="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values  ('AF','DZ','AFRICA','ALGERIA','ADRAR','#{rand(100)}','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())" 
                          p="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('AF','CM','AFRICA','CAMEROON','SUD','#{rand(100)}','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())" 
                          q="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('AF','ZA','AFRICA','SOUTH AFRICA','CAPE TOWN','#{rand(100)}','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())" 
                          r="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('SA','AR','SOUTH AMERICA','ARGENTINA','SALTA','#{rand(100)}','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())" 
                          s="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('SA','BR','SOUTH AMERICA','BRAZIL','PARA','#{rand(100)}','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())" 
                          t="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('SA','VE','SOUTH AMERICA','VENEZUELA','AMAZONAS','#{rand(100)}','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())" 
                          u=" insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('EU','DE','EUROPE','GERMANY','BERLIN','#{rand(100)}','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())" 
                          v="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('EU','GB','EUROPE','UNITED KINGDOM','LIVERPOOL','#{rand(100)}','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())" 
                          w="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('EU','ES','EUROPE','SPAIN','REAL MADRID','#{rand(100)}','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())" 
                          x="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('EU','FR','EUROPE','FRANCE','PARIS','#{rand(100)}','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())"
                          y="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('EU','TK','EUROPE','TURKEY','ANKARA','#{rand(100)}','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())"
                          z="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('OC','AU','AUSTRALIA','AUSTRALIA','MELBOURNE','#{rand(100)}','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())" 
                          z1="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('OC','FJ','AUSTRALIA','FIJI','FIJI','#{rand(100)}','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())" 
                          z2="insert into pub_geolocations (continent_code,country_code,continent_name,country_name,region_name, requests,pub_id,client_id,ad_client_type,delivery_hour,delivery_date,last_updated) values ('OC','NZ','AUSTRALIA','NEW ZEALAND','AUCKLAND','#{rand(100)}','#{@info[1].publisher_id}','#{@info[1].client_id}','SMS',hour(curTime()),curDate(),now())" 
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
                          puts"data inserted"
                      rescue Exception => e
                         puts "ERROR :: select :"+e.to_s
                      end
                      sleep(3600)
              end while(true)
             
end
end

  obj = PubDemo.new
  DRb.start_service('druby://localhost:8982', obj)


