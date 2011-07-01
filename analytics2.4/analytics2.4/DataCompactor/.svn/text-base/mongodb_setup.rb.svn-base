require 'rubygems'
require 'mongo'
require 'nkf'
include Mongo
class MongodbSetup
  def initialize
      @db   = Mongo::Connection.new("192.168.1.21", 27017).db("zestadz_analytics_db")
  end
  def setup
        #create fraud_clicks collection and setup the index
        coll = @db.collection('fraud_clicks')
        coll.create_index([['delivery_time', Mongo::ASCENDING],['pub_id', Mongo::ASCENDING],['campaign_id', Mongo::ASCENDING]])
        
        #create unfilled_ips collection and setup the index
        #~ coll = @db.collection('unfilled_ips')
        #~ coll.create_index([['delivery_time', Mongo::ASCENDING],['pub_id', Mongo::ASCENDING],['country_name', Mongo::ASCENDING]])
        
        #create why_no_ads collection and setup the index
        coll = @db.collection('why_no_ads')
        coll.create_index([['delivery_time', Mongo::ASCENDING],['pub_id', Mongo::ASCENDING],['country_name', Mongo::ASCENDING]])
        
        #create owner_summaries collection and setup the index
        coll = @db.collection('owner_summaries')
        coll.create_index([['delivery_time', Mongo::ASCENDING],['country_name', Mongo::ASCENDING]])
        
        #create wifi_summaries collection and setup the index
        coll = @db.collection('wifi_summaries')
        coll.create_index([['delivery_time', Mongo::ASCENDING],['pub_id', Mongo::ASCENDING],['campaign_name', Mongo::ASCENDING]])
        
        #create campaigns data breakdown collection and setup the index
        coll = @db.collection('campaigns_breakdown')
        coll.create_index([['dt', Mongo::ASCENDING],['aid', Mongo::ASCENDING],['pid', Mongo::ASCENDING]])
        
        #create click logs collection and setup the index
        coll = @db.collection('click_logs')
        coll.create_index([['dt', Mongo::ASCENDING],['aid', Mongo::ASCENDING],['cid', Mongo::ASCENDING]])
        
        #create us_geostats collection and setup the index
        coll = @db.collection('us_geostats')
        coll.create_index([['dt', Mongo::ASCENDING],['aid', Mongo::ASCENDING],['st', Mongo::ASCENDING],['ct', Mongo::ASCENDING]])
        
        #create us_geostats collection for advertiser and setup the index
        coll = @db.collection('pub_us_geostats')
        coll.create_index([['dt', Mongo::ASCENDING],['pid', Mongo::ASCENDING],['st', Mongo::ASCENDING],['ct', Mongo::ASCENDING]])
  end
end

MongodbSetup.new.setup

