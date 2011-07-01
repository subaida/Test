require 'drb'
require 'billing.rb'
require 'logger'
class BillEngine
    def initialize(size)
        @@thread_pool=size
        @@pool = []
        @@thread_count=0
        @@store_data=Array.new
        @@count=0
        @logger = Logger.new('application.log')
        Thread.new do
            finalize
        end
    end
    def doBilling(publisher_id, ua, user_agent, ipaddress, remote_ip, campaign_id, ad_id, metrics, cost, ad_type, ad_client_type, keywords, sex, demographic, city, platform, dlr_id, user_id, client_id, delivery_time, software_version, region, country, fc_id, status, pay_status, cType, from_display)

         @@thread_count=@@thread_count+1
         @logger.info ("Thread count is #{@@thread_count}")
         if @@thread_pool<=@@thread_count
            begin
                method_values=Hash.new
		puts "STORED CAMPAIGN ID IS #{campaign_id}"
                method_values={:publisher_id=>publisher_id,:ua=>ua,:user_agent=>user_agent,:ipaddress=>ipaddress,:remote_ip=>remote_ip,:campaign_id=>campaign_id,:ad_id=>ad_id,:metrics=>metrics,:cost=>cost,:ad_type=>ad_type,:ad_client_type=>ad_client_type,:keywords=>keywords,:sex=>sex,:demographic=>demographic,:city=>city, :platform=>platform, :dlr_id=>dlr_id, :user_id=>user_id, :client_id=>client_id, :delivery_time=>delivery_time, :software_version=>software_version, :region=>region, :country=>country, :fc_id=>fc_id, :status=>status, :pay_status=>pay_status,:cType=> cType, :from_display=>from_display}
               # puts "Excessive values are #{method_values}"
                @logger.info ("Excessive values are #{method_values}")
                store_values(method_values,@@count)
              rescue Exception=>e
                @logger.error("ERROR :: doBilling :: Exception is #{e.to_s}")
                puts "ERROR :: doBilling :: Exception is #{e.to_s}"
              end
         else
            @@pool<< Thread.new do
                billing = Billing.new
                billing.processBill(publisher_id, ua, user_agent, ipaddress, remote_ip, campaign_id, ad_id, metrics, cost, ad_type, ad_client_type, keywords, sex, demographic, city, platform, dlr_id, user_id, client_id, delivery_time, software_version, region, country, fc_id, status, pay_status, cType, from_display)
                #@logger.info("Value is #{value}")
            end
            if @@thread_count>0
	        @@thread_count=@@thread_count-1
                puts "Deleting the thread count is #{@@thread_count}"
                @logger.info("Deleting the thread")
            end  
          #  if @@thread_pool<=@@thread_count
          #      finalize
          #  end
         end
    end
       
    def store_values(method_values,count)
       # puts "This is stored values #{method_values}"
        @logger.info("This is stored values #{method_values}")
	#storing the excessive data into array as hash 
        @@store_data<<method_values
        @@count=@@count+1
    end
      
    def finalize
      begin
        puts "This is finalize #{@@store_data.size}"
        @logger.info("This is finalize #{@@store_data.size}")
        #puts "This is inside the for loop to restart the stored values"
        @logger.info("This is inside the for loop to restart the stored values #{@@store_data}")
        if @@store_data.size>0
            hash_value=Hash.new
      	   # puts "After HASH Created Variable #{@@store_data.first}"
    	    #fetching the first record from the sored array of hash
           puts hash_value=@@store_data.first
	   # puts "After Assigning the stored value to the hash..........#{hash_value.class}"
            billing = Billing.new
	   # puts "After Billing class created for stored values #{hash_value}"  
            puts "CAMPAIGN ID IN FIONALIZER :::::::::::::::::::::::::::::#{hash_value[:campaign_id]}"
	    billing.processBill(hash_value[:publisher_id], hash_value[:ua] ,hash_value[:user_agent], hash_value[:ipaddress], hash_value[:remote_ip], hash_value[:campaign_id],hash_value[:ad_id], hash_value[:metrics], hash_value[:cost], hash_value[:ad_type],hash_value[:ad_client_type], hash_value[:keywords], hash_value[:sex], hash_value[:demographic], hash_value[:city], hash_value[:platform], hash_value[:dlr_id], hash_value[:user_id], hash_value[:client_id], hash_value[:delivery_time], hash_value[:software_version], hash_value[:region], hash_value[:country], hash_value[:fc_id], hash_value[:status], hash_value[:pay_status], hash_value[:cType], hash_value[:from_display])
	    #puts "AfterCalling Bill Method"
	    #assign nill value to the first record
            @@store_data[0]=nil
	    #puts "After assignin NIL Value"
            #puts @@store_data
	    #Re-arranging the stored array of hash values
            @@store_data.compact!
            #puts "After Compacting the Array Values"
            #puts @@store_data
            #puts "Stored Data Size is #{@@store_data.size}"
            if @@thread_count>0
		#decrement the thread count
                @@thread_count=@@thread_count-1
                @logger.error("Thread is deleting, current thread count is #{@@thread_count}")
            end
	    sleep(1)
	    finalize
         else
		puts "NO DATA STORED IN HASH CONTAINER" 
		sleep(10)	
		finalize
	 end
         
      rescue Exception=>e
        puts "ERROR :: Error in finalize"+e.to_s
        @logger.error("ERROR :: Error in finalize"+e.to_s)
        sleep(60)
        finalize
      end
    end
  end
  billingEngine = BillEngine.new(100)
  DRb.start_service('druby://:8979', billingEngine)
  DRb.thread.join
