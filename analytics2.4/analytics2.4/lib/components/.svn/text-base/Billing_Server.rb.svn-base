                require 'drb'
                require 'dbi'
                require 'billing.rb'
                
                
                class Billing_Server
                  print "=> Booting Billing Engine. Please wait.."
                  sleep(1)
                  print "."
                  sleep(1)
                  print "."
                  sleep(1)
                  print ".\n"
                  
                  print "=> Billing Engine starting on http://0.0.0.0:8979"
                  #print "\n=> call with -d to detach"
                  #print "\n=> Ctrl-BREAK to shutdown engine."
                  print "\n=> Starting Billing Engine Listening at 0.0.0.0:8979"
                  print "\n=> Billing Engine loaded."
                  print "\n=> Billing engine will now try connecting the database. Please wait.."
                  report=nil
                  
                  sleep(1)
                  print "."
                  sleep(1)
                  print "."
                  sleep(1)
                  HOSTNAME="localhost"
                  USERNAME="root"
                  PASSWORD="admin"
                  DATABASE="DBI:MYSQL:zestadz_development:localhost"
                  
                  
                  def initialize
                    begin
                      @dbh = DBI.connect(DATABASE, USERNAME,PASSWORD)
                      print "\n** Succesfully connected to the database"
                      print "\n** Billing engine has been successfully started.\n"
                      @thread_count=0
                    rescue Exception=>e
                      puts "An Exception was thrown while connecting to the database"
                      print "\n** There was some problem connecting to the database. The cause may be the following: "+e.to_s
                      @dbh = DBI.connect(DATABASE, USERNAME,PASSWORD)
                      print "\n** Succesfully connected to the database"+e.to_s
                      print "\n** Reporting engine has been successfully started.\n"
                    end        
                  end
                  
                  def doBilling(publisher_id, ua, user_agent, ipaddress, remote_ip, campaign_id, ad_id, metrics, cost, ad_type, ad_client_type, keywords, sex, demographic, city, platform, dlr_id, user_id, client_id, delivery_time, software_version, region, country, fc_id, status, pay_status, cType, from_display)
                    Thread.new do
                        billing = Billing.new
                        billing.processBill(publisher_id, ua, user_agent, ipaddress, remote_ip, campaign_id, ad_id, metrics, cost, ad_type, ad_client_type, keywords, sex, demographic, city, platform, dlr_id, user_id, client_id, delivery_time, software_version, region, country, fc_id, status, pay_status, cType, from_display)
                        @thread_count=@thread_count+1
                        puts "Current Thread is #{@thread_count}"
		#puts Thread.list
                    end
                  end
                  
                end
                
                billingEngine = Billing_Server.new
                DRb.start_service('druby://localhost:8979', billingEngine)
                DRb.thread.join 
