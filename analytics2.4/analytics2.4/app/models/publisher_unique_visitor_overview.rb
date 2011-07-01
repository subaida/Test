class PublisherUniqueVisitorOverview < ActiveRecord::Base
def self.show_data(id,type)
        if (type == "notreport")
              find_by_sql("select delivery_date, requests from publisher_unique_visitor_overviews limit 5")
        elsif (type=="report")
              find_by_sql("select delivery_date, requests from publisher_unique_visitor_overviews ")
        end
    end
end
