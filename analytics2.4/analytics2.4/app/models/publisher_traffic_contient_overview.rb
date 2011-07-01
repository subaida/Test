class PublisherTrafficContientOverview < ActiveRecord::Base
def self.show_data(id,type)
        if (type == "notreport")
              find_by_sql("select impression,continent_code from publisher_traffic_contient_overviews limit 5")
        elsif (type=="report")
              find_by_sql("select impression,continent_code from publisher_traffic_contient_overviews ")
        end
    end
end
