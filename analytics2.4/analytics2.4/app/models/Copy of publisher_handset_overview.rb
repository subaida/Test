#require 'application.rb'
require 'test_lib.rb'


class PublisherHandsetOverview < ActiveRecord::Base
 def self.handset_data(id)
    find_by_sql("select device,requests,traffic from publisher_handset_overviews where publisher_id='#{id}' and date='2011-06-05' group by device order by requests desc ")
	end
  
  def self.test 
      begin
      puts "trest model1"
      check
      puts "chk completed"
          paginate_by_sql1()
      puts "trest model1 ends"
      rescue Exception=>e
          puts "test"+e.to_s
        end
        
      end
      
    
end
