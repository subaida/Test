class PublisherHandsetOverview < ActiveRecord::Base
    def self.show_data(id,type)
        if (type == "notreport")
              find_by_sql("select device,requests,traffic from publisher_handset_overviews where publisher_id='#{id}' and date='2011-06-05' group by device order by requests desc limit 5")
        elsif (type=="report")
              find_by_sql("select device,requests,traffic from publisher_handset_overviews where publisher_id='#{id}' and date='2011-06-05' group by device order by requests desc ")
        end
    end
end
