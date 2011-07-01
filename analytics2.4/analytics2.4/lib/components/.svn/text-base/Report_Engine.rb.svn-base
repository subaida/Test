                require 'drb'
               
                
                require 'ZAd'
                require 'rubygems'
                require 'RMagick'
                require 'gruff'
                require 'fileutils'
                require 'active_record'  
                ActiveRecord::Base.establish_connection(  
                :adapter => "mysql",  
                :host => "192.168.1.4",  
                :database => "zestadz_development",
                :username => "root",
                :password => "sqlworx@ch"
                )
                class Addelivery < ActiveRecord::Base  
                end
                
                class Adsdelivery < ActiveRecord::Base  
                end
                #When the user chooses all clients and some particular month, then graph will be Sum of impressions for that particular month Vs Ad Client Name.
                #When the user chooses any particular client and a month, then graph will be Sum of impressions for every day of that particular month Vs Day of impression
                
                class Report_Engine
                  print "=> Booting Reporting Engine. Please wait.."
#                  sleep(1)
                  print "."
#                  sleep(1)
                  print "."
#                  sleep(1)
                  print ".\n"
                  
                  print "=> Reporting Engine starting on http://0.0.0.0:8879"
                  print "\n=> call with -d to detach"
                  print "\n=> Ctrl-BREAK to shutdown engine."
                  print "\n=> Starting Reporting Engine Listening at 0.0.0.0:8879"
                  print "\n=> Reporting Engine loaded."
                  print "\n=> Reporting engine will now try connecting the database. Please wait.."
                  report=nil
                  
#                  sleep(1)
                  print "."
#                  sleep(1)
                  print "."
#                  sleep(1)
                  
                  if not defined?(DEFAULT_THEME)
                    DEFAULT_THEME = { :colors => %w(#4e4e4d red),
                      :marker_color => 'black'
                    }
                  end
                  
                  TOP_MARGIN = 0.0
                  BOTTOM_MARGIN = 0.0
                  RIGHT_MARGIN = 0.0
                  LEFT_MARGIN = 0.0    
                  TITLE_MARGIN = 0.0
                  REPORT_SERVER_ERROR = -10
                  MONTH_HASH = {'Jan'=>1, 'Feb'=>2, 'Mar'=>3, 'Apr'=>4, 'May'=>5, 'June'=>6, 'July'=>7, 'Aug'=>8, 'Sep'=>9, 'Oct'=>10, 'Nov'=>11, 'Dec'=>12}
                  @@rails_root = ''
                  
                  HOSTNAME="mw22"
                  USERNAME="root"
                  PASSWORD="admin"
                  DATABASE="DBI:MYSQL:zestadz_development:mw22"
                  
                  
                  def initialize
                    begin
                      #@dbh = DBI.connect(DATABASE, USERNAME,PASSWORD)
                      print "\n** Succesfully connected to the database"
                      print "\n** Reporting engine has been successfully started.\n"
                      
                    rescue Exception=>e
                      puts "An Exception was thrown while connecting to the database"
                      print "\n** There was some problem connecting to the database. The cause may be the following: "+e.to_s
                      # @dbh = DBI.connect(DATABASE, USERNAME,PASSWORD)
                      print "\n** Succesfully connected to the database"+e.to_s
                      print "\n** Reporting engine has been successfully started.\n"
                    end        
                  end
                  
                  def setRailsRoot root
                    puts "now in the setting the rails root here."
                    puts @@rails_root = root
                  end
                  
                  def create_directory(path, dirname)
                    full_path = File.join(path, dirname)
                    FileUtils.mkdir full_path unless File.exists? full_path
                  end
                  
                  def create_if_missing *names
                    names.each do |name|FileUtils.mkdir(name) rescue nil unless File.directory?(name) end
                  end
                  
                  
                  #--------------------------------------------------------------------------------------------
                  #Method Name: clientPerformanceReport 
                  #Purpose: generates the client performance report
                  #Version: 1.0
                  #Author: Asghar Ali
                  #Last Modified: 09-Nov-2007 by Asghar Ali
                  #Notes: None
                  #--------------------------------------------------------------------------------------------
                  def clientPerformanceReport(month, year, typeOfReport, clientId, clientName, basedOn, orderBy, userId)
                    begin 
                      image_name = "client_performance_#{clientId}_#{typeOfReport}_#{month}_#{year}_#{basedOn}"
                      month_id = MONTH_HASH[month]
                      impressions = Array.new #for all clients, impressions will be calculate per month and for a particular adclient, it will be calculate per week      
                      labels = Array.new
                      label_hash = Hash.new
                      title = "Traffic of #{clientName} for the month of #{month}, #{year}"
                      axis_title = "#{basedOn}"
                      puts sql = "select sum(#{basedOn}) as #{basedOn}, dayofmonth(delivery_time) as day from adsdeliveries where client_id=#{clientId} and date_format(delivery_time, '%m')=#{month_id} and date_format(delivery_time, '%Y')=#{year} group by day"
                      #begin
                      # impressions_sql = @dbh.prepare(sql)
                      # impressions_sql.execute
                      #rescue Exception=>e
                      # puts "An Exception was thrown while executing the sql in client performance report"
                      # @dbh = DBI.connect(DATABASE, USERNAME,PASSWORD)
                      # #impressions_active=Addelivery.find_by_sql(sql)
                      # impressions_sql = @dbh.prepare(sql)
                      # impressions_sql.execute
                      #end
                      begin
                      @impressions_active=Adsdelivery.find_by_sql(sql)
                      rescue
                        Adsdelivery.establish_connection(  
                  :adapter => "mysql",  
                  :host => "192.168.1.4",  
                  :database => "zestadz_development",
                  :username => "root",
                  :password => "sqlworx@ch"
                  )
                        @impressions_active=Adsdelivery.find_by_sql(sql)
                      end
                      #impressions_sql = @dbh.prepare(sql)
                      #impressions_sql.execute
                      puts "the impressions size is #{@impressions_active.size}"
                      @impressions_active.each do |imp|
                        puts impressions << imp.impressions if basedOn=='impressions'
                        puts impressions << imp.clicks if basedOn=='clicks'
                        labels << imp.day
                      end
                      
                      # while row=impressions_sql.fetch do
                      #  impressions << row[0].to_i
                      # labels << row[1].to_s
                      # end
                      for i in 0...labels.size
                        label_hash[i] = labels[i].to_s
                      end
                      
                      create_directory("#{@@rails_root}/public/images/reports/", userId.to_s)
                      if(typeOfReport=='Line')
                        build_image image_name, userId, impressions, label_hash, title, axis_title, nil, 550, true 
                      elsif(typeOfReport=='Area')
                        build_land_chart image_name, userId, impressions, label_hash, axis_title, title, nil, 550
                      elsif(typeOfReport=='Pie')
                        build_pie_chart image_name, userId, impressions, label_hash, axis_title, title, nil,  550
                      elsif(typeOfReport=='Bar')
                        build_bar_chart image_name, userId, impressions, label_hash, axis_title, title, nil, 550
                      end
                      print "\nSuccesfully generated the client performance report"
                    rescue Exception=>e
                      puts "An Exception was thrown in Client Performance Report"
                    end
                  end
                  
                  #--------------------------------------------------------------------------------------------
                  #Method Name: revenueReport 
                  #Purpose: generates the revenue report
                  #Version: 1.0
                  #Author: Asghar Ali
                  #Last Modified: 09-Nov-2007 by Asghar Ali
                  #Notes: None
                  #--------------------------------------------------------------------------------------------
                  def revenueReport(month, year, typeOfReport, clientId, clientName, basedOn, orderBy, userId)
                    #begin
                    puts image_name = "revenue_report_#{clientId}_#{typeOfReport}_#{month}_#{year}_#{basedOn}"
                    month_id = MONTH_HASH[month]
                    amount = Array.new #for all clients, impressions will be calculate per month and for a particular adclient, it will be calculate per week      
                    labels = Array.new
                    label_hash = Hash.new
                    title = "Revenue of #{clientName} for the month of #{month}, #{year}"
                    axis_title = "Amount(in $)"
                    sql = "select sum(cost) as amount, dayofmonth(delivery_time) as day from adsdeliveries where client_id=#{clientId} and date_format(delivery_time, '%m')=#{month_id} and date_format(delivery_time, '%Y')=#{year} and #{basedOn}=1 group by day"
                    puts "publisher revenue report-----------#{sql}"
                    #begin
                    #amount_sql = @dbh.prepare(sql)
                    #amount_sql.execute
                    #rescue Exception=>e
                    # puts "An Exception was thrown while executing the sql in revenue report"
                    # @dbh = DBI.connect(DATABASE, USERNAME,PASSWORD)
                    #  amount_sql.execute
                    #end
                    begin
                      @impressions_active=Adsdelivery.find_by_sql(sql)
                    rescue
                      Adsdelivery.establish_connection(  
                :adapter => "mysql",  
                :host => "192.168.1.4",  
                :database => "zestadz_development",
                :username => "root",
                :password => "sqlworx@ch"
                )
                      @impressions_active=Adsdelivery.find_by_sql(sql)
                    end
                    #impressions_sql = @dbh.prepare(sql)
                    #
                    #impressions_sql.execute
                    
                    #amount=@impressions_active[0].amount.to_s
                    
                    
                    #note: remove this loop
                    @impressions_active.each do |imp|
                      amount << imp.amount.to_s
                      #impressions << imp.clicks if basedOn=='clicks'
                      labels << imp.day
                    end
                    
                    
                    #  while row=amount_sql.fetch do
                    #  amount << row[0].to_i
                    #  labels << row[1].to_s
                    #  end
                    for i in 0...labels.size
                      label_hash[i] = labels[i].to_s
                    end
                    
                    create_directory("#{@@rails_root}/public/images/reports/", userId.to_s)
                    if(typeOfReport=='Line')
                      build_image image_name,  userId, amount, label_hash, title,  axis_title, nil, 550, true 
                    elsif(typeOfReport=='Area')
                      build_land_chart image_name,  userId, amount, label_hash, title,  axis_title, nil, 550
                    elsif(typeOfReport=='Pie')
                      build_pie_chart image_name,  userId, amount, label_hash, title,  axis_title, nil,  550
                    elsif(typeOfReport=='Bar')
                      build_bar_chart image_name,  userId, amount, label_hash, title,  axis_title, nil, 550
                    end
                    print "\nSuccesfully generated the revenue report"
                    #rescue Exception=>e
                    # puts "An Exception was thrown in Revenue Report"
                    #end
                  end
                  
                  #--------------------------------------------------------------------------------------------
                  #Method Name: campaignPerformanceReport 
                  #Purpose: generates the campaign performance report
                  #Version: 1.0
                  #Author: Asghar Ali
                  #Last Modified: 09-Nov-2007 by Asghar Ali
                  #Notes: None
                  #--------------------------------------------------------------------------------------------
                  
                  def campaignPerformanceReport(month, year, typeOfReport, campaignId, campaignName, basedOn, orderBy, userId)
                    puts "campaign performance is coming here to get the details" 
                    #begin 
                      
                      puts image_name = "campaign_report_#{campaignId}_#{typeOfReport}_#{month}_#{year}_#{basedOn}"
                      
                      month_id = MONTH_HASH[month]
                      impressions = Array.new #for all campaign, impressions will be calculate per month and for a particular campaign, it will be calculate per week      
                      # clicks = Array.new #for all campaign, clicks will be calculate per month and for a particular campaign, it will be calculate per week      
                      labels = Array.new
                      label_hash = Hash.new
                      puts title = "Performance of #{campaignName} for the month of #{month}, #{year}"
                      puts axis_title = "#{basedOn}"
                      #  sql = "select sum(#{basedOn}) as #{basedOn}, dayofmonth(bill_date_time) as day from addeliveries where campaign_id=#{campaignId} and date_format(bill_date_time, '%m')=#{month_id} and date_format(bill_date_time, '%Y')=#{year} group by day"
                      # puts sql
                      #begin
                        #@dbh = DBI.connect(DATABASE, USERNAME,PASSWORD)
                        puts "executing sql before statement"
                        sql="select sum(#{basedOn}) as #{basedOn}, dayofmonth(delivery_time) as day from adsdeliveries where campaign_id=#{campaignId} and date_format(delivery_time, '%m')=#{month_id} and date_format(delivery_time, '%Y')=#{year} group by day"
                        puts "start------- #{sql}"
                        begin
                          @impressions_active=Adsdelivery.find_by_sql(sql)
                        rescue
                          Adsdelivery.establish_connection(  
                    :adapter => "mysql",  
                    :host => "192.168.1.4",  
                    :database => "zestadz_development",
                    :username => "root",
                    :password => "sqlworx@ch"
                    )
                          @impressions_active=Adsdelivery.find_by_sql(sql)
                        end
                        #impressions_sql = @dbh.prepare(sql)
                        #impressions_sql.execute
                        
                        @impressions_active.each do |imp|
                          impressions << imp.impressions if basedOn=='impressions'
                          impressions << imp.clicks if basedOn=='clicks'
                          labels << imp.day
                        end
                        #impressions_sql = @dbh.prepare(sql)
                        puts "running"
                        #impressions_sql.execute
                        puts "end"
                        #puts impressions_sql
                        puts "executing sql after statement"
                        
                        puts "executing while loop before statement"
                        #   sth.fetch do |row|
                        #  printf "ID: %d, Name: %s, Height: %.1f\n", row[0], row[1], row[2]
                        # end
                        #  sth.finish
                        
                        
                     # rescue Exception=>e
                      #  puts "An Exception was thrown while sure executing the sql in campaign report"+e.to_s
                        #     @dbh = DBI.connect(DATABASE, USERNAME,PASSWORD)
                        #    impressions_sql = @dbh.prepare(sql)
                        #   impressions_sql.execute
                     # end
                      ## puts "user id is coming here #{userId.to_s}"
                      #while row=impressions_sql.fetch do
                      #puts impressions << row[0].to_i
                      # puts labels << row[1].to_s
                      #end
                      puts "executing while loop after statement"
                      puts "user id is coming here #{userId.to_s}"
                      for i in 0...labels.size
                        label_hash[i] = labels[i].to_s
                      end
                      create_directory("#{@@rails_root}/public/images/reports/", userId.to_s)
                      if(typeOfReport=='Line')
                        puts "inside the function call"
                        build_image image_name, userId, impressions, label_hash, title, axis_title, nil, 550, true 
                        puts "inside the function after call"
                      elsif(typeOfReport=='Area')
                        build_land_chart image_name, userId, impressions, label_hash, title,  axis_title, nil, 550
                      elsif(typeOfReport=='Pie')
                        build_pie_chart image_name, userId, impressions, label_hash, title,  axis_title, nil,  550
                      elsif(typeOfReport=='Bar')
                        build_bar_chart image_name, userId, impressions, label_hash, title,  axis_title, nil, 550
                      end
                      print "\nSuccesfully generated the campaign performance report"
                    #rescue Exception=>e
                     # puts "An Exception was thrown in Campaign Performance Report"
                   # end
                  end
                  
                  
                  def build_image( imageName,  userId, data, labels, title, axis_title, maximum_value = nil, size = 485, hide_dots = false )
                    #begin
                    puts "build imagge function"
                    puts imageName
                    puts userId
                    puts "data for :"
                    puts data
                    puts "Label"
                    puts labels
                    puts title
                    puts"axis for line chart :"
                    puts axis_title
                    puts maximum_value
                    puts size
                    puts hide_dots
                    
                    
                    g = Gruff::Line.new( size )
                    g.maximum_value = maximum_value unless maximum_value.nil?
                    g.minimum_value = 0 unless maximum_value.nil?
                    
                    g.theme = {
                      :colors => ['#0077cc', '#0077cc', '#0077cc', '#0077cc', '#0077cc'],
                      :marker_color => 'black',
                      :background_colors => ['#FFFFFF', '#FFFFFF']
                    }
                    g.title = title
                    g.title_font_size = 24
                    g.data(axis_title,data)
                    g.labels = labels
                    g.write("#{@@rails_root}/public/images/reports/#{userId}/#{imageName}.png")                                
                    #rescue Exception=>e
                    #puts "An Exception was thrown while creating the line chart"
                    #end
                  end
                  
                  def build_pie_chart ( imageName,  userId, data, labels, title, axis_title, maximum_value = nil, size = '218x180')
                    #begin
                      g = Gruff::Pie.new(size)
                      g.title_font_size = 20
                      g.title = title
                      g.title_font_size = 24
                      g.theme = { :colors => %w(#fdf2e6 #fce5cf #fbd9bb #FFC18F #FFB479 #FFA764 #FF9A51 #FF8E3D #FF8329 #FE770E),
                        :marker_color => 'black', 
                        :background_colors => %w(#FFFFFF #FFFFFF) }
                      10.times do |i| 
                        g.data i, data[i] if data[i] 
                      end
                      g.write("#{@@rails_root}/public/images/reports/#{userId}/#{imageName}.png")
                   # rescue Exception=>e
                    #  puts "An Exception was thrown while creating the pie chart"
                   # end
                  end
                  
                  def build_land_chart ( imageName,  userId, data, labels, title, axis_title, maximum_value = nil, size = '218x180')
                    #begin
                      g = Gruff::Area.new(size)
                      g.minimum_value = 0 unless maximum_value.nil?
                      g.theme = { 
                        :colors => %w(#0077cc #0077cc #0077cc #0077cc #0077cc #0077cc #0077cc #0077cc #0077cc #0077cc #0077cc),
                        :marker_color => 'black', 
                        :background_colors => %w(#FFFFFF #FFFFFF) }
                      g.title = title
                      g.title_font_size = 24
                      g.data(axis_title, data)
                      g.labels = labels
                      g.write("#{@@rails_root}/public/images/reports/#{userId}/#{imageName}.png")                                         
                   # rescue Exception=>e
                     # puts "An Exception was thrown while creating the land chart"
                    #end
                  end
                  
                  
                  def build_bar_chart ( imageName,  userId, data, labels, title, axis_title, maximum_value = nil, size = '218x180')
                    begin
                      g = Gruff::Bar.new(size)
                      g.minimum_value = 0 unless maximum_value.nil?
                      g.theme = { 
                        :colors => %w(#0077cc #0077cc #0077cc #0077cc #0077cc #0077cc #0077cc #0077cc #0077cc #0077cc #0077cc),
                        :marker_color => 'black', 
                        :background_colors => %w(#FFFFFF #FFFFFF) }
                      g.title = title
                      g.title_font_size = 24
                      g.data(axis_title, data)
                      g.labels = labels
                      g.write("#{@@rails_root}/public/images/reports/#{userId}/#{imageName}.png")                                         
                    rescue Exception=>e
                     puts "An Exception was thrown while creating the bar chart"
                    end
                  end
                end
                
                reportEngine = Report_Engine.new
                DRb.start_service('druby://localhost:8879', reportEngine)
                DRb.thread.join 
