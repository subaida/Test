require 'drb'
require 'logger'
require 'billing.rb'
class BillServer
  def initialize(size)
    @@thread_pool=size
    @@pool = []
    @@thread_count=0
    @@store_data=[]
    @@count=0
    @logger = Logger.new('application.log')
    puts "Billing Server Initializing..."
    log_it("Billing Server Initializing.....")
    sleep(1)
    puts "Billing Server startted at port : 8979"
    log_it("Billing Server startted at port : 8979")
    puts "Finalizer is calling now"
    Thread.new do
    	finalize 
    end
  end
  
  #process the fifty simultaneous requests in this method to bill the advertiser and publisher
  #if the request goes beyond the fifty then it stores the requested datas into the array of hash variable
  def doBilling(publisher_id, ua, user_agent, ipaddress, remote_ip, campaign_id, ad_id, metrics, cost, ad_type, ad_client_type, keywords, sex, demographic, city, platform, dlr_id, user_id, client_id, delivery_time, software_version, region, country, fc_id, status, pay_status, cType, from_display)
    @@thread_count=@@thread_count+1
    puts "New Thread is created,thread count is "+@@thread_count.to_s
    #if the thread exceeding the limit of 100
    if @@thread_pool<=@@thread_count
      puts "Thread pool is full,the parameters are stored in hash variable "
      #log_it("Thread pool is full :method values are stored in array of has values variable")
      begin
        method_values=Hash.new
        method_values={:publisher_id=>publisher_id,:ua=>ua,:user_agent=>user_agent,:ipaddress=>ipaddress,:remote_ip=>remote_ip,:ad_id=>ad_id,:metrics=>metrics,:cost=>cost,:ad_type=>ad_type,:ad_client_type=>ad_client_type,:keywords=>keywords,:sex=>sex,:demographic=>demographic,:city=>city, :platform=>platform, :dlr_id=>dlr_id, :user_id=>user_id, :client_id=>client_id, :delivery_time=>delivery_time, :software_version=>software_version, :region=>region, :country=>country, :fc_id=>fc_id, :status=>status, :pay_status=>pay_status,:cType=> cType, :from_display=>from_display}
        store_values(method_values,@@count)
      rescue Exception=>e
        log_it("ERROR :: doBilling :: Exception is #{e.to_s}")
        puts "ERROR :: doBilling :: Exception is #{e.to_s}"
      end
    else
      #do the billing process
      #calling the billing class method in thread pool
      @@pool<< Thread.new do
        #puts "Processing the billing class method"
       # log_it("Processing the billing class method")
        
        #billing will happens here, we are calling the billing class method
        #and passing the billing datas 
        begin
          billing = Billing.new
        #  log_it("Billing method is processing...Publisher Id is  #{publisher_id} and Ad Id is #{ad_id}")
          billing.processBill(publisher_id, ua, user_agent, ipaddress, remote_ip, campaign_id, ad_id, metrics, cost, ad_type, ad_client_type, keywords, sex, demographic, city, platform, dlr_id, user_id, client_id, delivery_time, software_version, region, country, fc_id, status, pay_status, cType, from_display)
	if @@thread_count>0
	# log_it( "Thread count is "+@@thread_count.to_s)
          @@thread_count=@@thread_count-1
	end
          puts "Deleting the thread count after the billing process over"+@@thread_count.to_s
         # log_it("Deleting the thread count after the billing process over "+@@thread_count.to_s)
        rescue Exception=>e
          puts "ERROR ::  Exception in billing class calling block"
          log_it("ERROR ::  Exception in billing class calling block"+e.to_s)
        end
      end
    end
  end
  #store the method values to forward
  #method_values=[:publisher_id=>publisher_id,:ua=> ua,:user_agent=> user_agent,:ipaddress=> ipaddress,:remote_ip=> remote_ip, :campaign_id=>campaign_id, :ad_id=>ad_id, :metrics=>metrics, :cost=>cost, :ad_type=>ad_type, :ad_client_type=>ad_client_type, :keywords=>:keywords=>keywords, :sex=>sex, :demographic=>demographic, :city=>city, :platform>platform, :dlr_id=>dlr_id, :user_id=>user_id, :client_id=>client_id, :delivery_time=>delivery_time, :software_version=>software_version,:region=> region, :country=>country, :fc_id=>fc_id, :status=>status, :pay_status=>pay_status, :cType=>cType, :from_display=>from_display]
  def store_values(method_values,count)
   # log_it("Forwarded to store the method values in array of hash variable")
    
    #array of method value hashes
    @@store_data[count]=method_values
    @@count=@@count+1
    #verifying the stored billing datas
    @@store_data.each{|hash|
      #puts "INFO Stored method values are "#{hash[:obj]}"
    #  log_it("INFO Stored method values are #{@@store_data[count]}")
    }
  end
  #to recall the stored array of hash values and process the billing
  def finalize
	puts "Finalizer is calling within the finalizer method"    
        log_it("stored request data count is #{@@store_data.size}")
    #set the data to the billing clas method one by one
    for count in 0...@@store_data.size
      log_it("Finalize method values are "+"#{@@store_data[count]}" )
      #here we are calling the billing class method
      #bill_now
      #billing happens here for stored billing datas
     # log_it("billing process starting for stored array data")
      billing = Billing.new
      #method_values={:publisher_id=>publisher_id,:ua=>ua,:user_agent=>user_agent,:ipaddress=>ipaddress,:remote_ip=>remote_ip,:ad_id=>ad_id,:metrics=>metrics,:cost=>cost,:ad_type=>ad_type,:ad_client_type=>ad_client_type,:keywords=>keywords,:sex=>sex,:demographic=>demographic,:city=>city, :platform=>platform, :dlr_id=>dlr_id, :user_id=>user_id, :client_id=>client_id, :delivery_time=>delivery_time, :software_version=>software_version, :region=>region, :country=>country, :fc_id=>fc_id, :status=>status, :pay_status=>pay_status,:cType=> cType, :from_display=>from_display}
      #billing.processBill(publisher_id, ua, user_agent, ipaddress, remote_ip, campaign_id, ad_id, metrics, cost, ad_type, ad_client_type, keywords, sex, demographic, city, platform, dlr_id, user_id, client_id, delivery_time, software_version, region, country, fc_id, status, pay_status, cType, from_display)
      billing.processBill(@store_data[count][:publisher_id], @store_data[count][:ua] ,@store_data[count][:user_agent], @store_data[count][:ipaddress], @store_data[count][:remote_ip], @store_data[count][:campaign_id],@store_data[count][:ad_id], @store_data[count][:metrics], @store_data[count][:cost], @store_data[count][:ad_type],@store_data[count][:ad_client_type], @store_data[count][:keywords], @store_data[count][:sex], @store_data[count][:demographic], @store_data[count][:city], @store_data[count][:platform], @store_data[count][:dlr_id], @store_data[count][:user_id], @store_data[count][:client_id], @store_data[count][:delivery_time], @store_data[count][:software_version], @store_data[count][:region], @store_data[count][:country], @store_data[count][:fc_id], @store_data[count][:status], @store_data[count][:pay_status], @store_data[count][:cType], @store_data[count][:from_display])
      @@count=@@count-1
      @@store_data.delete_at(count)
      puts "Stored Data Size is #{@@store_data.size}"
      GC.start
    end
    
    
   # log_it("Reviewing threads status...")
   # log_it("evaluating each thread of#  #{@@thread_count} threads")
    @@pool.each  { |t|
      begin
        if t.status==false
         
      #    log_it("one thread is dead...#{t.inspect}")
	if @@thread_count>0
          @@thread_count=@@thread_count-1
#	  log_it(@@thread_count.to_s+"th Thread is dead")
	end
     #     log_it("Checking if this is terminated"+t.inspect)
          #t.terminate!
        end	
      rescue Exception=>e
        puts "ERROR :: finalize :: Exception occured" + e.to_s
        log_it("ERROR :: finalize :: Exception occured" + e.to_s)
      end
    }
    sleep(30)
    finalize 
  end
  #log the errors, informations and other execution stuffs      
  def log_it(message)
    @logger.info(message)
  end
  
end

billingEngine = BillServer.new(100)
DRb.start_service('druby://:8979', billingEngine)
DRb.thread.join   
