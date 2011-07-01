
puts "test librarary............."
require "will_paginate"
puts "test librarary ends............."



def paginate_by_sql1#(model, sql, per_page, options={})
  
  per_page=10
  sql="select device,requests,traffic from publisher_handset_overviews where publisher_id=283 and date='2011-06-05' group by device order by requests desc"
  options={}
  
  puts "paginate_by_sql....."
  begin
    if options[:count]
      if options[:count].is_a? Integer
        total = options[:count]
      else
        total = PublisherHandsetOverview.count_by_sql(options[:count])
      end
    else
      total = PublisherHandsetOverview.count_by_sql_wrapping_select_query(sql)
    end
    
    object_pages = Paginator.new self, total, per_page, params['page']
    #objects = model.find_by_sql_with_limit(sql,object_pages.current.to_sql[1], per_page)
    objects = PublisherHandsetOverview.find_by_sql(sql + " limit #{per_page} " +"offset #{object_pages.current.to_sql[1]}")
    return [object_pages, objects]
   rescue Exception=>e
          puts "testlib"+e.to_s
        end
      end    
      
      def check
        puts "hai"
      end