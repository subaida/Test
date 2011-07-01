class PublisherTrafficCarrierOverview < ActiveRecord::Base
    def self.show_data(id,type)
        if (type == "notreport")
              find_by_sql("select carrier,traffic from publisher_traffic_carrier_overviews where publisher_id='#{id}' limit 5")
        elsif (type=="report")
              find_by_sql("select carrier,traffic from publisher_traffic_carrier_overviews where publisher_id='#{id}' ")
        end
    end
end
