require 'dbi'
module DBCONN
    #~ USERNAME="pshussain"
    #~ PASSWORD="Fsck_Accent@pshussain"
    #~ HOST="69.36.39.75"
    #~ DATABASE="ads"
    USERNAME="root"
    PASSWORD="mysql"
    HOST="192.168.0.15"
    DATABASE="zestadz_analytics"
    CONN_URL="DBI:MYSQL:"+DATABASE+":"+HOST
  end
  #~ class Campaign < ActiveRecord::Base
#~ end
class AnalyticsAdminEngine
    include DBCONN
      def initialize
              begin
               @campaign_name=Hash.new
              rescue Exception => e
                 puts "An error occurred in initialize method :: #{e}"
              end
        end
        def set_campaign_detail 
          begin
                db_conn = DBI.connect(CONN_URL,USERNAME,PASSWORD)
                #~ campaigns=Array.new
                campaigns=db_conn.execute("select id,campaign_name from campaigns")
               campaign_name=Hash.new
                for campaign in campaigns
                   campaign_name.store(campaign['id'],campaign['campaign_name'])
                   #~ p campaign_name.store(campaign.id,campaign.campaign_name)
                end
                return @campaign_name=campaign_name
                  #~ return @campaign_name[id]
               
               
            rescue Exception => e
                puts "An error occurred while fetching in set_campaign_detail  :: #{e}"
            end
        end      
        def campaign_names
           @campaign_name
        end   
end
  
  #~ obj=AnalyticsAdminEngine.new
  #~ c=obj.set_campaign_detail()
 #~ a=obj.campaign_names()
#~ p a.class
 #~ p a["39".to_i]






